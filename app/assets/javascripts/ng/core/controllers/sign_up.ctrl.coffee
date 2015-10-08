class @core.SignUpCtrl
  core.controller 'core.SignUpCtrl', @

  @$inject: ['$scope', '$auth', '$location']
  constructor: ($scope, $auth, $location)->
    $scope.form = {}
    @register = ->
      $auth.submitRegistration($scope.form).then (data)->
        alertify.success('Sign up successfully!')
        $location.path('/')
      .catch (resp)->
        alertify.error(
          "Sign up finished with error! #{resp.data.errors.full_messages.join(".")}"
        )

