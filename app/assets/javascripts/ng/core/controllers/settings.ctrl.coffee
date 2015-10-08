class @core.SettingsCtrl
  core.controller 'core.SettingsCtrl', @

  @$inject: ['Restangular', '$scope']
  constructor: (Restangular, $scope)->
    @form = Env.currentUser
    @updateSettings = =>
      Restangular.oneUrl('user').patch(@form)
      .then (user)->
        _.merge Env.currentUser, user
        alertify.success("User settings successfully updated")
      .catch ->
        alertify.error("User updating finished with error")
