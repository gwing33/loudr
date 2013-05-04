# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
    # Define Controllers
    siteController = require './controllers/site'
    userController = require './controllers/user'
    
    # Define Routes
    server.get '/', siteController.index

    server.get '/user/:email', userController.get_by_email
    server.post '/user/', userController.create