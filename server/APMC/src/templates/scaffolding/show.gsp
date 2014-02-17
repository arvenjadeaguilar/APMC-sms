<% import grails.persistence.Event %>
<div class="page-header">
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>	
</div>
<alert level="{{message.level}}" text="{{message.text}}"/>
<dl class="dl-horizontal">
	<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
	allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	props.each { p -> %>
	<dt>${p.naturalName}</dt>
	<dd data-ng-bind="item.${p.name}"></dd>
	<%  } %>
</dl>
<div class="form-actions">
	<a class="btn" data-ng-href="#/edit/{{item.id}}"><i class="glyphicon glyphicon-edit"></i> Edit</a>
	<button type="button" class="btn btn-danger pull-right" data-ng-click="delete(item)"><i class="glyphicon glyphicon-trash"></i> Delete</button>
</div>
