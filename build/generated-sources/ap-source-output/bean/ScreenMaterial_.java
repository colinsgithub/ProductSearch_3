package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(ScreenMaterial.class)
public class ScreenMaterial_ { 

    public static volatile SingularAttribute<ScreenMaterial, String> screenMaterialName;
    public static volatile SingularAttribute<ScreenMaterial, Integer> screenMaterialID;
    public static volatile CollectionAttribute<ScreenMaterial, Mobile> mobileCollection;

}