class @core.TasksCtrl
  core.controller 'core.TasksCtrl', @

  @$inject: ['$scope', 'Restangular', '$location']
  constructor: ($scope, Restangular, $location)->
    taskRest = Restangular.all('/tasks')
    @tasks = taskRest.getList().$object
    @deleteTask = (task)=>
      task.doDELETE().then =>
        _.remove(@tasks, (t)-> t.id == task.id)
        alertify.success("Task successfully deleted!")
      .catch ->
        alertify.error("Task deletion finished with error!")
    @newTaskForm = {}
    @createTask = =>
      taskRest.post(@newTaskForm)
      .then (task)=>
        @tasks.push(task)
        alertify.success("Task successfully created")
      .catch ->
        alertify.error("Task creation finished with error!")

    @updateTask = (task, params)->
      task.put(params)
      .then (new_attrs)->
        _.merge(task, new_attrs)
        alertify.success("Task successfully updated")
      .catch ->
        alertify.error("Task update finished with error!")
