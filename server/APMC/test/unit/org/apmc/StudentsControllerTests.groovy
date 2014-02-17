package org.apmc



import org.junit.*
import grails.test.mixin.*

@TestFor(StudentsController)
@Mock(Students)
class StudentsControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/students/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.studentsInstanceList.size() == 0
        assert model.studentsInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.studentsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.studentsInstance != null
        assert view == '/students/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/students/show/1'
        assert controller.flash.message != null
        assert Students.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/students/list'


        populateValidParams(params)
        def students = new Students(params)

        assert students.save() != null

        params.id = students.id

        def model = controller.show()

        assert model.studentsInstance == students
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/students/list'


        populateValidParams(params)
        def students = new Students(params)

        assert students.save() != null

        params.id = students.id

        def model = controller.edit()

        assert model.studentsInstance == students
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/students/list'

        response.reset()


        populateValidParams(params)
        def students = new Students(params)

        assert students.save() != null

        // test invalid parameters in update
        params.id = students.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/students/edit"
        assert model.studentsInstance != null

        students.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/students/show/$students.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        students.clearErrors()

        populateValidParams(params)
        params.id = students.id
        params.version = -1
        controller.update()

        assert view == "/students/edit"
        assert model.studentsInstance != null
        assert model.studentsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/students/list'

        response.reset()

        populateValidParams(params)
        def students = new Students(params)

        assert students.save() != null
        assert Students.count() == 1

        params.id = students.id

        controller.delete()

        assert Students.count() == 0
        assert Students.get(students.id) == null
        assert response.redirectedUrl == '/students/list'
    }
}
