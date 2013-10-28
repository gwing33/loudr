api_proxy = require "../api_proxy"

exports.index = (req, res) ->
  # Get all projects
  api_proxy.get '/user/' + req.session.user._id + '/project', {}, false, (err, resp, body) ->
    return res.send 'error' if err
    
    res.status(resp.statusCode).send body

exports.create = (req, res) ->
  # Get all projects
  post_data =
    form:
      name: req.body.name

  api_proxy.post '/user/' + req.session.user._id + '/project', post_data, false, (err, resp, body) ->
    return res.send 'error' if err
    
    res.status(resp.statusCode).send body