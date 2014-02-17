smsApp.controller('loginController',function($scope,$http,$location){
	
	$scope.name = "arven";
	
	$scope.loginUser = function(){

		$scope.loginAddress = $scope.serverAddress + "/apmc/login/teacher";
		//console.log($scope.loginAddress);
		
		$http.post(
			"http://"+$scope.serverAddress+"/APMC/login/teacher",
			{
				username:$scope.username,
				password:$scope.password
				

			}).success(function(data,status){
				
				if(data=="true"){
					$scope.show=true
				}

				if(data==true){
					$scope.show=true
				}
			})
	}

});