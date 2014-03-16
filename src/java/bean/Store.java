/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author poonkaho
 */
@Entity
@Table(name = "store")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Store.findAll", query = "SELECT s FROM Store s"),
    @NamedQuery(name = "Store.findByStoreID", query = "SELECT s FROM Store s WHERE s.storeID = :storeID"),
    @NamedQuery(name = "Store.findByPhoneNumber", query = "SELECT s FROM Store s WHERE s.phoneNumber = :phoneNumber"),
    @NamedQuery(name = "Store.findByRank", query = "SELECT s FROM Store s WHERE s.rank = :rank"),
    @NamedQuery(name = "Store.findByLatitude", query = "SELECT s FROM Store s WHERE s.latitude = :latitude"),
    @NamedQuery(name = "Store.findByLongitude", query = "SELECT s FROM Store s WHERE s.longitude = :longitude"),
    @NamedQuery(name = "Store.findByAltitude", query = "SELECT s FROM Store s WHERE s.altitude = :altitude"),
    @NamedQuery(name = "Store.findByStoreCreateTime", query = "SELECT s FROM Store s WHERE s.storeCreateTime = :storeCreateTime")})
public class Store implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "storeID")
    private Integer storeID;
    @Basic(optional = false)
    @Lob
    @Column(name = "storeName")
    private String storeName;
    @Basic(optional = false)
    @Lob
    @Column(name = "address")
    private String address;
    @Column(name = "phoneNumber")
    private Integer phoneNumber;
    @Basic(optional = false)
    @Column(name = "rank")
    private double rank;
    @Basic(optional = false)
    @Column(name = "latitude")
    private double latitude;
    @Basic(optional = false)
    @Column(name = "longitude")
    private double longitude;
    @Basic(optional = false)
    @Column(name = "altitude")
    private double altitude;
    @Lob
    @Column(name = "storeDesc")
    private String storeDesc;
    @Basic(optional = false)
    @Column(name = "storeCreateTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date storeCreateTime;
    @JoinColumn(name = "userID", referencedColumnName = "userID")
    @ManyToOne(optional = false)
    private User userID;
    @JoinColumn(name = "categoryID", referencedColumnName = "categoryID")
    @ManyToOne(optional = false)
    private Category categoryID;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "store")
    private Collection<Tag> tagCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "store")
    private Collection<Comment> commentCollection;

    public Store() {
    }

    public Store(Integer storeID) {
        this.storeID = storeID;
    }

    public Store(Integer storeID, String storeName, String address, double rank, double latitude, double longitude, double altitude, Date storeCreateTime) {
        this.storeID = storeID;
        this.storeName = storeName;
        this.address = address;
        this.rank = rank;
        this.latitude = latitude;
        this.longitude = longitude;
        this.altitude = altitude;
        this.storeCreateTime = storeCreateTime;
    }

    public Integer getStoreID() {
        return storeID;
    }

    public void setStoreID(Integer storeID) {
        this.storeID = storeID;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(Integer phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getRank() {
        return rank;
    }

    public void setRank(double rank) {
        this.rank = rank;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public String getStoreDesc() {
        return storeDesc;
    }

    public void setStoreDesc(String storeDesc) {
        this.storeDesc = storeDesc;
    }

    public Date getStoreCreateTime() {
        return storeCreateTime;
    }

    public void setStoreCreateTime(Date storeCreateTime) {
        this.storeCreateTime = storeCreateTime;
    }

    public User getUserID() {
        return userID;
    }

    public void setUserID(User userID) {
        this.userID = userID;
    }

    public Category getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Category categoryID) {
        this.categoryID = categoryID;
    }

    @XmlTransient
    public Collection<Tag> getTagCollection() {
        return tagCollection;
    }

    public void setTagCollection(Collection<Tag> tagCollection) {
        this.tagCollection = tagCollection;
    }

    @XmlTransient
    public Collection<Comment> getCommentCollection() {
        return commentCollection;
    }

    public void setCommentCollection(Collection<Comment> commentCollection) {
        this.commentCollection = commentCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (storeID != null ? storeID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Store)) {
            return false;
        }
        Store other = (Store) object;
        if ((this.storeID == null && other.storeID != null) || (this.storeID != null && !this.storeID.equals(other.storeID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.Store[ storeID=" + storeID + " ]";
    }
    
}
