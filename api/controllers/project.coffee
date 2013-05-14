Project = require "../models/projectModel"
mongoose = require "mongoose"
async = require "async"

exports.create_project = (req, res, next) ->