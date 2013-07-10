config = require "../../config"
request = require "request"

api_url = config.settings.api_host + ':' + config.settings.api_port

exports.index = (req, res) ->
  request.get api_url + '/', (err, resp, body) ->
    return res.send 'error' if err

    res.status(resp.statusCode).send body