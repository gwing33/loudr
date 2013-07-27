api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects
  return res.status(401).send() unless req.session.user

  api_proxy.get '/project', {}, req.session.user._id, (err, resp, body) ->
    return res.send 'error' if err
    
    res.status(resp.statusCode).send body

exports.create = (req, res) ->
  # Get all projects
  return res.status(401).send() unless req.session.user

  post_data =
    form:
      name: req.body.name

  api_proxy.post '/project', post_data, req.session.user._id, (err, resp, body) ->
    return res.send 'error' if err
    
    res.status(resp.statusCode).send body