package bean;

import bean.Cloth;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(UpperGarment.class)
public class UpperGarment_ { 

    public static volatile SingularAttribute<UpperGarment, String> sleeveStyle;
    public static volatile SingularAttribute<UpperGarment, Integer> upperGarmentID;
    public static volatile SingularAttribute<UpperGarment, Cloth> cloth;
    public static volatile SingularAttribute<UpperGarment, String> upperGarmentType;
    public static volatile SingularAttribute<UpperGarment, String> collar;
    public static volatile SingularAttribute<UpperGarment, Double> sleeveLength;

}