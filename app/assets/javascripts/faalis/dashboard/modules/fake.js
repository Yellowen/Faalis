angular.module('Fake', [])
  .config(['$stateProvider',  function($stateProvider){
    $stateProvider
      .state('fake-group-new', {
        url: '/auth/groups/new',
        templateUrl: '/dashboard/auth/groups/new'
      })
      .state('fake-group-edit', {
        url: '/auth/groups/:id',
        templateUrl: function($stateParams){
          return '/dashboard/auth/groups/' + $stateParams.id + '?' + big_random();
        }
      })
      .state('fake-user-index', {
        url: '/auth/users',
        templateUrl: '/dashboard/auth/users'
      })
      .state('fake-user-show', {
        url: '/auth/users/:id',
        templateUrl: function($stateParams){
          return '/dashboard/auth/users/' + $stateParams.id + '?' + big_random();
        }
      })
      .state('fake-user-edit', {
        url: '/auth/users/:id',
        templateUrl: function($stateParams){
          return '/dashboard/auth/users/' + $stateParams.id + '/edit?' + big_random();
        }
      })
      .state('fake-user-new', {
        url: '/auth/users/new',
        templateUrl: '/dashboard/auth/users/new'
      });
  }]);
