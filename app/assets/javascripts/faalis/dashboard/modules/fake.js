angular.module('Fake', [])
  .config(['$stateProvider', function($stateProvider){
    $stateProvider
      .state('fake-permissions-new', {
            url: '/auth/groups/new',
            templateUrl: '/dashboard/auth/groups/new'
        });
  }]);
