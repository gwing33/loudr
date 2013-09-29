assert = require "assert"
should = require "should"

describe 'Loudr API', () ->

  # Should create a user
  # Should validate a user login
  # Should find a user by ID 
  # Should find all users 
  # Should find all users with a limit 
  # Should update a user
  # Should delete a user
  require './user-test'

  # Should Prep
  # Should Create a Project 
  # Should Find all Projects 
  # Should Find Project by ID 
  # Should Find Project by ID *AUTH* 
  # Should Update a project 
  # Should Add User to Project 
  # Should Delete the Project 
  require './project-test'

  # Should prep
  # Should Create Fan 
  # Should Create Another Fan with full_name 
  # Should Get all Fans 
  # Should Get all Fans with limit 
  # Should Get Fan By Email 
  # Should Get Fan By ID Instead 
  # Should Update Fan by Email 
  # Should Delete Fan 
  # Should Delete 2nd Fan 
  require './fan-test'

  # Should prep
  # Should Create Notification
  # Should Get all Notifications
  # Should Get a Notification
  # Should Update Notification
  # Should Delete a Notification
  # Should Cleanup
  require './notification-test'