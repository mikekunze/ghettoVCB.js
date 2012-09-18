class JobManager

  constructor: (website)->
    @website = website

    return @

  getJobHistory: (cb)=>

    Jobs = @website.db.mongoose.model 'jobs'

    Jobs.find({}).sort('field -startTime').execFind (err, jobs)=>
      if err
        @website.log.out err

      @website.log.out 'jobManager readJobs executed'

      cb
        items: jobs
        results: jobs.length

  queueScript: (args, cb)=>

    # Determine the type of workflow
    @website.workflows.parseJobRequest args, (err)=>
      if err
        cb({success: false, msg: err.msg })
      else
        @website.log.out 'jobManager queued jobs'
        cb({success: true,  msg: 'workflow ' + args.workflow + ' kicked off'})

      return @

module.exports = JobManager
