loudr
=====

Notifications and Support system

I'll clean everything up once I get further along, but here's where I'm currently at.
The installation process isn't perfect.
The Module list is still being worked on.
The TODO list is pretty vague with what I want to do.
Rought DB Design sketched out, but need to just jump into MongoDB and start messing with it before I can really do anything.
Mongo is quite a different database structure than SQL.

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

## TODO
- Work a little harder on the file structure
- Learn MongoDB
- Figure out how to set up tests (mocha?)
- Look into redis, see if there is possible configuration

## Database Schema

Nothing is built yet, but if I were to do it in SQL it'd look something like the folloiwng:

[Rough Database Idea Sketch](https://www.evernote.com/pub/geraldroy/loudr)




