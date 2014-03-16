/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author poonkaho
 */
@Entity
@Table(name = "tag")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Tag.findAll", query = "SELECT t FROM Tag t"),
    @NamedQuery(name = "Tag.findByUserID", query = "SELECT t FROM Tag t WHERE t.tagPK.userID = :userID"),
    @NamedQuery(name = "Tag.findByStoreID", query = "SELECT t FROM Tag t WHERE t.tagPK.storeID = :storeID"),
    @NamedQuery(name = "Tag.findByCreationTime", query = "SELECT t FROM Tag t WHERE t.tagPK.creationTime = :creationTime")})
public class Tag implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected TagPK tagPK;
    @JoinColumn(name = "userID", referencedColumnName = "userID", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private User user;
    @JoinColumn(name = "storeID", referencedColumnName = "storeID", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Store store;

    public Tag() {
    }

    public Tag(TagPK tagPK) {
        this.tagPK = tagPK;
    }

    public Tag(String userID, int storeID, Date creationTime) {
        this.tagPK = new TagPK(userID, storeID, creationTime);
    }

    public TagPK getTagPK() {
        return tagPK;
    }

    public void setTagPK(TagPK tagPK) {
        this.tagPK = tagPK;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Store getStore() {
        return store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tagPK != null ? tagPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Tag)) {
            return false;
        }
        Tag other = (Tag) object;
        if ((this.tagPK == null && other.tagPK != null) || (this.tagPK != null && !this.tagPK.equals(other.tagPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.Tag[ tagPK=" + tagPK + " ]";
    }
    
}
