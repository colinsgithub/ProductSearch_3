package bean;

import bean.PromotionPreference;
import bean.PromotionSchemePK;
import bean.Store;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(PromotionScheme.class)
public class PromotionScheme_ { 

    public static volatile SingularAttribute<PromotionScheme, Date> startDate;
    public static volatile SingularAttribute<PromotionScheme, Store> store;
    public static volatile CollectionAttribute<PromotionScheme, PromotionPreference> promotionPreferenceCollection;
    public static volatile SingularAttribute<PromotionScheme, String> description;
    public static volatile SingularAttribute<PromotionScheme, Date> endDate;
    public static volatile SingularAttribute<PromotionScheme, PromotionSchemePK> promotionSchemePK;

}