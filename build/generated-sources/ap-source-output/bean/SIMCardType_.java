package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-24T20:17:24")
@StaticMetamodel(SIMCardType.class)
public class SIMCardType_ { 

    public static volatile SingularAttribute<SIMCardType, String> sIMCardTypeName;
    public static volatile SingularAttribute<SIMCardType, Integer> sIMCardTypeID;
    public static volatile CollectionAttribute<SIMCardType, Mobile> mobileCollection;

}