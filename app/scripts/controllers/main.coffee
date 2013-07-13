'use strict'

angular.module('acsApp')
    .controller 'MainCtrl', ($scope, $resource, $q) ->
        Tokens = $resource('http://localhost:8080/acs/tokens.php')
        deferred = $q.defer()
        $scope.tokenPromise = deferred.promise
        tokens = Tokens.get(null, ->
            deferred.resolve(tokens)
            Group = $resource('https://graph.facebook.com/552255311482154/', access_token: tokens.app)
            $scope.group = Group.get(null, ->
                # workaround, temporarily (?) not in graph api response
                $scope.group.link = "https://www.facebook.com/groups/AustrianComputerScience/"
            )
        )
        User = $resource('https://graph.facebook.com/:userid')
        $scope.getUser = (id) -> User.get(userid: id, fields: 'picture')

    .controller 'PostCtrl', ($scope, $resource) ->
        $scope.tokenPromise.then((tokens) ->
            Feed = $resource('https://graph.facebook.com/552255311482154/feed', access_token: tokens.app)
            $scope.feed = Feed.get()
        )

    .controller 'EventsCtrl', ($scope, $resource) ->
        $scope.tokenPromise.then((tokens) ->
            Events = $resource('https://graph.facebook.com/552255311482154/events', access_token: tokens.user)
            $scope.events = Events.get()
        )
