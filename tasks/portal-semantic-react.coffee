module.exports = (config) ->
  tasks = [
    'bundle'
    'build'
  ]
  for task in tasks
    (require "./#{task}.task.coffee") config
