<% import grails.persistence.Event %>
<div class="page-header">
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <h1><g:message code="default.create.label" args="[entityName]" /></h1>	
</div>

<div class="container">
	<alert level="{{message.level}}" text="{{message.text}}"/>
	<form name="form" data-ng-submit="saveAndClose(item)" class="form-horizontal" role="form">
		
		<g:render template="form" />
			
		 <div class="form-group">
    		<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn btn-primary" data-ng-disabled="form.\$invalid"  data-ng-click="save(item)"><i class="glyphicon glyphicon-ok"></i>Create</button>
				<button type="button" class="btn btn-primary" data-ng-disabled="form.\$invalid"  data-ng-click="saveAndClose(item)"><i class="glyphicon glyphicon-ok"></i>Create and Close</button>
				<button type="button" class="btn btn-default" data-ng-click="close()" ><i class="glyphicon glyphicon-list"></i> Close</button>
			</div>
		</div>
	</form>
</div>

<script>
	function formScopeSetup (\$scope) {
		
	}
</script>