package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Time;

/**
 * Created by kec32 on 5/12/2017.
 */

public class StudentemployerPK implements Serializable {
    private long studentID;
    private long employerID;
    private String position;
    private Time startdate;
    private Time enddate;

    @Column(name = "STUDENTID")
    @Id
    public long getStudentID() {
        return studentID;
    }

    public void setStudentID(long studentID) {
        this.studentID = studentID;
    }

    @Column(name = "EmployerID")
    @Id
    public long getEmployerID() {
        return employerID;
    }

    public void setEmployerID(long employerID) {
        this.employerID = employerID;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Studentemployer that = (Studentemployer) o;

        if (studentID != this.studentID) return false;
        if (employerID != this.employerID) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (studentID ^ (studentID >>> 32));
        result = 31 * result + (int) (employerID ^ (employerID >>> 32));
        return result;
    }
}
