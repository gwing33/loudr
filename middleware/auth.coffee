exports.auth = (req, res, next) -> 
  unless req.session.user_id
    res.send('You are not authorized to view this page');
  else
    next()