class Routes
  constructor: (website)->
    @website = website

    return @

  getIndex: (req, res)->
    settings = require '../settings'

    indexConfig =
      title:         'scriptQueue'
      dataPath:      settings.dataPath
      scriptPath:    process.cwd() + '/ghettoVCB'
      vms_to_backup: settings.vms_to_backup
      defaultHost:   settings.defaultHost

    res.render 'index', indexConfig

    return @

  readJobs: (req, res)=>
    @website.jobManager.getJobHistory (jobs)->
      res.send jobs

  submitJobs: (req, res)=>
    @website.jobManager.queueScript req.body, (response)=>
      res.send response

    return @

module.exports = Routes
