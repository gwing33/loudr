# User = require "../models/usersModel"
# Project = require "../models/projectsModel"
# Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"

helper = require "../helpers/_controller_helper"

# Dashboard
exports.index = (req, res, next) ->
  # See if logged in
  return res.send(401) unless req.session.user

  # Get list of projects if has any
  return res.send 
    success: true