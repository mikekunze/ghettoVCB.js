class FsMounts

  constructor: (website)->
    @website = website

    # Make sure we have our mount point
    fs = require 'fs'
    fs.mkdir './ghettoVCB'

    return @

  doMount: ()->

    @autoMount @website.settings.scriptPath

    return @

  autoMount: (mountName)->
    @isMounted mountName, (status)=>
      if status is false
        @website.log.out 'mounting ' + mountName
        spawn = require('child_process').spawn

        runParams = [
          'root@' + @website.settings.defaultHost + ':' + mountName,
          process.cwd() + '/ghettoVCB'
        ]

        child = spawn 'sshfs', runParams

        child.stderr.setEncoding 'utf8'
        child.stdout.setEncoding 'utf8'

        child.stdout.on 'data', (data)=>
          @website.log.out data

        child.stderr.on 'data', (data)=>
          @website.log.out 'STDERR:' + data

        child.on 'exit', (code, signal)=>
          if code > 0
            @website.log.out 'error on sshfs mounting, terminating...'
            process.exit()

  isMounted: (mountName, cb)->
    spawn = require('child_process').spawn

    runParams = [
      '-q',
      process.cwd() + '/ghettoVCB'
    ]

    child = spawn 'mountpoint', runParams
    child.on 'exit', (code, signal)->
      if code <= 0
        cb(true)
      else
        cb(false)

    return @

module.exports = FsMounts