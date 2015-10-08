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

]
