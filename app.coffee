http    = require 'http'

# Make sure this is current
VERSION = '0.3.4'

# libs
Website  = require './lib/Website'
Website.configure()

website = new Website (app)->
  http.createServer(app).listen app.get('port'), ()->
    console.log "ghettoVCB.js - Express server listening on port " + app.get 'port'

    website.setVersion VERSION
