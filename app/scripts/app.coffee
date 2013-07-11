'use strict'

angular.module('acsApp', ['ngResource', 'ngSanitize'])
  .config ['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
    delete $httpProvider.defaults.headers.common["X-Requested-With"]
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'
  ]
