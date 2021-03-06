package bean;

import bean.Category;
import bean.Comment;
import bean.StoreMerchandise;
import bean.Tag;
import bean.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-09T13:20:43")
@StaticMetamodel(Store.class)
public class Store_ { 

    public static volatile SingularAttribute<Store, String> storeName;
    public static volatile CollectionAttribute<Store, Comment> commentCollection;
    public static volatile SingularAttribute<Store, Category> categoryID;
    public static volatile SingularAttribute<Store, Double> altitude;
    public static volatile SingularAttribute<Store, Date> storeCreateTime;
    public static volatile SingularAttribute<Store, String> storeAvatar;
    public static volatile SingularAttribute<Store, String> storeDesc;
    public static volatile CollectionAttribute<Store, StoreMerchandise> storeMerchandiseCollection;
    public static volatile CollectionAttribute<Store, Tag> tagCollection;
    public static volatile SingularAttribute<Store, User> userID;
    public static volatile SingularAttribute<Store, Double> rank;
    public static volatile SingularAttribute<Store, Integer> phoneNumber;
    public static volatile SingularAttribute<Store, String> address;
    public static volatile SingularAttribute<Store, Double> longitude;
    public static volatile SingularAttribute<Store, Double> latitude;
    public static volatile SingularAttribute<Store, Integer> storeID;

}