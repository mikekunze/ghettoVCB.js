class Log
  constructor: (website)->
    @website = website

    return @

  out: (string)->
    date = new Date()
    console.log date.toString() + ' - ' + string

module.exports = Log