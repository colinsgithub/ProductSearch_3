package bean;

import bean.PromotionPreferencePK;
import bean.PromotionScheme;
import bean.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-24T20:17:24")
@StaticMetamodel(PromotionPreference.class)
public class PromotionPreference_ { 

    public static volatile SingularAttribute<PromotionPreference, PromotionPreferencePK> promotionPreferencePK;
    public static volatile SingularAttribute<PromotionPreference, PromotionScheme> promotionScheme;
    public static volatile SingularAttribute<PromotionPreference, User> user;
    public static volatile SingularAttribute<PromotionPreference, Boolean> notificationSelection;

}