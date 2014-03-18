/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author poonkaho
 */
@Embeddable
public class PhonotapeAndVideotapePK implements Serializable {
    @Basic(optional = false)
    @Column(name = "phonotapeandvideotapeID")
    private int phonotapeandvideotapeID;
    @Basic(optional = false)
    @Column(name = "categoryID")
    private int categoryID;

    public PhonotapeAndVideotapePK() {
    }

    public PhonotapeAndVideotapePK(int phonotapeandvideotapeID, int categoryID) {
        this.phonotapeandvideotapeID = phonotapeandvideotapeID;
        this.categoryID = categoryID;
    }

    public int getPhonotapeandvideotapeID() {
        return phonotapeandvideotapeID;
    }

    public void setPhonotapeandvideotapeID(int phonotapeandvideotapeID) {
        this.phonotapeandvideotapeID = phonotapeandvideotapeID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) phonotapeandvideotapeID;
        hash += (int) categoryID;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PhonotapeAndVideotapePK)) {
            return false;
        }
        PhonotapeAndVideotapePK other = (PhonotapeAndVideotapePK) object;
        if (this.phonotapeandvideotapeID != other.phonotapeandvideotapeID) {
            return false;
        }
        if (this.categoryID != other.categoryID) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.PhonotapeAndVideotapePK[ phonotapeandvideotapeID=" + phonotapeandvideotapeID + ", categoryID=" + categoryID + " ]";
    }
    
}
