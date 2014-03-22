package bean;

import bean.Brand;
import bean.Category;
import bean.Cloth;
import bean.MerchandisePK;
import bean.PhonotapeAndVideotape;
import bean.StoreMerchandise;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-22T12:06:15")
@StaticMetamodel(Merchandise.class)
public class Merchandise_ { 

    public static volatile SingularAttribute<Merchandise, String> merchandiseImage;
    public static volatile SingularAttribute<Merchandise, Brand> brandID;
    public static volatile SingularAttribute<Merchandise, Category> category;
    public static volatile SingularAttribute<Merchandise, String> merchandiseDesc;
    public static volatile SingularAttribute<Merchandise, Cloth> cloth;
    public static volatile SingularAttribute<Merchandise, String> merchandiseName;
    public static volatile CollectionAttribute<Merchandise, StoreMerchandise> storeMerchandiseCollection;
    public static volatile SingularAttribute<Merchandise, MerchandisePK> merchandisePK;
    public static volatile SingularAttribute<Merchandise, Date> listingYear;
    public static volatile SingularAttribute<Merchandise, PhonotapeAndVideotape> phonotapeAndVideotape;

}