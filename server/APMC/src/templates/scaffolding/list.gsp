<% import grails.persistence.Event %>
<div class="page-header">
	<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>	
</div>
<alert level="{{message.level}}" text="{{message.text}}"/>
<div class="well form-inline" style="padding:5px; margin-bottom:0px;">
	<div class="form-group">
		<input class="form-control" type="search" ng-model="listOptions.q" placeholder="Search"/>
	</div>
	<div class="form-group">
		<select class="form-control" ng-model="listOptions.searchField" ng-options="field.value as field.name for field in fields" ></select>
	</div>
	<div class="form-group">
		<a href="" ng-click="refreshList()" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></a>
	
		<a href="#create" class="btn btn-primary">New</a>
	</div>
</div>
			
<table class="table table-bordered table-striped list">
    <thead>
        <tr>
		<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
			allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
			props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
			Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
			props.eachWithIndex { p, i ->
				if (i < 8) { %>
			<th>
				<a href="" ng-click="sortBy('${p.name}')">${p.naturalName}</a>
				<i ng-show="listOptions.sort=='${p.name}' && listOptions.order=='asc'" class="glyphicon glyphicon-chevron-up pull-right"></i>
				<i ng-show="listOptions.sort=='${p.name}' && listOptions.order=='desc'" class="glyphicon glyphicon-chevron-down pull-right"></i>
			</th>
		<%   } } %>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="item in list" >
		<%  props.eachWithIndex { p, i -> %>
			<td>
			<% if (i == 0) { %><a data-ng-click="show(item)"><% } 
			  if (p.type == Boolean || p.type == boolean) { %>
				{{ {true:'Yes', false:''}[item.sold] }}
			<% }
			  else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
			{{ item.${p.name} | date:'dd/MM/yyyy' }}
			<% }        	
	    	  else if (p.type && Number.isAssignableFrom(p.type) || (p.type?.isPrimitive() && p.type != boolean)) { %>
	    	  {{ item.${p.name} | number:2 }}
	    	<% } else { %>
			{{ item.${p.name} }}
			<% }
				if (i == 0) { %></a><% } %>
			</td>
		<%  } %>
        </tr>
    </tbody>
</table>
<div class="container well well-sm">
	<div class="pull-left" style="margin:0px;" data-pagination data-boundary-links="true" data-max-size="10" data-rotate="false" data-items-per-page="listOptions.max" data-total-items="listOptions.total" data-page="listOptions.currentPage" on-select-page="selectPage(page)"></div>
	
	<div class="pull-right">
		<div class="btn-group">
	  		<button ng-repeat="max in maxRanges" type="button" class="btn btn-default" ng-class="{active:listOptions.max==max}" ng-click="changeMax(max)">{{max}}</button>
	  		
	  		<button disabled="disabled" type="button" class="btn btn-default">of {{listOptions.total}}</button>	  		
	  	</div>
	</div>
</div>