angular.module('Fake', [])
  .config(['$stateProvider',  function($stateProvider){
    $stateProvider
      .state('fake-permissions-new', {
        url: '/auth/groups/new',
        templateUrl: '/dashboard/auth/groups/new'
      })
      .state('fake-permissions-edit', {
        url: '/auth/groups/:id',
        templateUrl: function($stateParams){
          return '/dashboard/auth/groups/' + $stateParams.id + '?' + big_random();
        }
      });
  }]);
