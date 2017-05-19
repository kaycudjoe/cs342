package models;

import javax.persistence.*;
import java.sql.Time;
import java.sql.Time;

/**
 * This class defines the many-to-many relationship between student and employer.
 * Created by kec32 on 5/13/2017.
 */
@Entity
public class Studentemployer {
    private Long studentid;
    private Long employerid;
    private String position;
    private Time startdate;
    private Time enddate;

    @Id
    @Column(name = "STUDENTID")
    public Long getStudentid() {
        return studentid;
    }

    public void setStudentid(Long studentid) {
        this.studentid = studentid;
    }

    @Id
    @Column(name = "EMPLOYERID")
    public Long getEmployerid() {
        return employerid;
    }

    public void setEmployerid(Long employerid) {
        this.employerid = employerid;
    }

    @Basic
    @Column(name = "POSITION")
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Basic
    @Column(name = "STARTDATE")
    public Time getStartdate() {
        return startdate;
    }

    public void setStartdate(Time startdate) {
        this.startdate = startdate;
    }

    @Basic
    @Column(name = "ENDDATE")
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

        if (studentid != null ? !studentid.equals(that.studentid) : that.studentid != null) return false;
        if (employerid != null ? !employerid.equals(that.employerid) : that.employerid != null) return false;
        if (position != null ? !position.equals(that.position) : that.position != null) return false;
        if (startdate != null ? !startdate.equals(that.startdate) : that.startdate != null) return false;
        if (enddate != null ? !enddate.equals(that.enddate) : that.enddate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = studentid != null ? studentid.hashCode() : 0;
        result = 31 * result + (employerid != null ? employerid.hashCode() : 0);
        result = 31 * result + (position != null ? position.hashCode() : 0);
        result = 31 * result + (startdate != null ? startdate.hashCode() : 0);
        result = 31 * result + (enddate != null ? enddate.hashCode() : 0);
        return result;
    }
}
