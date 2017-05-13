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

    @Column(name = "POSITION")
    @Id
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Column(name = "STARTDATE")
    @Id
    public Time getStartdate() {
        return startdate;
    }

    public void setStartdate(Time startdate) {
        this.startdate = startdate;
    }

    @Column(name = "ENDDATE")
    @Id
    public Time getEnddate() {
        return enddate;
    }

    public void setEnddate(Time enddate) {
        this.enddate = enddate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Studentemployer that = (Studentemployer) o;

        if (studentID != this.studentID) return false;
        if (employerID != this.employerID) return false;
        if (position != null ? !position.equals(that.position) : that.position != null) return false;
        if (startdate != null ? !startdate.equals(that.startdate) : that.startdate != null) return false;
        if (enddate != null ? !enddate.equals(that.enddate) : that.enddate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (studentID ^ (studentID >>> 32));
        result = 31 * result + (int) (employerID ^ (employerID >>> 32));
        result = 31 * result + (position != null ? position.hashCode() : 0);
        result = 31 * result + (startdate != null ? startdate.hashCode() : 0);
        result = 31 * result + (enddate != null ? enddate.hashCode() : 0);
        return result;
    }
}
