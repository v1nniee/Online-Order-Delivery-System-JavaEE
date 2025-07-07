package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Delivery;
import model.DeliveryRatingFeedback;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(DeliveryStaff.class)
public class DeliveryStaff_ { 

    public static volatile SingularAttribute<DeliveryStaff, String> deliveryStaffStatus;
    public static volatile ListAttribute<DeliveryStaff, Delivery> deliverys;
    public static volatile ListAttribute<DeliveryStaff, DeliveryRatingFeedback> ratingsAndFeedbacks;
    public static volatile SingularAttribute<DeliveryStaff, String> password;
    public static volatile SingularAttribute<DeliveryStaff, String> address;
    public static volatile SingularAttribute<DeliveryStaff, Long> deliveryStaffId;
    public static volatile SingularAttribute<DeliveryStaff, String> gender;
    public static volatile SingularAttribute<DeliveryStaff, String> phone;
    public static volatile SingularAttribute<DeliveryStaff, String> name;
    public static volatile SingularAttribute<DeliveryStaff, String> ic;
    public static volatile SingularAttribute<DeliveryStaff, String> email;

}