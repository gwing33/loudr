# Loudr: Notification System

## Overview

This system is mean for other websites to add an easy way to communicate and interact with their customers.
By giving them a **"notification"** system, that can send updates an individual user or group of users with what is going on.


The goal is to increase the lifetime value of the customer by making them feel like they are welcome.
Another goal is to help with usability, sending notifications out based on maintence or site problems helps with UX.


### General Structure - [Rough Database Idea Sketch](https://www.evernote.com/pub/geraldroy/loudr)
- Users (People who pay for the application)
- Applications (Paying customers, and their different websites)
- App Users (An app's user base)
- App User Groups
- Notifications


### Key Features
- Dynamically Collect Application Users
- Send Notifications to:
    - Individual Users
    - Group of Users
    - All Users
- Notification Functionality
    - Mark as **Seen**
    - Mark as **Interacted**
    - Mark as **Dissmissed**
    - Types:
        - General (Regular list notification)
        - Maintenance (Possibly same as alert?)
        - Alert


#### Additional future thoughts
- Realtime instant messaging
- Statistics Tracking
- Conditional Notifications
    - Example: New User Registered
    - Example: User visits page (x number of times?) -> send automated notification
    - Possibly link to automated notifications to an email?
- Help / FAQ module? This might be a full on additional product


## Installation
- Install git, on windows it's easiest to download the github gui.
- Install [Node.js](http://nodejs.org/)
- `git clone https://github.com/gwing33/loudr.git`
- `cd loudr`
- `npm install`
- From here I'm still in development, I have stuff runing i.e., `npm install -g node-dev` then you can `node-dev app.coffee` or `node-dev api.coffee`. But that might change.
- Ohh, also you need to install ruby, then `gem install sass` and `gem install compass`
- Oooohhhh, also run `grunt watch` in another terminal/shell and it'll update files.
- Also, should probably install MongoDB
- Maybe look into redis?



## Modules (Incomplete, see package.json for what's currently used.)
- mongoose
- passport
- restify
- ejs
- async
- request
- express
- grunt
- grunt-contrib-jshint
- grunt-contrib-compass
- grunt-contrib-uglify
- grunt-contrib-coffee
- grunt-contrib-concat
- grunt-contrib-nodeunit
- grunt-contrib-watch
- grunt-contrib-qunit
- node-dev
- bcrypt

## TODO
- List Key Functionality
- Ruff UI Design
- From Design, look further at how I want to structure the folders
- Get Feedback
- Figure out how to set up tests (mocha?)
- Look into redis, see if there is possible configuration



