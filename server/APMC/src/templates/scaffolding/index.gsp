<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="layout" content="ng-main">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        
        <r:require modules="default-scaffold" />        
    </head>
    <body class="ng-cloak" data-ng-app="scaffolding" data-base-url="\${createLink(uri: '/${domainClass.propertyName}/')}">
        <a href="#list-${domainClass.propertyName}" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        
        <content tag="buttons">					           
             <li><a class="list" href="#list"><g:message code="default.list.label" args="[entityName]" /></a></li>
             <li><a class="create" href="#create"><g:message code="default.new.label" args="[entityName]" /></a></li>
        </content>
 		<content tag="navForm"> 		
             <form class="navbar-form navbar-left" role="search" >
				<div class="form-group">
    				<input type="text" class="form-control input-sm" placeholder="Search" name="q" ng-model="navQ">
  				</div>
  				<a ng-href="#list?q={{navQ}}" class="navbar-btn btn-sm"><i class="glyphicon glyphicon-search icon-white"></i></a>  				
			</form>
		</content>
		
        <div class="content" role="main" data-ng-view>
        
        </div>
    </body>
</html>