Project = require "../models/projectsModel"
mongoose = require "mongoose"
async = require "async"

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
  res.send 'hello'

exports.update_project = (req, res, next) ->
  res.send 'hello'

exports.disable_project = (req, res, next) ->
  res.send 'hello'

exports.delete_project = (req, res, next) ->
  res.send 'hello'