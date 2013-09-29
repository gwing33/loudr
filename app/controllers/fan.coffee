api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects
  return res.status(401).send() unless req.session.user?
  
  req.session.user.current_key = req.query.key if req.query.key?

  api_proxy.get '/project/' + req.params.id + '/fan/', {}, req.session.user.current_key, (err, resp, body) ->
    return res.status(500).send 'error' if err

    res.status(resp.statusCode).send body