/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author poonkaho
 */
@Entity
@Table(name = "phonotape and videotape")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PhonotapeAndVideotape.findAll", query = "SELECT p FROM PhonotapeAndVideotape p"),
    @NamedQuery(name = "PhonotapeAndVideotape.findByPhonotapeandvideotapeID", query = "SELECT p FROM PhonotapeAndVideotape p WHERE p.phonotapeAndVideotapePK.phonotapeandvideotapeID = :phonotapeandvideotapeID"),
    @NamedQuery(name = "PhonotapeAndVideotape.findByCategoryID", query = "SELECT p FROM PhonotapeAndVideotape p WHERE p.phonotapeAndVideotapePK.categoryID = :categoryID"),
    @NamedQuery(name = "PhonotapeAndVideotape.findByDate", query = "SELECT p FROM PhonotapeAndVideotape p WHERE p.date = :date"),
    @NamedQuery(name = "PhonotapeAndVideotape.findByPrice", query = "SELECT p FROM PhonotapeAndVideotape p WHERE p.price = :price")})
public class PhonotapeAndVideotape implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected PhonotapeAndVideotapePK phonotapeAndVideotapePK;
    @Basic(optional = false)
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Basic(optional = false)
    @Column(name = "price")
    private double price;
    @JoinColumns({
        @JoinColumn(name = "phonotapeandvideotapeID", referencedColumnName = "merchandiseID", insertable = false, updatable = false),
        @JoinColumn(name = "categoryID", referencedColumnName = "categoryID", insertable = false, updatable = false)})
    @OneToOne(optional = false)
    private Merchandise merchandise;

    public PhonotapeAndVideotape() {
    }

    public PhonotapeAndVideotape(PhonotapeAndVideotapePK phonotapeAndVideotapePK) {
        this.phonotapeAndVideotapePK = phonotapeAndVideotapePK;
    }

    public PhonotapeAndVideotape(PhonotapeAndVideotapePK phonotapeAndVideotapePK, Date date, double price) {
        this.phonotapeAndVideotapePK = phonotapeAndVideotapePK;
        this.date = date;
        this.price = price;
    }

    public PhonotapeAndVideotape(int phonotapeandvideotapeID, int categoryID) {
        this.phonotapeAndVideotapePK = new PhonotapeAndVideotapePK(phonotapeandvideotapeID, categoryID);
    }

    public PhonotapeAndVideotapePK getPhonotapeAndVideotapePK() {
        return phonotapeAndVideotapePK;
    }

    public void setPhonotapeAndVideotapePK(PhonotapeAndVideotapePK phonotapeAndVideotapePK) {
        this.phonotapeAndVideotapePK = phonotapeAndVideotapePK;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Merchandise getMerchandise() {
        return merchandise;
    }

    public void setMerchandise(Merchandise merchandise) {
        this.merchandise = merchandise;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (phonotapeAndVideotapePK != null ? phonotapeAndVideotapePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PhonotapeAndVideotape)) {
            return false;
        }
        PhonotapeAndVideotape other = (PhonotapeAndVideotape) object;
        if ((this.phonotapeAndVideotapePK == null && other.phonotapeAndVideotapePK != null) || (this.phonotapeAndVideotapePK != null && !this.phonotapeAndVideotapePK.equals(other.phonotapeAndVideotapePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.PhonotapeAndVideotape[ phonotapeAndVideotapePK=" + phonotapeAndVideotapePK + " ]";
    }
    
}
