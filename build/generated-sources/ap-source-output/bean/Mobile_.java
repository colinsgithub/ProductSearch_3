package bean;

import bean.CPUCoreType;
import bean.CPUManufacturer;
import bean.ConnectivityAndSharing;
import bean.Flash;
import bean.FlashMemoryCard;
import bean.KeyboardType;
import bean.MachineInterface;
import bean.Merchandise;
import bean.MobileNetworkStandard;
import bean.MobileType;
import bean.Navigation;
import bean.OperatingSystem;
import bean.SIMCardType;
import bean.ScreenMaterial;
import bean.SensorType;
import bean.TouchScreenType;
import bean.WLANType;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-03-24T20:17:24")
@StaticMetamodel(Mobile.class)
public class Mobile_ { 

    public static volatile SingularAttribute<Mobile, Double> screenSize;
    public static volatile SingularAttribute<Mobile, Double> weight;
    public static volatile SingularAttribute<Mobile, CPUManufacturer> cPUManufacturerID;
    public static volatile SingularAttribute<Mobile, Merchandise> merchandise;
    public static volatile CollectionAttribute<Mobile, Navigation> navigationCollection;
    public static volatile SingularAttribute<Mobile, ScreenMaterial> screenMaterialID;
    public static volatile SingularAttribute<Mobile, Integer> standByTime;
    public static volatile CollectionAttribute<Mobile, MobileType> mobileTypeCollection;
    public static volatile SingularAttribute<Mobile, Double> fontCameraPixel;
    public static volatile SingularAttribute<Mobile, Double> rearCameraPixel;
    public static volatile SingularAttribute<Mobile, CPUCoreType> cPUCoreTypeID;
    public static volatile SingularAttribute<Mobile, String> gPUModel;
    public static volatile SingularAttribute<Mobile, String> mobileFormFactor;
    public static volatile SingularAttribute<Mobile, Integer> sIMNumber;
    public static volatile SingularAttribute<Mobile, String> mobileSize;
    public static volatile SingularAttribute<Mobile, Integer> batteryCapacity;
    public static volatile SingularAttribute<Mobile, Integer> screenPixelDensity;
    public static volatile CollectionAttribute<Mobile, WLANType> wLANTypeCollection;
    public static volatile SingularAttribute<Mobile, TouchScreenType> touchScreenTypeID;
    public static volatile CollectionAttribute<Mobile, MobileNetworkStandard> mobileNetworkStandardCollection;
    public static volatile SingularAttribute<Mobile, Integer> rom;
    public static volatile SingularAttribute<Mobile, Integer> resolutionX;
    public static volatile SingularAttribute<Mobile, Integer> resolutionY;
    public static volatile SingularAttribute<Mobile, Integer> talkTime;
    public static volatile SingularAttribute<Mobile, String> batteryType;
    public static volatile SingularAttribute<Mobile, Flash> flashID;
    public static volatile CollectionAttribute<Mobile, SensorType> sensorTypeCollection;
    public static volatile CollectionAttribute<Mobile, SIMCardType> sIMCardTypeCollection;
    public static volatile CollectionAttribute<Mobile, MachineInterface> machineInterfaceCollection;
    public static volatile SingularAttribute<Mobile, OperatingSystem> osid;
    public static volatile SingularAttribute<Mobile, Integer> cPUFrequency;
    public static volatile SingularAttribute<Mobile, Integer> mobileID;
    public static volatile SingularAttribute<Mobile, Integer> ram;
    public static volatile CollectionAttribute<Mobile, KeyboardType> keyboardTypeCollection;
    public static volatile SingularAttribute<Mobile, FlashMemoryCard> flashMemoryCardID;
    public static volatile SingularAttribute<Mobile, String> cPUModel;
    public static volatile CollectionAttribute<Mobile, ConnectivityAndSharing> connectivityAndSharingCollection;

}