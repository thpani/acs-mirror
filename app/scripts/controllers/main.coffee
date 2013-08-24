'use strict'

angular.module('acsApp')
    .controller 'MainCtrl', ($scope, resourceFactory) ->
        $scope.group = resourceFactory.getGroup()
        # workaround, atm link is not set in graph api response
        $scope.group.link = 'https://www.facebook.com/groups/AustrianComputerScience/'

        $scope.getUser = resourceFactory.getUser

    .controller 'PostCtrl', ($scope, resourceFactory) ->
        $scope.feed = resourceFactory.getFeed()

    .controller 'EventsCtrl', ($scope, resourceFactory) ->
        $scope.events = resourceFactory.getEvents()
