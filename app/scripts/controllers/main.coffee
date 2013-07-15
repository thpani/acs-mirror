'use strict'

angular.module('acsApp')
    .controller 'MainCtrl', ($scope, resourceFactory) ->
        $scope.group = resourceFactory.Group.get(null, ->
            # workaround, atm link is not set in graph api response
            $scope.group.link = 'https://www.facebook.com/groups/AustrianComputerScience/'
        )
        $scope.getUser = (id) -> resourceFactory.User.get(userid: id, fields: 'picture')

    .controller 'PostCtrl', ($scope, resourceFactory) ->
        $scope.feed = resourceFactory.Feed.get()

    .controller 'EventsCtrl', ($scope, resourceFactory) ->
        $scope.events = resourceFactory.Events.get()
