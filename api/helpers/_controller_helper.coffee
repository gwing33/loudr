exports.authentication_error = 
  success: false
  error: 'Not Authenticated'

exports.fail = (err) ->
  json =
    success: false
  json.error = err if err
  
  return json

exports.success = (obj_name, obj) ->
  json =
    success: true

  json[name] = obj

  return json