package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.CustomerOrder;
import model.DeliveryStaff;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(Delivery.class)
public class Delivery_ { 

    public static volatile SingularAttribute<Delivery, Long> deliveryId;
    public static volatile SingularAttribute<Delivery, DeliveryStaff> deliveryStaff;
    public static volatile SingularAttribute<Delivery, Date> deliveryDate;
    public static volatile SingularAttribute<Delivery, Date> completedDate;
    public static volatile SingularAttribute<Delivery, String> deliveryStatus;
    public static volatile SingularAttribute<Delivery, CustomerOrder> order;

}