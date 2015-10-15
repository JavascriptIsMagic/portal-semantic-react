option '-w', '--watch', 'debug mode: watch files for incrimental changes.'
portal = require 'portal'
path = require 'path'

module.exports = (config) ->
  config = portal.configure config
  config.watch ?= gulp.options?.watch
  config.sources.entries = (path.resolve entry for entry in config.sources.entries or [path.resolve "#{config.sources.project}/src/#{config.package.name}.bundle.cjsx"])
  config.transforms ?= [require 'coffee-reactify', require 'babelify']
  config.plugins ?= []
  config
