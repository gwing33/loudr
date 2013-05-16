Project = require "../models/projectsModel"
mongoose = require "mongoose"
async = require "async"

exports.get_project = (req, res, next) ->
  Project.getById req.params.id, (err, project) ->
    if err
      res.send
        success: false
        error: err

    tmp_project = project.toJson()
    tmp_project.success = true

    return res.send tmp_project

exports.create_project = (req, res, next) ->
  res.send 'hello'