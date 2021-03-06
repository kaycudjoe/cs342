package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * This class defines the Employer entity for the calvinLW database. It defines all the attributes for the entity.
 * Created by kec32 on 5/13/2017.
 */
@Entity
public class Employer {
    private long id;
    private String firstname;
    private String lastname;
    private String email;
    private String phonenumber;
    private String companyname;

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
    @Column(name = "COMPANYNAME")
    public String getCompanyname() {
        return companyname;
    }

    public void setCompanyname(String companyname) {
        this.companyname = companyname;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Employer employer = (Employer) o;

        if (id != employer.id) return false;
        if (firstname != null ? !firstname.equals(employer.firstname) : employer.firstname != null) return false;
        if (lastname != null ? !lastname.equals(employer.lastname) : employer.lastname != null) return false;
        if (email != null ? !email.equals(employer.email) : employer.email != null) return false;
        if (phonenumber != null ? !phonenumber.equals(employer.phonenumber) : employer.phonenumber != null)
            return false;
        if (companyname != null ? !companyname.equals(employer.companyname) : employer.companyname != null)
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
        result = 31 * result + (companyname != null ? companyname.hashCode() : 0);
        return result;
    }
}
