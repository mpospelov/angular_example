#= require_tree ./core

@app = angular.module('App', ['App.core'])

@app.config [
  'RestangularProvider'
  (RestangularProvider) ->
    RestangularProvider.setBaseUrl '/api'
]
