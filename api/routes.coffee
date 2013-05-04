# This file maps your route matches
# to functions defined in various
# controller classes
exports.site = (server) ->
    siteController = require './controllers/site'    
    
    server.get '/', siteController.index