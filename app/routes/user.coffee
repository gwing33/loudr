config = require "../../config"
http = require "http"

exports.login = (req, res) ->
  post_data = JSON.stringify
    email: req.body.email
    password: req.body.password

  options =
    host: config.settings.api_host,
    port: config.settings.api_port,
    path: '/auth/login',
    method: 'POST'
    headers:
      'Accept': 'application/json'
      'Content-Type': 'application/x-www-form-urlencoded'
      'Content-Length': post_data.length

  api_req = http.request options, (api_res) ->
    api_res.setEncoding 'utf8'
    api_res.on 'data', (json) ->
      req.session.user_id = 123 if json.success

      res.send json

  api_req.on 'error', (e) ->
    console.log 'problem with request: ' + e.message
    res.send 'error'

  # write data to request body
  api_req.write post_data
  api_req.end()

exports.logout = (req, res) ->
  delete req.session.user_id