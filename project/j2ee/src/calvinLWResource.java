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
 * @author kvlinden
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
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Student getStudent(@PathParam("id") long id) {
        return em.find(Student.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("students")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Student> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Student.class)).getResultList();
    }

    //Homework 12
    /**
     * PUT the given person entity, it it exists, using the values in the JSON-formatted person entity passed with the request.
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
     * POST a new person
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
     * DELETE the person with the given ID, if it exists
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