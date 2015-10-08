@core.filter 'tasksFilter', ->
  (groupedTasks, from, to) ->
    if !from? || !to? then return groupedTasks
    _.reduce groupedTasks, (result, tasks, str_date)->
      if moment(str_date).isBetween(from, to)
        result[str_date] = tasks
      result
    , {}

