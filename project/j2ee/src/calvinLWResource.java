import models.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the calvinLW.
 * It uses a container-managed entity manager.
 *
 * The calvin lifework database allows you to keep track of students enrolled in the lifework program to determine who is eligibile for the scholarship in their 4th year
 * This will be useful to the career center staff if there have been any changes to the students' information(PUT and DELETE), if these is a new student (POST) or to get information about a certain student (GET)
 * @author Karen Cudjoe
 * @version Spring, 2017
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
     * @return a static hello message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getIntroductionMessage() {
        return "Hello! Welcome to the calvin lifework database web service!";
    }

    /**
     * GET an individual person record.
     * useful for the career center staff to look up information on certain students
     * @param id the ID of the student to retrieve
     * @return a student record
     */
    @GET
    @Path("Student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Student getPerson(@PathParam("id") long id) {
        return em.find(Student.class, id);
    }

    /**
     * GET all students using the criteria query API.
     * This will be useful to the career center staff to look up all the student enrolled in the program
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Student> getStudents() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Student.class)).getResultList();
    }

    /**
     * PUT updates a specific Student record
     * It is useful for the career center staff to update the graduates assigned to students
     */

    @PUT
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response putPerson(Student updateStudent, @PathParam("id") long id){
        Student p = em.find(Student.class, id);
        if(p != null || id != updateStudent.getId()){
            return Response.serverError().entity("Invalid ID").build();
        }
        updateStudent.setGraduate(em.find(Graduate.class, updateStudent.getGraduate().getId()));
        em.merge(updateStudent);
        return Response.ok(em.find(Student.class,id), MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST creates a new Student record
     * it is useful for the career center staff to add a new student to the database
     */
    @POST
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Student postPerson(Student newPerson){
        Student p = new Student ();
        newPerson.setId(p.getId());
        newPerson.setGraduate(em.find(Graduate.class, newPerson.getGraduate().getId()));
        em.persist(newPerson);
        return newPerson;
    }

    /**
     * DELETE deletes a specific Student record
     * this is useful for the career center staff to remove a Student, who has left the program
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