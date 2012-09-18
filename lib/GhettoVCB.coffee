class GhettoVCB

  constructor: (website)->
    @website = website

    return @

  processRequest: (args, cb)->

    @createConfig args, ()=>
      @deployGhettoBackup args, ()=>
        @cleanUp args, ()=>
          cb()

    return @

  createConfig: (args, cb)->
    @website.log.out 'creating config file on ' + @website.settings.defaultHost

    configString = 'VM_BACKUP_VOLUME='            + args.vm_backup_volume            + '\n' +
                   'DISK_BACKUP_FORMAT='          + args.disk_backup_format          + '\n' +
                   'VM_BACKUP_ROTATION_COUNT='    + args.vm_backup_rotation_count    + '\n' +
                   'POWER_VM_DOWN_BEFORE_BACKUP=' + args.power_vm_down_before_backup + '\n' +
                   'ENABLE_HARD_POWER_OFF='       + args.enable_hard_power_off       + '\n' +
                   'ENABLE_COMPRESSION='          + args.enable_compression          + '\n' +
                   'SNAPSHOT_TIMEOUT='            + args.snapshot_timeout            + '\n' +
                   'EMAIL_LOG='                   + args.email_log                   + '\n' +
                   'EMAIL_DEBUG='                 + args.email_debug                 + '\n' +
                   'EMAIL_SERVER='                + args.email_server                + '\n' +
                   'EMAIL_SERVER_PORT='           + args.email_server_port           + '\n' +
                   'EMAIL_DELAY_INTERVAL='        + args.email_delay_interval        + '\n' +
                   'EMAIL_TO='                    + args.email_to                    + '\n' +
                   'EMAIL_FROM='                  + args.email_from                  + '\n'

    fs = require 'fs'

    fs.writeFile process.cwd() + '/ghettoVCB/ghettoVCB.js.conf', configString, (err)=>
      if err
        @website.log.out err

      fs.writeFile process.cwd() + '/ghettoVCB/vms_to_backup.conf', args.vms_to_backup, (err)=>
        if err
          @website.log.out err

        cb()

    return @

  deployGhettoBackup: (args, cb)->
    @website.log.out 'deploying ghetto backup script on ' + @website.settings.defaultHost

    sshCmdObj =
      cmd: 'ssh',
      runParams: [
        'root@' + @website.settings.defaultHost,
        @website.settings.scriptPath + '/ghettoVCB.sh',
        '-f ' + @website.settings.scriptPath + '/vms_to_backup.conf',
        '-g ' + @website.settings.scriptPath + '/ghettoVCB.js.conf'
      ]

    # Time for a reference to our mongoose model
    Jobs = @website.db.mongoose.model 'jobs'

    spawn = require('child_process').spawn
    ghettoChild = spawn sshCmdObj.cmd, sshCmdObj.runParams

    job = new Jobs
      pid: ghettoChild.pid
      running: true
      stdout: '',
      scriptName: sshCmdObj.cmd
      startTime: Date.now()

    job.save (err)=>
      if err
        @website.log.out err
      else
        @website.log.out 'job information for ghettoVCB.js backup job saved to mongodb'

    ghettoChild.stdout.setEncoding 'utf8'
    ghettoChild.stderr.setEncoding 'utf8'

    ghettoChild.stdout.on 'data', (data)=>
      Jobs.findOne { pid: ghettoChild.pid }, (err, job)=>
        if err
          @website.log.out err

        job.stdout += data

        job.save (err)=>
          if err
            @website.log.out err

    ghettoChild.stderr.on 'data', (data)=>
      Jobs.findOne { pid: ghettoChild.pid }, (err, job)=>
        if err
          @website.log.out err

        job.stdout += data

        job.save (err)=>
          if err
            @website.log.out err

          else
            @website.log.out 'ghettoChild stderr data meta-data ' + data

    ghettoChild.stderr.on 'end', (data)=>
      Jobs.findOne { pid: ghettoChild.pid }, (err, job)=>
        if err
          @website.log.out err

        if data
          job.stdout += data

          job.save (err)=>
            if err
              @website.log.out err

            else
              @website.log.out 'ghettoChild stderr END'

    ghettoChild.stdout.on 'end', (data)=>
      Jobs.findOne { pid: ghettoChild.pid }, (err, job)=>
        if err
          @website.log.out err

        if data
          job.stdout += data

          job.save (err)=>
            if err
              @website.log.out err

            else
              @website.log.out 'ghettoVCB stdout END'

    ghettoChild.stderr.on 'end', ()=>
      @website.log.out 'ghettoVCB backup process stderr ends'
    ghettoChild.stdout.on 'end', ()=>
      @website.log.out 'ghettoVCB backup process stdout ends'

    # We will need to kick off the cp process on this event
    ghettoChild.on 'exit', (code, signal)=>
      @website.log.out 'backup process has exited'

      Jobs.findOne { pid: ghettoChild.pid }, (err, job)=>
        if err
          @website.log.out err

        job.endTime = Date.now()
        job.running = false

        job.save (saveErr)=>
          if saveErr
            @website.log.out saveErr

          else
            @website.log.out 'ghettoVCB stdout END'

    cb()

  cleanUp: (args, cb)->
    @website.log.out 'ghettoVCB cleanup'
    cb()

module.exports = GhettoVCB