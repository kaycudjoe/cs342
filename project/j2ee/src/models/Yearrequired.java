package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by kec32 on 5/12/2017.
 */
@Entity
public class Yearrequired {
    private long id;
    private String name;
    private String description;
    private String requiredyear;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "DESCRIPTION")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "REQUIREDYEAR")
    public String getRequiredyear() {
        return requiredyear;
    }

    public void setRequiredyear(String requiredyear) {
        this.requiredyear = requiredyear;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Yearrequired that = (Yearrequired) o;

        if (id != that.id) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (requiredyear != null ? !requiredyear.equals(that.requiredyear) : that.requiredyear != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (requiredyear != null ? requiredyear.hashCode() : 0);
        return result;
    }
}
