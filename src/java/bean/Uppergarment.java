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
@Table(name = "uppergarment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Uppergarment.findAll", query = "SELECT u FROM Uppergarment u"),
    @NamedQuery(name = "Uppergarment.findByUpperGarmentID", query = "SELECT u FROM Uppergarment u WHERE u.upperGarmentID = :upperGarmentID"),
    @NamedQuery(name = "Uppergarment.findBySleeveStyle", query = "SELECT u FROM Uppergarment u WHERE u.sleeveStyle = :sleeveStyle"),
    @NamedQuery(name = "Uppergarment.findBySleeveLength", query = "SELECT u FROM Uppergarment u WHERE u.sleeveLength = :sleeveLength"),
    @NamedQuery(name = "Uppergarment.findByCollar", query = "SELECT u FROM Uppergarment u WHERE u.collar = :collar")})
public class Uppergarment implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "upperGarmentID")
    private Integer upperGarmentID;
    @Basic(optional = false)
    @Column(name = "sleeveStyle")
    private String sleeveStyle;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "sleeveLength")
    private Double sleeveLength;
    @Column(name = "collar")
    private String collar;
    @JoinColumns({
        @JoinColumn(name = "upperGarmentID", referencedColumnName = "clothID", insertable = false, updatable = false),
        @JoinColumn(name = "categoryID", referencedColumnName = "categoryID")})
    @ManyToOne(optional = false)
    private Cloth cloth;

    public Uppergarment() {
    }

    public Uppergarment(Integer upperGarmentID) {
        this.upperGarmentID = upperGarmentID;
    }

    public Uppergarment(Integer upperGarmentID, String sleeveStyle) {
        this.upperGarmentID = upperGarmentID;
        this.sleeveStyle = sleeveStyle;
    }

    public Integer getUpperGarmentID() {
        return upperGarmentID;
    }

    public void setUpperGarmentID(Integer upperGarmentID) {
        this.upperGarmentID = upperGarmentID;
    }

    public String getSleeveStyle() {
        return sleeveStyle;
    }

    public void setSleeveStyle(String sleeveStyle) {
        this.sleeveStyle = sleeveStyle;
    }

    public Double getSleeveLength() {
        return sleeveLength;
    }

    public void setSleeveLength(Double sleeveLength) {
        this.sleeveLength = sleeveLength;
    }

    public String getCollar() {
        return collar;
    }

    public void setCollar(String collar) {
        this.collar = collar;
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
        hash += (upperGarmentID != null ? upperGarmentID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Uppergarment)) {
            return false;
        }
        Uppergarment other = (Uppergarment) object;
        if ((this.upperGarmentID == null && other.upperGarmentID != null) || (this.upperGarmentID != null && !this.upperGarmentID.equals(other.upperGarmentID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.Uppergarment[ upperGarmentID=" + upperGarmentID + " ]";
    }
    
}
