package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by kec32 on 4/28/2017.
 */


public class StudentemployerPK implements Serializable {
    private long studentid;
    private long employerid;

    @Column(name = "STUDENTID")
    @Id
    public long getStudentid() {
        return studentid;
    }

    public void setStudentid(long studentid) {
        this.studentid = studentid;
    }

    @Column(name = "EMPLOYERID")
    @Id
    public long getEmployerid() {
        return employerid;
    }

    public void setEmployerid(long employerid) {
        this.employerid = employerid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        StudentemployerPK that = (StudentemployerPK) o;

        if (studentid != that.studentid) return false;
        if (employerid !=  that.employerid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (studentid ^ (studentid >>> 32));
        result = 31 * result + (int) (employerid ^ (employerid >>> 32));
        return result;
    }
}