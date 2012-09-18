class Workflows

  constructor: (website)->
    @website = website

    return @

  parseJobRequest: (args, cb)->
    switch args.workflow
      when 'fastqc'
        @fastQc args, cb

      when 'ghettoVCB'
        GhettoVCB = require './GhettoVCB'
        backupInstance = new GhettoVCB @website
        backupInstance.processRequest args, cb

      else
        @website.log.out 'unknown workflow of type ' + args.workflow
        @website.log.out args

        cb({ msg: 'unknown workflow type of ' + args.workflow })

    return @

module.exports = Workflows