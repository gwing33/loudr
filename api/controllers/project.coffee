Project = require "../models/projectsModel"
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
      res.send
        success: false
        error: err

    tmp_project = project.toJson()
    tmp_project.success = true

    return res.send tmp_project

exports.create_project = (req, res, next) ->
  if req.session.user?
    new_project = new Project
      name: req.body.name
      users:
        user_id: req.session.user._id
        permission: Project.permissions.ADMIN
      info:
        creator: req.session.user._id
    
    new_project.api.key = Project.generateApiKey(req.session.user._id)
    new_project.save (err, project) ->
      return res.send fail(err) if err

      return res.send success project.toJson()
  else
    res.send authentication_error

exports.update_project = (req, res, next) ->
  res.send 'hello'

exports.disable_project = (req, res, next) ->
  res.send 'hello'

exports.delete_project = (req, res, next) ->
  res.send 'hello'