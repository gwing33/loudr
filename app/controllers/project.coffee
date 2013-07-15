api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects
  return res.status(401).send() unless req.session.user

  api_proxy.get '/project', {}, req.session.user._id, (err, resp, body) ->
    return res.send 'error' if err
    
    res.status(resp.statusCode).send body