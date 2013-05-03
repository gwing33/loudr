# Loudr: Notification System

## Overview

This system is mean for other websites to add an easy way to communicate and interact with their customers.
By giving them a **"notification"** system, that can send updates an individual user or group of users with what is going on.


The goal is to increase the lifetime value of the customer by making them feel like they are welcome.
Another goal is to help with usability, sending notifications out based on maintence or site problems helps with UX.

### Compteitor list
- [Intercom.io](https://www.intercom.io): This is where I got my initial idea, the reason why I want to push forward instead of using them is because I feel they don't have an easy installation/setup process and it needs to be a bit more simplistic functionality.
- [My Intercom.io Site overview](https://www.evernote.com/shard/s55/sh/a2a31538-db37-4fb8-9cc3-a8a977684792/5ddcb63599aeb28b8e1edf9b43adcf3e)


### General Structure - [Rough Database Idea Sketches](https://www.evernote.com/shard/s55/sh/dc08a435-ae2a-4cad-9c40-649239ae5094/f2dc4b913bdd195871472f65221abbce)
- Users (People who pay for the application)
- Applications (Paying customers, and their different websites)
- App Users (An app's user base)
- App User Groups
- Notifications


### Key Features
- Dynamically Collect Application Users and Tags/Groups
- Dynamic fields for a user should also be doable. (Thank you schemaless DB)
- Scrape Social networks for user accounts.
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


### Storyboards
- Onboarding: See [Onboarding Storyboard](https://www.evernote.com/shard/s55/sh/e9f1c4ea-98e8-403c-8384-4d03dd802d2f/9d9d4945729486093ca3b338bf860381)
- Setup / Installation: See [Onboarding Storyboard](https://www.evernote.com/shard/s55/sh/e9f1c4ea-98e8-403c-8384-4d03dd802d2f/9d9d4945729486093ca3b338bf860381)
- Communicate
- User Management

### General Page Structure?
- Logged out Landing
- Dashboard (Logged in landing)
- Account
- Manage Users
- Communicate
- API
- Application Selection
- Auth (login, create, logout etc...)

Not sure how to communicate this, I'm drawing a storyboard to help with this.



#### Future Features
- Conditional Notifications (Auto Response sort of thing)
    - Example: New User Registered
    - Example: User visits page (x number of times?) -> send automated notification
    - Possibly link to automated notifications to an email?
- Optional user import feature
- Statistics Tracking
- Help / FAQ module? This might be a full on additional product
- Realtime instant messaging


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
- Ruff UI Design
- From Design, look further at how I want to structure the folders
- Get Feedback
- Figure out how to set up tests (mocha?)
- Look into redis, see if there is possible configuration



