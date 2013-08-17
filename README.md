# Loudr: Notification System

## Overview

This system is meant for other websites to add an easy way to communicate and interact with their customers.
By giving them a **"notification"** system, that can send updates an individual user or group of users.


The goal is to increase the lifetime value of the customer by making them feel like they are welcome.
Another goal is to help with usability, sending notifications out based on maintence or site problems helps with UX.

See my [Evernote Notebook](https://www.evernote.com/pub/geraldroy/loudr) to see all notes/sketches.

### Services / Hosting
- [OpenShift](https://openshift.redhat.com)
- [iwantmyname](iwantmyname.com)
- [RedisToGo](https://redistogo.com)
- [MongoHQ](https://www.mongohq.com/home)


### Compteitor list
- [Intercom.io](https://www.intercom.io): This is where I got my initial idea, the reason why I want to push forward instead of using them is because I feel they don't have an easy installation/setup process and it needs to be a bit more simplistic functionality.
- [Intercom.io Site overview](https://www.evernote.com/shard/s55/sh/a2a31538-db37-4fb8-9cc3-a8a977684792/5ddcb63599aeb28b8e1edf9b43adcf3e)


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


#### Future Features
- Auto Responders
    - Example: New User Registered
    - Example: User visits page (x number of times?) -> send automated notification
    - Possibly link automated notifications to an email?
- Statistics Tracking
- Help / FAQ module? This might be a full on additional product
- Realtime instant messaging


## Terminology
- Users: Loudr subscriber
- Project: User's application
- Fans: Project users
- Notifications: Notifications sent to users.


## Installation
- Install git
- Install Ruby
- `gem install sass`
- `gem install compass`
- Install and start up [MongoDB](http://www.mongodb.org/)
- Install and start up [Redis](http://redis.io/)
- Install [Node.js](http://nodejs.org/)
- `git clone https://github.com/gwing33/loudr.git`
- `cd loudr`
- `npm install`
- modify config.coffee with your db settings
- `npm start`


## TODOs
Moved to Milestones / Issue list in GitHub


## Other Thoughts
- Product Life-Cycle Management: <a href='http://en.wikipedia.org/wiki/Product_life-cycle_management_(marketing)'>PLCM</a>
