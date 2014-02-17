//Define an angular module for our app
var smsApp = angular.module('smsApp', []);

//Define Routing for app
//Uri /AddNewOrder -> template AddOrder.html and Controller AddOrderController
//Uri /ShowOrders -> template ShowOrders.html and Controller AddOrderController
smsApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/login', {
	templateUrl: 'templates/login.html',
	controller: 'loginController'
      }).
      when('/register', {
	templateUrl: 'templates/register.html',
	controller: 'ShowOrdersController'
      }).
      otherwise({
	redirectTo: '/login'
      });
}]);


smsApp.controller('AddOrderController', function($scope) {
	
	$scope.message = 'This is Add new order screen';

	
});


smsApp.controller('ShowOrdersController', function($scope,$routeParams) {

	$scope.message = 'This is Show orders screen';
	$scope.orderId = $routeParams.orderId;

});
