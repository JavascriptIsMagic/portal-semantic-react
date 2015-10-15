gulp = require 'cake-gulp'
configure = require './configure.coffee'

module.exports = (config) ->
  task 'build', 'Main build proccess, it handles all the things.', gulp.series 'bundle', (callback) ->
    config = configure config
    callback()
