
<div class="page-header">
	<g:set var="entityName" value="${message(code: 'teacher.label', default: 'Teacher')}" />
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>	
</div>
<alert level="{{message.level}}" text="{{message.text}}"/>
<dl class="dl-horizontal">
	
	<dt>Contact No</dt>
	<dd data-ng-bind="item.contactNo"></dd>
	
	<dt>Department</dt>
	<dd data-ng-bind="item.department"></dd>
	
	<dt>Id No</dt>
	<dd data-ng-bind="item.idNo"></dd>
	
	<dt>Name</dt>
	<dd data-ng-bind="item.name"></dd>
	
	<dt>Pasword</dt>
	<dd data-ng-bind="item.pasword"></dd>
	
	<dt>Username</dt>
	<dd data-ng-bind="item.username"></dd>
	
</dl>
<div class="form-actions">
	<a class="btn" data-ng-href="#/edit/{{item.id}}"><i class="glyphicon glyphicon-edit"></i> Edit</a>
	<button type="button" class="btn btn-danger pull-right" data-ng-click="delete(item)"><i class="glyphicon glyphicon-trash"></i> Delete</button>
</div>
