package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Time;

/**
 * This class defined the Graduate entity of the calvinLW database.
 * Created by kec32 on 5/13/2017.
 */
@Entity
public class Graduate {
    private long id;
    private String firstname;
    private String lastname;
    private String email;
    private String phonenumber;
    private Time graduationdate;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "FIRSTNAME")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Basic
    @Column(name = "LASTNAME")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Basic
    @Column(name = "EMAIL")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "PHONENUMBER")
    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    @Basic
    @Column(name = "GRADUATIONDATE")
    public Time getGraduationdate() {
        return graduationdate;
    }

    public void setGraduationdate(Time graduationdate) {
        this.graduationdate = graduationdate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Graduate graduate = (Graduate) o;

        if (id != graduate.id) return false;
        if (firstname != null ? !firstname.equals(graduate.firstname) : graduate.firstname != null) return false;
        if (lastname != null ? !lastname.equals(graduate.lastname) : graduate.lastname != null) return false;
        if (email != null ? !email.equals(graduate.email) : graduate.email != null) return false;
        if (phonenumber != null ? !phonenumber.equals(graduate.phonenumber) : graduate.phonenumber != null)
            return false;
        if (graduationdate != null ? !graduationdate.equals(graduate.graduationdate) : graduate.graduationdate != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (phonenumber != null ? phonenumber.hashCode() : 0);
        result = 31 * result + (graduationdate != null ? graduationdate.hashCode() : 0);
        return result;
    }
}
