mongoose = require "mongoose"

exports.create = (req, res, next) ->
    res.send "creating user..."

exports.get_by_email = (req, res, next) ->
    res.send "getting user: " + req.params.email