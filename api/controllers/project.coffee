Project = require "../models/projectsModel"
User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"

auth = require "../helpers/_auth"
helper = require "../helpers/_controller_helper"

exports.get_all = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  auth.validateRequest req.headers, { loudr_only: true }, (err, is_valid) ->
    return res.send(401) unless is_valid
  
    Project.getAll req.params.user_id, (err, projects) ->
      return res.send helper.fail(err) if err

      res.send helper.success 'projects', projects
  

exports.get_by_id = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  auth.validateRequest req.headers, { project_id: req.params.id }, (err, project) ->
    if err is "Not Authorized"
      return res.send 401, helper.fail(err)
    else if err?
      return res.send 500, helper.fail(err)

    res.send helper.success('project', project)

exports.create_project = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  auth.validateRequest req.headers, { loudr_only: true }, (err, is_valid) ->
    return res.send(401) unless is_valid
    
    new_project = new Project
      name: req.body.name
      users: [
        user_id: req.params.user_id
        permission: Project.permissions.ADMIN
      ]
      info:
        creator: req.params.user_id
    
    new_project.api.is_secure = req.body.api.is_secure if req.body.api.is_secure?
    
    new_project.api.key = Project.generateApiKey req.params.user_id
    new_project.save (err, project) ->
      return res.send helper.fail(err) if err
      res.send helper.success 'project', project

exports.update_project = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  auth.validateRequest req.headers, { project_id: req.params.id }, (err, project) ->
    return res.send(401) if err?
    # return res.send helper.fail(err) if err

    # Must be an authed user to edit the project
    return res.send(401) unless project.authed_user req.params.user_id
    
    project.name = req.body.name if req.body.name?

    project.disabled = req.body.disabled if req.body.disabled?

    new_project.api.is_secure = req.body.api.is_secure if req.body.api.is_secure?
    
    if req.body.emails?
      User.getAllByEmails req.body.emails, (err, users) ->
        return res.send helper.fail err if err

        for user in users
          project.users.push
            user_id: user._id
            permission: Project.permissions.MODERATOR
    
        project.save (err, project) ->
          return res.send helper.fail(err) if err
          res.send helper.success 'project', project
    else # Because it wont save the users
      project.save (err, project) ->
        return res.send helper.fail err if err
        res.send helper.success 'project', project

exports.delete_project = (req, res, next) ->
  # This only needs to validate the loudr header
  # Because only the loudr site should be able to access this
  auth.validateRequest req.headers, { project_id: req.params.id }, (err, project) ->
    return res.send(401) if err?
    # return res.send helper.fail(err) if err

    # TODO: Must be an authed user to delete the project?
    # return res.send(401) unless project.authed_user req.params.user_id
    
    project.remove()
    res.send
      success: true