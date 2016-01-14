angular.module 'completeMe'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/comments/comments.html'
        controller: 'CommentsController'
        controllerAs: 'forum'

    $urlRouterProvider.otherwise '/'
