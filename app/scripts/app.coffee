'use strict'

angular.module('acsApp', ['ngResource', 'ngSanitize', 'ngRoute', '$strap.directives', 'angularSpinner'])
    .factory('resourceFactory', ($resource) ->
        tokens = null
        feed = null
        events = null
        group = null
        users = {}
        $.ajax(
            url: 'http://austriancomputerscience.at/srv/tokens.php'
            async: false
            dataType: 'json'
            success: (msg) -> tokens = msg
        )
        Events = $resource('http://austriancomputerscience.at/srv/events.php')
        Feed = $resource('https://graph.facebook.com/552255311482154/feed', access_token: tokens.app)
        Group = $resource('https://graph.facebook.com/552255311482154/', access_token: tokens.app)
        User = $resource('https://graph.facebook.com/:userid')
        return (
            getUser: (id) ->
                if not users[id]
                    users[id] = User.get(userid: id, fields: 'picture')
                return users[id]
            getGroup: ->
                if not group
                    group = Group.get(null, ->
                        # workaround, atm link is not set in graph api response
                        group.link = 'https://www.facebook.com/groups/AustrianComputerScience/'
                    )
                return group
            getFeed: ->
                if not feed
                    feed = Feed.get()
                return feed
            getEvents: ->
                if not events
                    events = Events.get()
                return events
        )
    )
    .config ($routeProvider, $httpProvider) ->
        delete $httpProvider.defaults.headers.common["X-Requested-With"]
        $routeProvider
        .when '/',
            templateUrl: 'views/main.html'
            controller: 'PostCtrl'
        .when '/events',
            templateUrl: 'views/events.html'
            controller: 'EventsCtrl'
        .when '/about',
            templateUrl: 'views/about.html'
        .otherwise
            redirectTo: '/'
