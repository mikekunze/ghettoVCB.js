class Database

  constructor: (website)->
    @website = website

    @mongoose = require 'mongoose'
    @mongoose.connect @website.settings.dbHost, (err)->
      if err
        console.log err

    @defineModels()

    return @

  defineModels: ()->
    Schema   = @mongoose.Schema
    ObjectId = @mongoose.ObjectId

    @mongoose.model 'jobs', new Schema
      scriptName:
        type: String
      pid:
        type: Number
      stdout:
        type: String
      running:
        type: Boolean
      startTime:
        type: Date
      endTime:
        type: Date

    console.log 'ghettoVCB.js - Database.defineModels() - Models defined'

    return @

module.exports = Database