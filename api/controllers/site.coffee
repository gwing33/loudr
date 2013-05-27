User = require "../models/usersModel"
Project = require "../models/projectsModel"
mongoose = require "mongoose"
async = require "async"
connect = require "connect"

exports.index = (req, res, next) ->
  res.send "hello"

exports.seed = (req, res, next) ->
  seeds = []
  main_user = {}

  new_user = new User
    email: 'gerald.leenerts@gmail.com'
    name:
      first: 'Gerald'
      last: 'Leenerts'
    password: 'glee123'
  
  new_user2 = new User
    email: 'gerald.leenerts+peon@gmail.com'
    name:
      first: 'Bob'
      last: 'Frank'
    password: 'twofirstnames'

  # save user to database
  new_user.save (err, user) ->
    return res.send 'Shit, already here' if err
    main_user = user.toJson()
    seeds.push main_user

    new_user2.save (err, user2) ->
      seeds.push user2.toJson()

      new_project = new Project
        name: 'My Awesome Project'
        api:
          key: Project.generateApiKey(main_user._id)
        users: [
          permission: Project.permissions.ADMIN
          user_id: main_user._id
        ]
        info:
          creator:  main_user._id
      
      console.log new_project, Project.permissions.ADMIN

      new_project.save (err, project) ->
        seeds.push project.toJson()

        return res.send seeds      