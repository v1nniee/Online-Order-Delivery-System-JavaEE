package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.CustomerOrder;
import model.DeliveryRatingFeedback;
import model.ShoppingCartItem;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(Customer.class)
public class Customer_ { 

    public static volatile SingularAttribute<Customer, String> password;
    public static volatile SingularAttribute<Customer, String> address;
    public static volatile SingularAttribute<Customer, String> gender;
    public static volatile SingularAttribute<Customer, String> phone;
    public static volatile ListAttribute<Customer, DeliveryRatingFeedback> deliveryRF;
    public static volatile SingularAttribute<Customer, Long> customerId;
    public static volatile SingularAttribute<Customer, String> name;
    public static volatile SingularAttribute<Customer, String> ic;
    public static volatile ListAttribute<Customer, CustomerOrder> orders;
    public static volatile ListAttribute<Customer, ShoppingCartItem> items;
    public static volatile SingularAttribute<Customer, String> email;

}