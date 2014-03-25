package bean;

import bean.User;
import bean.UserStatusPK;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-24T20:17:24")
@StaticMetamodel(UserStatus.class)
public class UserStatus_ { 

    public static volatile SingularAttribute<UserStatus, UserStatusPK> userStatusPK;
    public static volatile SingularAttribute<UserStatus, String> statusName;
    public static volatile SingularAttribute<UserStatus, String> statusColor;
    public static volatile SingularAttribute<UserStatus, User> user;
    public static volatile SingularAttribute<UserStatus, String> statusDesc;

}