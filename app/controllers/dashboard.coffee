api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects

  api_proxy.get '/project', {}, (err, resp, body) ->
    return res.send 'error' if err

    res.status(resp.statusCode).send body