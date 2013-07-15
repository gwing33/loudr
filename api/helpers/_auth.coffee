exports.auth_header = (header) ->
  return header.indexOf("Loudr asdf:") != -1

exports.get_user_id = (auth_token) ->
  tokens = auth_token.split ':'
  return tokens[1]