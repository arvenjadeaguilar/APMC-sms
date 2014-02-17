        $('#newUser').hide();
        $('#serverForm').hide();
        $('#new').click(function(){
            $('#login').hide();
            $('#newUser').show();
        });

        $('#cancel').click(function(){
            $('#newUser').hide();
            $('#login').show();
        });
        $('#server').click(function(){
            $('#login').hide();
            $('#serverForm').show();
        });

        $('#confirm').click(function(){
            $('#serverForm').hide();
            $('#login').show();
        });

loginModule.controller('smsController',function($scope,$http,$location){
    
    
    $scope.serverAddress = "127.0.0.1:8080";

});