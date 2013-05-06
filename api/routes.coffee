# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
    # Define Controllers
    site_controller = require './controllers/site'
    user_controller = require './controllers/user'
    
    # Define Routes
    server.get '/', site_controller.index

    server.post '/user/', user_controller.create_user
    server.post '/auth/login', user_controller.login
    # server.get '/user/:email', user_controller.get_by_email
    