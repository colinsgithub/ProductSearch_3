package bean;

import bean.Comment;
import bean.Store;
import bean.Tag;
import bean.Userstatus;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-11T18:05:27")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SingularAttribute<User, String> userDesc;
    public static volatile SingularAttribute<User, Character> sex;
    public static volatile CollectionAttribute<User, Comment> commentCollection;
    public static volatile CollectionAttribute<User, Store> storeCollection;
    public static volatile CollectionAttribute<User, Tag> tagCollection;
    public static volatile SingularAttribute<User, String> avatar;
    public static volatile SingularAttribute<User, String> password;
    public static volatile SingularAttribute<User, String> userID;
    public static volatile CollectionAttribute<User, Userstatus> userstatusCollection;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, String> preference;
    public static volatile SingularAttribute<User, Integer> age;
    public static volatile SingularAttribute<User, String> role;
    public static volatile SingularAttribute<User, Double> credit;

}