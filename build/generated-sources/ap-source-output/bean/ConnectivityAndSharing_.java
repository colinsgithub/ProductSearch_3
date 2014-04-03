package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(ConnectivityAndSharing.class)
public class ConnectivityAndSharing_ { 

    public static volatile SingularAttribute<ConnectivityAndSharing, String> connectivityAndSharingName;
    public static volatile SingularAttribute<ConnectivityAndSharing, Integer> connectivityAndSharingID;
    public static volatile CollectionAttribute<ConnectivityAndSharing, Mobile> mobileCollection;

}