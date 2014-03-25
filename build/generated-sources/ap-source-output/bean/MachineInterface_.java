package bean;

import bean.Mobile;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-24T20:17:24")
@StaticMetamodel(MachineInterface.class)
public class MachineInterface_ { 

    public static volatile SingularAttribute<MachineInterface, String> machineInterfaceName;
    public static volatile SingularAttribute<MachineInterface, Integer> machineInterfaceID;
    public static volatile CollectionAttribute<MachineInterface, Mobile> mobileCollection;

}