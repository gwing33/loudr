Project = require "../models/projectsModel"
User = require "../models/usersModel"
mongoose = require "mongoose"
async = require "async"

helper = require "../helpers/_controller_helper"

exports.get_all = (req, res, next) ->
  Project.getAll req.params.user_id, (err, projects) ->
    return res.send helper.fail(err) if err

    res.send helper.success 'projects', projects
  

exports.get_by_id = (req, res, next) ->
  # Get project from the req, which is placed there by the Auth stuff
  project = req.project
  
  res.send helper.success('project', project)

exports.create_project = (req, res, next) ->
  new_project = new Project
    name: req.body.name
    users: [
      user_id: req.params.user_id
      permission: Project.permissions.ADMIN
    ]
    info:
      creator: req.params.user_id
  
  new_project.api.is_secure = req.body.api.is_secure if req.body.api? and req.body.api.is_secure?
  
  new_project.api.key = Project.generateApiKey req.params.user_id
  new_project.save (err, project) ->
    return res.send helper.fail(err) if err
    res.send helper.success 'project', project

exports.update_project = (req, res, next) ->
  # Get project from the req, which is placed there by the Auth stuff
  project = req.project

  # Must be an authed user to edit the project
  return res.send(401)  unless project.authed_user req.params.user_id
  
  project.name = req.body.name  if req.body.name?

  project.disabled = req.body.disabled  if req.body.disabled?

  new_project.api.is_secure = req.body.api.is_secure  if req.body.api? and req.body.api.is_secure?

  if req.body.emails?
    User.getAllByEmails req.body.emails, (err, users) ->
      return res.send helper.fail err  if err

      for user in users
        project.users.push
          user_id: user._id
          permission: Project.permissions.MODERATOR
  
      project.save (err, project) ->
        return res.send helper.fail(err)  if err
        res.send helper.success 'project', project
  else # Because it wont save the users
    project.save (err, project) ->
      return res.send helper.fail err  if err
      res.send helper.success 'project', project

exports.delete_project = (req, res, next) ->
  # Get project from the req, which is placed there by the Auth stuff
  project = req.project
  
  project.remove()
  res.send
    success: true


exports.generate_hash = (req, res, next) ->
  Project.findById req.params.project_id, (err, project) ->
    obj = {
      api_key: project.api.key
      date: +new Date
    }
    obj.hash = auth.hashKey project.api.key, obj.date.toString()

    res.send obj

exports.generate_hash_date = (req, res, next) ->
  Project.findById req.params.project_id, (err, project) ->
    obj = {
      api_key: project.api.key
      date: req.params.date
    }
    obj.hash = auth.hashKey project.api.key, obj.date

    res.send obj