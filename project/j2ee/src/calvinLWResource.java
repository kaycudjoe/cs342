import models.Student;
import models.Graduate;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * calvinLWResource allows the career center staff to perform data manipulation operations on the calvinLW database.
 * It tries to reduce the impedance mismatch between the relational database and the object-oriented language, Java.
 * It allows its users to access information on a particular student involved in the lifework program, as well as all the students stored in the database - GET
 * It also allows its users to update an existing student's information. This could be useful when information about a student like an email address needs to be updated. - PUT
 * It allows its users to create a new student, this is useful when a new student starts the program - POST
 * It allows its users to delete a student. With the tudent ID, the user can delete a student if they are no longer part of the lifework program - DELETE
 *
 *
 * Created by kec32 on 5/13/2017
 */
@Stateless
@Path("calvinLW")
public class calvinLWResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual student record.
     * Useful for the career center staff to retrive the record of a particular student involved in the lifework program
     * @param id the ID of the student to retrieve
     * @return a student record
     */
    @GET
    @Path("student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Student getStudent(@PathParam("id") long id) {
        return em.find(Student.class, id);
    }

    /**
     * GET all students using the criteria query API.
     * This is useful for the career center staff to get information on all students involved in the Calvin Lifework Program.
     *
     * @return a list of all students records
     */
    @GET
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Student> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Student.class)).getResultList();
    }

    /**
     * PUT modifies the given student entity, if it exists, using the values in the JSON-formatted student entity passed with the request.
     * Useful for the database develop to modify student records.
     */
    @PUT
    @Path("student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response putStudent(Student updateStudent, @PathParam("id") long id){
        Student p = em.find(Student.class, id);
        if(updateStudent.getId() != id || p == null){
            return Response.serverError().entity("Invalid ID").build();
        }
        updateStudent.setGraduate(em.find(Graduate.class, updateStudent.getGraduate().getId()));
        em.merge(updateStudent);
        return Response.ok(em.find(Student.class,id), MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST a new student to the database
     * Useful for the database developer to create a new student for the database
     */
    @POST
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Student postStudent(Student newStudent){
        Student p = new Student ();
        newStudent.setId(p.getId());
        newStudent.setGraduate(em.find(Graduate.class, newStudent.getGraduate().getId()));
        em.persist(newStudent);
        return newStudent;
    }

    /**
     * DELETE the student with the given ID, if it exists
     * Allows the database developer to delete a student who is no longer enrolled in the program
     *
     */
    @DELETE
    @Path("student/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public String deleteStudent(@PathParam("id") long id) {
        Student p = em.find(Student.class, id);
        if(p == null){
            return "ID: " + id + " does not exist";
        }
        else {
            em.remove(p);
        }
        return "Deleted Student with ID: " + id;
    }

}