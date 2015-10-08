class @core.SessionCtrl
  core.controller 'core.SessionCtrl', @

  @$inject: ['$rootScope','$scope', '$auth', '$location']
  constructor: ($rootScope, $scope, $auth, $location)->
    $scope.form = {}
    @login = ->
      if !$scope.user.signedIn
        $auth.submitLogin($scope.form).then (user)->
          alertify.success('Logined successfully!')
          _.merge(Env.currentUser, user)
          $location.path('/')
        .catch (resp)->
          alertify.error(
            "Log in finished with error! #{resp.errors.join(".")}"
          )
      else
        alertify.error("Already logined!")
    @logout = ->
      $auth.signOut()
      .then ->
        alertify.success("Signed out successfully!")
        $location.path('/')
      .catch ->
        alertify.error("Sign out is finished with error!")
