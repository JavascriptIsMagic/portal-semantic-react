gulp = require 'cake-gulp'
configure = require './configure.coffee'
browserify = require 'browserify'
watchify = require 'watchify'

module.exports = (config) ->
  task 'bundle', 'Bundles .cjsx with browserify', ->
    config = configure config
    args = debug: config.watch, entries: config.sources.entries
    if config.watch
      args[key] = value for own key, value of watchify.args when not key of args
    bundler = if config.watch then watchify browserify args else browserify args
    bundler = bundler.transform transform for transform in config.transforms or []
    bundler = bundler.plugin plugin for plugin in config.plugins or []
    bundler
      .on 'log', gulp.log.bind 'bundle'
      .on 'update', bundle = ->
        bundler
          .bundle()
          .on 'error', gulp.log.bind gulp.colors.red 'bundle'
          .pipe gulp.source "#{config.package.name}.bundle.js"
          .pipe gulp.buffer()
          .pipe gulp.dest config.sources.dist
          .pipe gulp.sourcemaps.init loadMaps: yes
            .pipe gulp.uglify()
            .pipe gulp.rename suffix: '.min'
          .pipe gulp.sourcemaps.write '.'
          .pipe gulp.size title: 'bundle', showFiles: yes, gzip: yes
          .pipe gulp.duration 'bundle'
          .pipe gulp.dest config.sources.dist
          .pipe gulp.gzip()
          .pipe gulp.dest config.sources.dist
    bundle()
