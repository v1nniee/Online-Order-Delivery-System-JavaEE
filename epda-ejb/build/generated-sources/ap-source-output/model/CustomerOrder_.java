package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Customer;
import model.Delivery;
import model.OrderItem;
import model.Payment;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-11-29T18:50:15")
@StaticMetamodel(CustomerOrder.class)
public class CustomerOrder_ { 

    public static volatile SingularAttribute<CustomerOrder, Double> totalAmount;
    public static volatile SingularAttribute<CustomerOrder, Delivery> delivery;
    public static volatile SingularAttribute<CustomerOrder, Long> orderId;
    public static volatile SingularAttribute<CustomerOrder, String> orderStatus;
    public static volatile SingularAttribute<CustomerOrder, Payment> payment;
    public static volatile SingularAttribute<CustomerOrder, Date> orderDate;
    public static volatile ListAttribute<CustomerOrder, OrderItem> orderItems;
    public static volatile SingularAttribute<CustomerOrder, Customer> customer;

}