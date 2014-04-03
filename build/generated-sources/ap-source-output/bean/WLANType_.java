package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(WLANType.class)
public class WLANType_ { 

    public static volatile SingularAttribute<WLANType, Integer> wLANTypeID;
    public static volatile SingularAttribute<WLANType, String> wLANTypeName;
    public static volatile CollectionAttribute<WLANType, Mobile> mobileCollection;

}