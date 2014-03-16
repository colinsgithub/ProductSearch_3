/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author poonkaho
 */
@Embeddable
public class TagPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "userID")
    private String userID;
    @Basic(optional = false)
    @Column(name = "storeID")
    private int storeID;
    @Basic(optional = false)
    @Column(name = "creationTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationTime;

    public TagPK() {
    }

    public TagPK(String userID, int storeID, Date creationTime) {
        this.userID = userID;
        this.storeID = storeID;
        this.creationTime = creationTime;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public int getStoreID() {
        return storeID;
    }

    public void setStoreID(int storeID) {
        this.storeID = storeID;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userID != null ? userID.hashCode() : 0);
        hash += (int) storeID;
        hash += (creationTime != null ? creationTime.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TagPK)) {
            return false;
        }
        TagPK other = (TagPK) object;
        if ((this.userID == null && other.userID != null) || (this.userID != null && !this.userID.equals(other.userID))) {
            return false;
        }
        if (this.storeID != other.storeID) {
            return false;
        }
        if ((this.creationTime == null && other.creationTime != null) || (this.creationTime != null && !this.creationTime.equals(other.creationTime))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.TagPK[ userID=" + userID + ", storeID=" + storeID + ", creationTime=" + creationTime + " ]";
    }
    
}
