package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Time;

/**
 * Created by kec32 on 5/12/2017.
 */

public class GraduateemployerPK implements Serializable {
    private String position;
    private long graduateID;
    private long employerID;

    @Column(name = "GRADUATEID")
    @Id
    public long getGraduateID() {
        return graduateID;
    }

    public void setGraduateID(long graduateID) {
        this.graduateID = graduateID;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        GraduateemployerPK that = (GraduateemployerPK) o;

        if (graduateID != this.graduateID) return false;
        if (employerID != this.employerID) return false;
        if (position != null ? !position.equals(that.position) : that.position != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (graduateID ^ (graduateID >>> 32));
        result = 31 * result + (int) (employerID ^ (employerID >>> 32));
        result = 31 * result + (position != null ? position.hashCode() : 0);
        return result;
    }
}
