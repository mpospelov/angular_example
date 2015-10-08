@core = angular.module('App.core', [
  'templates'
  'ui.bootstrap'
  'restangular'
  'ngRoute'
]).config [
  '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider)->
    $routeProvider
    .when('/',
      templateUrl: "core/templates/index.html"
      controller: 'core.HomeCtrl'
    )
    .when('/login', templateUrl: 'core/templates/login.html')
    # .when('/Book/:bookId/ch/:chapterId', {
    #   templateUrl: 'chapter.html',
    #   controller: 'ChapterController'
    # });

    # // configure html5 to get links working on jsfiddle
    $locationProvider.html5Mode(true)
]
