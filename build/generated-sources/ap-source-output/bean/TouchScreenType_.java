package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(TouchScreenType.class)
public class TouchScreenType_ { 

    public static volatile SingularAttribute<TouchScreenType, Integer> touchScreenTypeID;
    public static volatile SingularAttribute<TouchScreenType, String> touchScreenTypeName;
    public static volatile CollectionAttribute<TouchScreenType, Mobile> mobileCollection;

}