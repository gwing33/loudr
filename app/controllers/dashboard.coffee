config = require "../../config"
request = require "request"

api_url = config.settings.api_host + ':' + config.settings.api_port

exports.index = (req, res) ->
  # Get all projects

  request.get api_url + '/project', (err, resp, body) ->
    return res.send 'error' if err

    res.status(resp.statusCode).send body