Project = require "../models/projectsModel"
User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"

authentication_error = 
  success: false
  error: 'Not Authenticated'

fail = (err) ->
  json =
    success: false
  json.error = err if err
  
  return json

success = (project) ->
  json =
    project: project
    success: true

  return json

exports.get_all = (req, res, next) ->
  res.send 'hello'

exports.get_by_id = (req, res, next) ->
  Project.getById req.body.id, (err, project) ->
    if err
      return res.send
        success: false
        error: err

    tmp_project = project.toJson()
    tmp_project.success = true

    return res.send tmp_project

exports.create_project = (req, res, next) ->
  if req.session.user?
    new_project = new Project
      name: req.body.name
      users: [
        user_id: req.session.user._id
        permission: Project.permissions.ADMIN
      ]
      info:
        creator: req.session.user._id
    
    new_project.api.key = Project.generateApiKey(req.session.user._id)
    new_project.save (err, project) ->
      return res.send fail(err) if err

      return res.send success project.toJson()
  else
    res.send authentication_error

exports.update_project = (req, res, next) ->
  # Validate user is logged in
  if req.session.user?
    Project.getById req.params.id, (err, project) ->
      return res.send fail(err) if err

      if project.authed_user(req.session.user._id)
        project.name = req.body.name if req.body.name?

        if req.body.emails?
          User.getAllByEmails req.body.emails, (err, users) ->
            return res.send fail(err) if err

            for user in users
              project.users.push
                user_id: user._id
                permission: Project.permissions.MODERATOR

            project.save (err, project) ->
              return res.send fail(err) if err
              return res.send success project.toJson()
        else
          project.save (err, project) ->
            return res.send fail(err) if err
            return res.send success project.toJson()
      else
        return res.send fail('Permission Denied')
  else
    return res.send fail('Permission Denied')


exports.disable_project = (req, res, next) ->
  # Validate user is logged in
  if req.session.user?
    Project.getById req.params.id, (err, project) ->
      return res.send fail(err) if err

      if project.authed_user(req.session.user._id)
        project.disabled = true

        project.save (err, project) ->
          return res.send fail(err) if err
          return res.send success project.toJson()
      else
        return res.send fail('Permission Denied')
  else
    return res.send fail('Permission Denied')

exports.enable_project = (req, res, next) ->
  # Validate user is logged in
  if req.session.user?
    Project.getById req.params.id, (err, project) ->
      return res.send fail(err) if err

      if project.authed_user(req.session.user._id)
        project.disabled = false

        project.save (err, project) ->
          return res.send fail(err) if err
          return res.send success project.toJson()
      else
        return res.send fail('Permission Denied')
  else
    return res.send fail('Permission Denied')

exports.delete_project = (req, res, next) ->
  # Validate user is logged in
  if req.session.user?
    # Remove them
    Project.removeById req.params.id, req.session.user._id, (err, success) ->
      return res.send { success: !err }
  else
    return res.send fail('Permission Denied')