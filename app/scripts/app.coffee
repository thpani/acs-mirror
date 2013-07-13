'use strict'

angular.module('acsApp', ['ngResource', 'ngSanitize'])
  .config ['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
    delete $httpProvider.defaults.headers.common["X-Requested-With"]
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'PostCtrl'
      .when '/events',
        templateUrl: 'views/events.html'
        controller: 'EventsCtrl'
      .otherwise
        redirectTo: '/'
  ]
