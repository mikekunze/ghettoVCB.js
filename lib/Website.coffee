class Website
  _instance = undefined

  @configure: ()->
    return @

  constructor: (cb) ->
    @settings = require '../settings'
    @username = 'undefined'

    Database   = require './Database'
    Log        = require './Log'
    JobManager = require './JobManager'
    FsMounts   = require './FsMounts'
    Workflows  = require './Workflows'

    @db         = new Database(@)
    @log        = new Log(@)
    @jobManager = new JobManager(@)
    @fsMounts   = new FsMounts(@)
    @workflows  = new Workflows(@)

    @configureApp(cb)
    return @

  configureApp: (cb)->
    @express  = require 'express'
    @app      = @express()

    Routes   = require './Routes'
    @routes  = new Routes(@)

    @app.set 'port', (process.env.PORT or 3069)
    @app.set 'views', __dirname + '/../views'
    @app.set 'view engine', 'jade'
    @app.use @express.favicon()
    @app.use @express.logger('dev')
    @app.use @express.bodyParser()
    @app.use @express.methodOverride()
    @app.use @express.cookieParser('your secret here')
    @app.use @express.session()
    @app.use @app.router
    @app.use @express.static(process.cwd() + '/public')

    @app.configure 'development', ()->
    @app.use @express.errorHandler()

    # DISPLAY SERVICES
    @app.get  '/',                        @routes.getIndex

    # JSON READ Services
    @app.get  '/ghettoVCB/getFiles',    @routes.getFiles
    @app.get  '/ghettoVCB/getScripts',  @routes.getScripts
    @app.get  '/ghettoVCB/readJobs',    @routes.readJobs

    # FORM Services
    @app.post '/ghettoVCB/submitJobs',  @routes.submitJobs

    # UserLand
    @whoAmI (username)=>
      @username = username
      console.log 'ghettoVCB.js - Hello ' + username + '. Welcome to scriptQueue ' + @version

      # Mount sshfs paths
      @fsMounts.doMount()

    cb(@app)
    return @

  whoAmI: (cb)->
    username = ''

    spawn = require('child_process').spawn
    child = spawn 'whoami', []

    child.stdout.setEncoding 'utf8'
    child.stdout.on 'data', (data)->
      username = data.trim()

    child.stdout.on 'end', ()->
      cb(username)

  setVersion: (v)->
    @version = v

module.exports = Website
