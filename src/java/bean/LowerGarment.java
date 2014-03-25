/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
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
@Table(name = "LowerGarment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "LowerGarment.findAll", query = "SELECT l FROM LowerGarment l"),
    @NamedQuery(name = "LowerGarment.findByLowerGarmentID", query = "SELECT l FROM LowerGarment l WHERE l.lowerGarmentID = :lowerGarmentID"),
    @NamedQuery(name = "LowerGarment.findByOutseam", query = "SELECT l FROM LowerGarment l WHERE l.outseam = :outseam"),
    @NamedQuery(name = "LowerGarment.findByWaistHeight", query = "SELECT l FROM LowerGarment l WHERE l.waistHeight = :waistHeight"),
    @NamedQuery(name = "LowerGarment.findByLowerGarmentType", query = "SELECT l FROM LowerGarment l WHERE l.lowerGarmentType = :lowerGarmentType")})
public class LowerGarment implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "lowerGarmentID")
    private Integer lowerGarmentID;
    @Basic(optional = false)
    @Column(name = "outseam")
    private String outseam;
    @Basic(optional = false)
    @Column(name = "waistHeight")
    private String waistHeight;
    @Basic(optional = false)
    @Column(name = "lowerGarmentType")
    private int lowerGarmentType;
    @JoinColumns({
        @JoinColumn(name = "lowerGarmentID", referencedColumnName = "clothID", insertable = false, updatable = false),
        @JoinColumn(name = "categoryID", referencedColumnName = "categoryID")})
    @ManyToOne(optional = false)
    private Cloth cloth;

    public LowerGarment() {
    }

    public LowerGarment(Integer lowerGarmentID) {
        this.lowerGarmentID = lowerGarmentID;
    }

    public LowerGarment(Integer lowerGarmentID, String outseam, String waistHeight, int lowerGarmentType) {
        this.lowerGarmentID = lowerGarmentID;
        this.outseam = outseam;
        this.waistHeight = waistHeight;
        this.lowerGarmentType = lowerGarmentType;
    }

    public Integer getLowerGarmentID() {
        return lowerGarmentID;
    }

    public void setLowerGarmentID(Integer lowerGarmentID) {
        this.lowerGarmentID = lowerGarmentID;
    }

    public String getOutseam() {
        return outseam;
    }

    public void setOutseam(String outseam) {
        this.outseam = outseam;
    }

    public String getWaistHeight() {
        return waistHeight;
    }

    public void setWaistHeight(String waistHeight) {
        this.waistHeight = waistHeight;
    }

    public int getLowerGarmentType() {
        return lowerGarmentType;
    }

    public void setLowerGarmentType(int lowerGarmentType) {
        this.lowerGarmentType = lowerGarmentType;
    }

    public Cloth getCloth() {
        return cloth;
    }

    public void setCloth(Cloth cloth) {
        this.cloth = cloth;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lowerGarmentID != null ? lowerGarmentID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LowerGarment)) {
            return false;
        }
        LowerGarment other = (LowerGarment) object;
        if ((this.lowerGarmentID == null && other.lowerGarmentID != null) || (this.lowerGarmentID != null && !this.lowerGarmentID.equals(other.lowerGarmentID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.LowerGarment[ lowerGarmentID=" + lowerGarmentID + " ]";
    }
    
}
