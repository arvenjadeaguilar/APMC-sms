def dev = grails.util.GrailsUtil.isDevelopmentEnv()
def applicationContext = org.codehaus.groovy.grails.commons.ApplicationHolder.application.mainContext
def jqueryPlugin = applicationContext.pluginManager.getGrailsPlugin('jquery')

modules = {
	'angular' {
		defaultBundle 'angular'
		if(jqueryPlugin){
			dependsOn 'jquery'
		}
        resource id: 'angular', url:[ dir:'js/angular', file: minForProd('angular.js')], nominify: false
    }
          
    'angular-cookies' {
        defaultBundle 'angular'
        dependsOn 'angular'
        resource url:[ dir:'js/angular', file: minForProd('angular-cookies.js')], nominify: true
    }
	
	'angular-animate' {
		defaultBundle 'angular'
		dependsOn 'angular'
		resource url:[ dir:'js/angular', file: minForProd('angular-animate.js')], nominify: true
	}
    
	'angular-touch' {
		defaultBundle 'angular'
		dependsOn 'angular'
		resource url:[ dir:'js/angular', file: minForProd('angular-touch.js')], nominify: true
	}
	
	'angular-route' {
		defaultBundle 'angular'
		dependsOn 'angular'
		resource url:[ dir:'js/angular', file: minForProd('angular-route.js')], nominify: true
	}
	
    'angular-loader' {
        defaultBundle 'angular'
        dependsOn 'angular'
        resource url:[ dir:'js/angular', file: minForProd('angular-loader.js')], nominify: true
    }
    
    'angular-resource' {
        defaultBundle 'angular'
        dependsOn 'angular'
        resource url:[ dir:'js/angular', file: minForProd('angular-resource.js')], nominify: true
    }
    
    'angular-sanitize' {
        defaultBundle 'angular'
        dependsOn 'angular'
        resource url:[ dir:'js/angular', file: minForProd('angular-sanitize.js')], nominify: true
    }
    
	
	'angular-mock' {
		resource url:[ dir:'js/angular', file:"angular-mocks.js"]
			
	}
	
	'angular-scenario' {
		resource url:[ dir:'js/angular', file:"angular-scenario.js"], attrs: ['ng:autotest': true]
			
	}

	
}

def minForProd(String filename){
    if (dev) return filename
    filename[0..-4] + '.js'
}
