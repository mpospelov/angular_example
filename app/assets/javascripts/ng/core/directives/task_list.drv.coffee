@core.directive 'taskList', [
  '$compile', '$templateCache'
  ($compile, $templateCache) ->
    restrict: 'E'
    templateUrl: 'core/directives/task_list.html'
    scope:
      tasks: '=?'
      onDeleteTask: '&'
      onUpdateTask: '&'
    link: (scope, element) ->
      editTemplate = $compile($templateCache.get('core/templates/task_form.html'))
      scope.groupedTasks = {}
      scope.$watchCollection 'tasks', ->
        scope.groupedTasks = _.groupBy scope.tasks, (t)-> t.date
      scope.editTask = (task)->
        scope.updatedTask = task
        scope.form = {
          description: task.description
          duration: task.duration
          date: new Date(task.date)
        }
        scope.taskElement = element.find("#task-#{task.id}")
        scope.oldHtml = scope.taskElement.html()
        scope.taskElement.html(editTemplate(scope))
        true
      scope.updateTask = ->
        scope.onUpdateTask(task: scope.updatedTask, params: scope.form)
        innerScope = scope.$new()
        innerScope.task = scope.updatedTask
        scope.taskElement.html($compile(scope.oldHtml)(innerScope))
        true
      scope.prettyMinutes = (min)->
        moment().startOf('day').add(min,'minutes').format('HH:mm')
      scope.totalTime = _.memoize (tasks)->
        result = _.sum tasks, (t)-> t.duration
        scope.prettyMinutes(result)
      , (tasks)-> _.pluck(tasks, "id").join("-")

      scope.isSuccess = (prettyTime)->
        Env.currentUser.preferred_working_hours_per_day <= parseInt(prettyTime.split(':')[0])

      scope.tasksClass = (tasks)->
        if scope.isSuccess(scope.totalTime(tasks)) then 'success' else 'danger'
]
