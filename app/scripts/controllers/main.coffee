'use strict'

angular.module('acsApp')
    .controller 'MainCtrl', ($scope, $resource) ->
            Group = $resource('https://graph.facebook.com/552255311482154/', access_token: '157521754433538|aPSO4gOp2M2BcGCVlW09ffKFQhI')
            Feed = $resource('https://graph.facebook.com/552255311482154/feed', access_token: '157521754433538|aPSO4gOp2M2BcGCVlW09ffKFQhI')
            User = $resource('https://graph.facebook.com/:userid')
            $scope.group = Group.get()
            $scope.feed = Feed.get()
            $scope.getUser = (id) -> User.get(userid: id, fields: 'picture')
