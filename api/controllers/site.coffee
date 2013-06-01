User = require "../models/usersModel"
Project = require "../models/projectsModel"
Fan = require "../models/fansModel"
mongoose = require "mongoose"
async = require "async"
connect = require "connect"

exports.index = (req, res, next) ->
  res.send "hello"

exports.seed_fans = (req, res, next) ->
  new_fan = new Fan
    api_key: '4201d2e8bb26b1c1715bb6e421bb4a131e631603efc8498a4cc3cdc7baf95daa'
    email: 'gerald.leenerts+peon_seed@gamil.com'
    groups: ["Premium Member", "Facebook"]
    name:
      first: "Peon"
      last: "Poe"
    registered_date: "2013-05-17T17:32:00.171Z"

  new_fan.save (err, fan) ->
    return res.send 'Shit Fan already here' if err
    return res.send fan.toJson()


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
    return res.send 'Shit be here' if err
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

      new_project.save (err, project) ->
        seeds.push project.toJson()
        return res.send seeds