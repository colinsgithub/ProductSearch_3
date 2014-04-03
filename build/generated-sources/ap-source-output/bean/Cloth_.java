package bean;

import bean.ClothPK;
import bean.LowerGarment;
import bean.Merchandise;
import bean.UpperGarment;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(Cloth.class)
public class Cloth_ { 

    public static volatile SingularAttribute<Cloth, String> edition;
    public static volatile SingularAttribute<Cloth, String> sex;
    public static volatile SingularAttribute<Cloth, Merchandise> merchandise;
    public static volatile SingularAttribute<Cloth, String> occasion;
    public static volatile CollectionAttribute<Cloth, UpperGarment> upperGarmentCollection;
    public static volatile SingularAttribute<Cloth, ClothPK> clothPK;
    public static volatile SingularAttribute<Cloth, Double> fabricContent;
    public static volatile SingularAttribute<Cloth, String> season;
    public static volatile SingularAttribute<Cloth, String> subStyle;
    public static volatile SingularAttribute<Cloth, String> careLabel;
    public static volatile SingularAttribute<Cloth, String> threadThickness;
    public static volatile SingularAttribute<Cloth, String> thickness;
    public static volatile SingularAttribute<Cloth, String> basicStyle;
    public static volatile SingularAttribute<Cloth, String> fabric;
    public static volatile CollectionAttribute<Cloth, LowerGarment> lowerGarmentCollection;

}