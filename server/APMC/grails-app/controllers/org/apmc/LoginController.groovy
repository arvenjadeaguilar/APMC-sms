package org.apmc

class LoginController {

    def index() { }

    def teacher() {
    	println request.JSON

    	def t = Teacher.find("from Teacher as t where t.username=:username and t.pasword=:password",[username:request.JSON.username,password:request.JSON.password])
    	println t;

    	if(t){
    		render "true"
    	}
    	else{
    		render "false"
    	}

    }
}
