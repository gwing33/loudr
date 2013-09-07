api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects
  return res.status(401).send() unless req.session.user?

  api_proxy.get '/app/' + req.params.api_key + '/fan/', {}, false, (err, resp, body) ->
    return res.status(500).send 'error' if err

    # console.log resp
    res.status(resp.statusCode).send body