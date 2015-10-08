@core = angular.module('App.core', [
  'templates'
  'ui.bootstrap'
  'restangular'
  'ngRoute'
  'ng-token-auth'
])
.config([
  '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider)->
    $routeProvider
    .when('/',
      templateUrl: "core/templates/index.html"
      controller: 'core.HomeCtrl as ctrl'
    )
    .when('/login',
      templateUrl: 'core/templates/login.html'
      controller: 'core.SessionCtrl as ctrl'
    )
    .when('/sign_up',
      templateUrl: 'core/templates/sign_up.html'
      controller: 'core.SignUpCtrl as ctrl'
    )
    .when('/settings'
      templateUrl: 'core/templates/settings.html'
      controller: 'core.SettingsCtrl as ctrl'
    )
])
.config([
  '$authProvider',
  ($authProvider)->
    $authProvider.configure
      apiUrl: '/api'
      handleTokenValidationResponse: (response)->
        _.merge Env.currentUser, response.data
])

