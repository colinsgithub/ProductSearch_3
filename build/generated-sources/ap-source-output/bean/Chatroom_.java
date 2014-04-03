package bean;

import bean.Message;
import bean.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2014-04-02T21:05:33")
@StaticMetamodel(ChatRoom.class)
public class ChatRoom_ { 

    public static volatile SingularAttribute<ChatRoom, String> roomDesc;
    public static volatile SingularAttribute<ChatRoom, String> roomName;
    public static volatile SingularAttribute<ChatRoom, String> roomImage;
    public static volatile SingularAttribute<ChatRoom, User> administrator;
    public static volatile SingularAttribute<ChatRoom, User> owner;
    public static volatile SingularAttribute<ChatRoom, Date> creationTime;
    public static volatile CollectionAttribute<ChatRoom, Message> messageCollection;
    public static volatile SingularAttribute<ChatRoom, Integer> roomID;

}