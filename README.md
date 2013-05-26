# Loudr: Notification System

## Overview

This system is mean for other websites to add an easy way to communicate and interact with their customers.
By giving them a **"notification"** system, that can send updates an individual user or group of users with what is going on.


The goal is to increase the lifetime value of the customer by making them feel like they are welcome.
Another goal is to help with usability, sending notifications out based on maintence or site problems helps with UX.

See my [Evernote Notebook](https://www.evernote.com/pub/geraldroy/loudr) to see all notes/sketches.

### Compteitor list
- [Intercom.io](https://www.intercom.io): This is where I got my initial idea, the reason why I want to push forward instead of using them is because I feel they don't have an easy installation/setup process and it needs to be a bit more simplistic functionality.
- [Intercom.io Site overview](https://www.evernote.com/shard/s55/sh/a2a31538-db37-4fb8-9cc3-a8a977684792/5ddcb63599aeb28b8e1edf9b43adcf3e)


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
- [Onboarding](https://www.evernote.com/shard/s55/sh/e9f1c4ea-98e8-403c-8384-4d03dd802d2f/9d9d4945729486093ca3b338bf860381)
- [Setup / Installation](https://www.evernote.com/shard/s55/sh/e9f1c4ea-98e8-403c-8384-4d03dd802d2f/9d9d4945729486093ca3b338bf860381)
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


## API TODO
- Project (User created)
    - Edit Project
    - Disable Project
    - Delete Project
    - Allow multiple users to an app
- Fans (Belong to Projects)
    - Create
    - Delete
    - Edit
    - Groups
        - Add
        - Remove
    - Get app users by tag
    - Notifications
        - Get a list of notifications
        - If user doesn't exist, create an App User
        - Edit
        - Create
        - Delete
        - Mark as seen, interacted, dismissed
- User Permissions
    - Superuser Ability

## APP TODO
- Design Frontend
- Client side script
- Beta Collection
- API Documentation

## Marketing TODO
- Live Chat / Contact
- Twitter
- G+
- Facebook
- Blog
- Sitemap
- PPC Campaign
- SEO Silo's
- Find Competitors
- Terminology

## Server Setup TODO
- Buy Domain Name
- Get hosting
- Set up staging
- Set up deploy
- Run tests

## Other TODO
- Product Life-Cycle Management: <a href='http://en.wikipedia.org/wiki/Product_life-cycle_management_(marketing)'>PLCM</a>






