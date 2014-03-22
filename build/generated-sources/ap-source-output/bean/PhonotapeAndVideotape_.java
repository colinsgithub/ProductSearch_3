package bean;

import bean.Merchandise;
import bean.PhonotapeAndVideotapePK;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-22T12:06:15")
@StaticMetamodel(PhonotapeAndVideotape.class)
public class PhonotapeAndVideotape_ { 

    public static volatile SingularAttribute<PhonotapeAndVideotape, Double> price;
    public static volatile SingularAttribute<PhonotapeAndVideotape, Merchandise> merchandise;
    public static volatile SingularAttribute<PhonotapeAndVideotape, Date> date;
    public static volatile SingularAttribute<PhonotapeAndVideotape, PhonotapeAndVideotapePK> phonotapeAndVideotapePK;

}