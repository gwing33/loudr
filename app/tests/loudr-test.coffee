assert = require "assert"
should = require "should"

describe 'Loudr API', () ->

  # Should create a user
  # Should validate a user login
  # Should find a user by ID
  # Should find all users
  # Should update a user
  # Should delete a user 
  require './user-test'

  # Should login as a user
  # Should Create a Project 
  # Should Find all Projects 
  # Should Find Project by ID 
  # Should Update a project 
  # Should Add User to Project 
  # Should Delete the Project 
  require './project-test'

  # Should prep for All Fan API calls
  # Should Create Fan 
  # Should Get all Fans 
  # Should Get Fan By ID 
  # Should Get Fan By Key/Email 
  # Should Update Fan 
  # Should Update Fan by Key/Email 
  # Should Delete Fan 
  require './fan-test'

  # Should prep
  # Should Create Notification 
  # Should Create Notification By Key/Email 
  # Should Get all Notifications 
  # Should Get all Notifications By Key/Email 
  # Should Get a Notification 
  # Should Get a Notification By Key/Email 
  # Should Update Notification 
  # Should Update Notification By Key/Email 
  # Should Delete a Notification 
  # Should Delete a Notification By Key/Email 
  # Should Cleanup 
  require './notification-test'