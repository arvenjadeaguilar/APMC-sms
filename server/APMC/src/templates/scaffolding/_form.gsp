<% import grails.persistence.Event 

	private List listAllProperties (domainClass) {
		excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
		persistentPropNames = domainClass.persistentProperties*.name
		boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
		if (hasHibernate && org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder.getMapping(domainClass)?.identity?.generator == 'assigned') {
			persistentPropNames << domainClass.identifier.name
		}
		props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
		Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
		
		return props;
	}
	
	private generateForDomainClass(domainClass) {
		def props = listAllProperties(domainClass)
		for (p in props) {
			if (p.embedded) {
				def embeddedPropNames = p.component.persistentProperties*.name
				def excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
				def embeddedProps = p.component.properties.findAll { embeddedPropNames.contains(it.name) && !excludedProps.contains(it.name) }
				Collections.sort(embeddedProps, comparator.constructors[0].newInstance([p.component] as Object[]))
				%><fieldset class="embedded"><legend>${p.naturalName}</legend><%
				for (ep in p.component.properties) {
					renderFieldForProperty(ep, p.component, "${p.name}.")
				}
				%></fieldset><%
			} else {
				renderFieldForProperty(p, domainClass)
			}
		}
	}

	private generateManyToMany(domainClass, collectionName, listVar, ownerDomainClass){
	
		def props = listAllProperties(domainClass).findAll {it.referencedDomainClass != ownerDomainClass} 		
		%>		
		<table class="table table-striped table-bordered">
			<thead>			
				<% for (p in props) { %>	
				<th>${p.naturalName}</th>
				<% } %>
				
				<th class="span1">
					<a href="" class="btn" list-append list="$listVar" item="{}"><i class="glyphicon glyphicon-plus-sign"></i></a>
				</th>
			</thead>
			<tbody>
				<tr ng-repeat="child${collectionName} in ${listVar}">
					<% for (p in props) { %>
					<td><% renderField (p, domainClass, "child${collectionName}.") %></td>
					<% } %>
					
					<td class="span1 btn-group">
						<a href="" class="btn btn-danger" list-remove list="${listVar}" item="child${collectionName}" ><i class="glyphicon glyphicon-minus-sign"></i></a>
						<a href="" class="btn" list-move-up list="${listVar}" item="child${collectionName}" ng-disabled="\$first"><i class="glyphicon glyphicon-arrow-up"></i></a>
						<a href="" class="btn" list-move-down list="${listVar}" item="child${collectionName}" ng-disabled="\$last"><i class="glyphicon glyphicon-arrow-down"></i></a>									
					</td>
				</tr>							
			</tbody>
		</table>
			<% 
	}
	
	private renderField (p, owningClass, prefix = "") {
		boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')		
		boolean required = false
		boolean dateField = false
		boolean numberField = false
		boolean select = false
		int cols = 10
		String extra = "";
		String inputType = "text";
		boolean manyToMany = false;
		boolean input = true;
		
		Boolean show = true;
		
		if (p.type == Boolean || p.type == boolean) {
			inputType = "checkbox"			
		}        	
	    else if (p.type && Number.isAssignableFrom(p.type) || (p.type?.isPrimitive() && p.type != boolean)) {
	    	inputType = "number"
	    	numberField = true
	    	extra = "step=\"0.01\" min=\"0\" max=\"100\" ";
	    }	        
	    else if (p.type == String) {
	    	inputType = "text"
	    }	    
	    else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) {
	    	inputType = "text"
	    	dateField = true
			cols = 2;
	    }	   
	    else if (p.manyToOne || p.oneToOne) {
	    	select = true
	    	input = false;
			show = p.association;
	    }
    	else if (p.oneToMany) {
    		manyToMany = true;
    		select = false;
    		input = false;
			show = p.association;
        } 
	            		 
		if (hasHibernate) {
			cp = owningClass.constrainedProperties[p.name]
			display = (cp ? cp.display : true)
			required = (cp ? (!(p.type in [boolean, Boolean]) && (!cp.nullable) && (cp.propertyType != String || !cp.blank)) : false)		
		}
		
		//[${p.properties.toString() }]	
		%>
		<div class="col-sm-${cols}">
		<%
		if (show) {
			if (dateField) { %>
				<o:dateInput class="form-control" type="text" id="${prefix}${p.name}" name="${prefix}${p.name}" placeholder="${p.naturalName}" ${required ? 'ng-required="true"' :'' } data-ng-model="${prefix}${p.name}" ${extra} />
			<% } else if (input) { %>					
				<input class="form-control" type="${inputType}" id="${prefix}${p.name}" name="${prefix}${p.name}" placeholder="${p.naturalName}" ${required ? 'ng-required="true"' :'' } data-ng-model="${prefix}${p.name}" ${extra} />								 
			<% } else if (select){ %>				
				<select class="form-control" id="${prefix}${p.name}" placeholder="${p.naturalName}" ng-model="${prefix}${p.name}" ng-options="o as o.description for o in ${p.typePropertyName}List" key="id"></select>
				<span class="text-error">DEV:Please change the ng-options and the Controller, then remove this span</span>
			<% } else if (manyToMany){ 				
					generateManyToMany (p.referencedDomainClass, p.naturalName , prefix + p.name, domainClass);
			}			
		}
		%>
		<span class="help-block" data-ng-show="errors.${prefix}${p.name}">{{errors.${prefix}${p.name}}}</span>
		</div>
		<%
	}
	
	private renderFieldForProperty(p, owningClass, prefix = "") {
		boolean display = true
		
		if (display) { %>
	<div class="form-group" data-ng-class="{error: errors.${prefix}${p.name}}">
		<label class="col-sm-2 control-label" for="${prefix}${p.name}">${p.naturalName}
			<span class="text-error" ng-show="form.${prefix}${p.name}.\$error.required">*</span>
		</label>		
		<% renderField (p, owningClass, "item." + prefix) %>							
	</div>
	<%  }   
	} 
	
	generateForDomainClass(domainClass);
%>