package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Customer;
import model.DeliveryStaff;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(DeliveryRatingFeedback.class)
public class DeliveryRatingFeedback_ { 

    public static volatile SingularAttribute<DeliveryRatingFeedback, String> feedback;
    public static volatile SingularAttribute<DeliveryRatingFeedback, Long> deliveryRatingFeedbackId;
    public static volatile SingularAttribute<DeliveryRatingFeedback, DeliveryStaff> deliveryStaff;
    public static volatile SingularAttribute<DeliveryRatingFeedback, Double> rating;
    public static volatile SingularAttribute<DeliveryRatingFeedback, Customer> customer;

}