exports.authentication_error = 
  success: false
  error: 'Not Authenticated'

exports.fail = (err) ->
  json =
    success: false
  json.error = err if err
  
  return json

exports.success = (project) ->
  json =
    project: project
    success: true

  return json