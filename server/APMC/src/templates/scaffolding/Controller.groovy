<% import grails.persistence.Event %>
<%=packageName ? "package ${packageName}\n\n" : ''%>import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import static javax.servlet.http.HttpServletResponse.*

class ${className}Controller {

    static final int SC_UNPROCESSABLE_ENTITY = 422

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() { }

	def template() {
		/* Render the Templates using GSP*/
		render (view:params.id)
	}
	
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

		Integer total = 0;
		
		def resultList = [];
		
		if (!params.sort) {
			params.remove("sort");
			params.remove("order");
		}
		params.remove("total");
		
		if (params.q) {
			if(params.searchField == 'id'){
				resultList = [${className}.get(params.q)];
				total = 1;
			} else {
				resultList = ${className}.search(params.q, params.searchField).list(params)
				total = ${className}.search(params.q, params.searchField).count();
			}
		}
		else {
			params.remove("q");
			params.remove("searchField");
		
			
			resultList = ${className}.list(params)
			total = ${className}.count();
		}
		
		response.setIntHeader('X-Pagination-Total', total)
		render JSON.use('deep') { resultList as JSON }
    }

	def lookups () {
		/* NOTE: params.id is the ID of the current item, 
		 * so you can use this load other related objects
		 * if params.id == "0" then it a create
		 */
		
		def resultList = [:];
		
		if (!params.id) { // List Controller
			resultList["fields"] = [
				[value:"", name:"-- Any Field --"]
			];
		}
		else { //Create/Edit Controller...
		
		<% 
		def excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated';
		def persistentPropNames = domainClass.persistentProperties*.name;
		def props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }

		props.each {p -> 
			if (p.manyToOne || p.oneToOne) {
			%>
		resultList["${p.typePropertyName}List"] = ${p.type.name}.active().list();						
		<%	}
		} 
		%>
		}
		render JSON.use('deep') { resultList as JSON }
	}
    def save() {
        def ${propertyName} = new ${className}()
		
		com.ocom.grails.JsonBinder.bindJSON (${propertyName}, request.JSON);
		
        def responseJson = [:]
        if (${propertyName}.validate(true) && ${propertyName}.save(flush: true)) {
            response.status = SC_CREATED
            responseJson.id = ${propertyName}.id
            responseJson.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
			responseJson.item = ${propertyName};
        } else {
			${propertyName}.discard();
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = ${propertyName}.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }
	
        render JSON.use('deep') { responseJson as JSON }
    }

    def get() {
        def ${propertyName} = ${className}.get(params.id)
        if (${propertyName}) {
			render JSON.use('deep') {${propertyName} as JSON}
        } else {
			if (params.id?.toString() == "0")
				render JSON.use('deep') {new ${className}() as JSON}
			else
				notFound params.id
		}
    }

    def update() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            notFound params.id
            return
        }

        def responseJson = [:]

        if (request.JSON.version != null) {
            if (${propertyName}.version > request.JSON.version) {<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
				response.status = SC_CONFLICT
				responseJson.message = message(code: 'default.optimistic.locking.failure',
						args: [message(code: '${domainClass.propertyName}.label', default: '${className}')],
						default: 'Another user has updated this ${className} while you were editing')
				cache false
				render JSON.use('deep') {responseJson as JSON}
				return
            }
        }
		
		com.ocom.grails.JsonBinder.bindJSON (${propertyName}, request.JSON);

        if (${propertyName}.validate(true) && ${propertyName}.save(flush: true)) {
            response.status = SC_OK
            responseJson.id = ${propertyName}.id
            responseJson.message = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
			responseJson.item = ${propertyName};
        } else {
			${propertyName}.discard();
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = ${propertyName}.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }

        render JSON.use('deep') {responseJson as JSON}
    }

    def delete() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            notFound params.id
            return
        }

        def responseJson = [:]
        try {
            ${propertyName}.delete(flush: true)
            responseJson.message = message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
        } catch (DataIntegrityViolationException e) {
            response.status = SC_CONFLICT
            responseJson.message = message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
        }
        render JSON.use('deep') {responseJson as JSON}
    }

    private void notFound(id) {
        response.status = SC_NOT_FOUND
        def responseJson = [message: message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])]
        render JSON.use('deep') {responseJson as JSON}
    }
}
