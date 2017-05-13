package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;

/**
 * Created by kec32 on 5/12/2017.
 */
@Entity
public class Studentrequirement {
    private String yearleveltaken;

    @Basic
    @Column(name = "YEARLEVELTAKEN")
    public String getYearleveltaken() {
        return yearleveltaken;
    }

    public void setYearleveltaken(String yearleveltaken) {
        this.yearleveltaken = yearleveltaken;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Studentrequirement that = (Studentrequirement) o;

        if (yearleveltaken != null ? !yearleveltaken.equals(that.yearleveltaken) : that.yearleveltaken != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        return yearleveltaken != null ? yearleveltaken.hashCode() : 0;
    }
}
