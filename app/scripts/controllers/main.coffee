'use strict'

angular.module('acsApp')
    .controller 'MainCtrl', ($scope, resourceFactory) ->
        $scope.group = resourceFactory.getGroup()
        $scope.getUser = resourceFactory.getUser

    .controller 'PostCtrl', ($scope, resourceFactory) ->
        $scope.feed = resourceFactory.getFeed()

    .controller 'EventsCtrl', ($scope, resourceFactory) ->
        $scope.events = resourceFactory.getEvents()
        $scope.is_upcoming = (start_time) -> new Date(start_time) > new Date()
