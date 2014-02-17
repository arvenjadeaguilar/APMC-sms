<% import grails.persistence.Event %>
<div class="page-header">
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>	
</div>
<div class="container">
	<alert level="{{message.level}}" text="{{message.text}}"/>
	<form name="form" data-ng-submit="updateAndClose(item)" class="form-horizontal" role="form">
		<input type="hidden" data-ng-model="item.id">
		<input type="hidden" data-ng-model="item.version">
	
		<g:render template="form" />
			
		 <div class="form-group">
    		<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn btn-primary" data-ng-disabled="form.\$invalid" data-ng-click="update(item)"><i class="glyphicon glyphicon-ok"></i> Save</button>
				<button type="button" class="btn btn-primary" data-ng-disabled="form.\$invalid" data-ng-click="updateAndClose(item)"><i class="glyphicon glyphicon-ok"></i> Save and Close</button>
				<button type="button" class="btn btn-default" data-ng-click="close()"><i class="glyphicon glyphicon-list"></i> Close</button>
				<button type="button" class="btn btn-danger pull-right" data-ng-click="delete(item)"><i class="glyphicon glyphicon-trash"></i> Delete</button>
			</div>
		</div>
	</form>
</div>

<script>
	function formScopeSetup (\$scope) {
		
	}
</script>