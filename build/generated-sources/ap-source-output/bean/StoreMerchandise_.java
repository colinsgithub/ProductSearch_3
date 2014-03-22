package bean;

import bean.Merchandise;
import bean.Store;
import bean.StoreMerchandisePK;
import bean.Storeuppergarmentchoice;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-22T12:06:15")
@StaticMetamodel(StoreMerchandise.class)
public class StoreMerchandise_ { 

    public static volatile CollectionAttribute<StoreMerchandise, Storeuppergarmentchoice> storeuppergarmentchoiceCollection;
    public static volatile SingularAttribute<StoreMerchandise, StoreMerchandisePK> storeMerchandisePK;
    public static volatile SingularAttribute<StoreMerchandise, Double> price;
    public static volatile SingularAttribute<StoreMerchandise, Store> store;
    public static volatile SingularAttribute<StoreMerchandise, Merchandise> merchandise;
    public static volatile SingularAttribute<StoreMerchandise, String> color;
    public static volatile SingularAttribute<StoreMerchandise, String> merchandiseImage1;
    public static volatile SingularAttribute<StoreMerchandise, String> merchandiseImage2;
    public static volatile SingularAttribute<StoreMerchandise, String> merchandiseImage3;

}