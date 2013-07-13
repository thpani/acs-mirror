'use strict'

angular.module('acsApp', ['ngResource', 'ngSanitize'])
    .factory('resourceFactory', ($resource) ->
        tokens = null
        $.ajax(
            url: 'http://forsyte.at/acs/srv/tokens.php'
            async: false
            dataType: 'json'
            success: (msg) -> tokens = msg
        )
        return (
            Events: $resource('http://forsyte.at/acs/srv/events.php')
            Feed: $resource('https://graph.facebook.com/552255311482154/feed', access_token: tokens.app)
            Group: $resource('https://graph.facebook.com/552255311482154/', access_token: tokens.app)
            User: $resource('https://graph.facebook.com/:userid')
        )
    )
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
