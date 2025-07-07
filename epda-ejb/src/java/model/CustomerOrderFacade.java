/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vinni
 */
@Stateless
public class CustomerOrderFacade extends AbstractFacade<CustomerOrder> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerOrderFacade() {
        super(CustomerOrder.class);
    }
    public List<CustomerOrder> findByCustomer(Customer customer) {
        return em.createQuery("SELECT o FROM CustomerOrder o WHERE o.customer = :customer", CustomerOrder.class)
                 .setParameter("customer", customer)
                 .getResultList();
    }
    
    public List<CustomerOrder> findPendingOrders() {
        try {
            return em.createQuery("SELECT o FROM CustomerOrder o WHERE o.orderStatus = :status", CustomerOrder.class)
                     .setParameter("status", "Pending")
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            return new ArrayList<>(); // Return an empty list to avoid null pointer issues
        }
    }
    
    public List<CustomerOrder> findCompletedOrdersByCustomer(Customer customer) {
        try {
            return em.createQuery("SELECT o FROM CustomerOrder o WHERE o.orderStatus = :status AND o.customer = :customer", CustomerOrder.class)
                     .setParameter("status", "Completed") // Match completed orders
                     .setParameter("customer", customer)  // Bind the customer parameter
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            return new ArrayList<>(); // Return an empty list to handle errors gracefully
        }
    }
    
    public List<CustomerOrder> findIncompleteOrdersByCustomer(Customer customer) {
        try {
            return em.createQuery("SELECT o FROM CustomerOrder o WHERE o.orderStatus != :status AND o.customer = :customer", CustomerOrder.class)
                     .setParameter("status", "Completed") // Match completed orders
                     .setParameter("customer", customer)  // Bind the customer parameter
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            return new ArrayList<>(); // Return an empty list to handle errors gracefully
        }
    }



    public List<CustomerOrder> findAll() {
        return em.createQuery("SELECT o FROM CustomerOrder o", CustomerOrder.class).getResultList();
    }
    
    public Map<String, Double> getRevenueDistributionByPaymentDate() {
        try {
            // Query to calculate total revenue grouped by payment date
            List<Object[]> results = em.createQuery(
                    "SELECT p.paymentDate, SUM(o.totalAmount) " +
                    "FROM CustomerOrder o " +
                    "JOIN o.payment p " +
                    "WHERE p.paymentStatus = 'Collected' " +
                    "GROUP BY p.paymentDate", Object[].class)
                    .getResultList();

            // Map to hold the payment date and corresponding total revenue
            Map<String, Double> revenueByDate = new HashMap<>();

            for (Object[] result : results) {
                Date paymentDate = (Date) result[0];
                Double totalRevenue = (Double) result[1];

                // Format the date as a string (e.g., "YYYY-MM-DD")
                String formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(paymentDate);

                revenueByDate.put(formattedDate, totalRevenue);
            }

            return revenueByDate;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching revenue distribution by payment date", e);
        }
    }
    
    public Map<String, Map<String, Long>> getProductDistributionByMonth() {
        try {
            List<Object[]> results = em.createQuery(
                    "SELECT FUNCTION('MONTH', o.orderDate), FUNCTION('YEAR', o.orderDate), p.productName, SUM(oi.quantity) " +
                    "FROM CustomerOrder o " +
                    "JOIN o.orderItems oi " +
                    "JOIN oi.product p " +
                    "WHERE o.orderStatus = 'Completed' " +
                    "GROUP BY FUNCTION('MONTH', o.orderDate), FUNCTION('YEAR', o.orderDate), p.productName", Object[].class)
                    .getResultList();

            Map<String, Map<String, Long>> productDistributionByMonth = new HashMap<>();

            for (Object[] result : results) {
                Integer month = (Integer) result[0]; 
                Integer year = (Integer) result[1];
                String productName = (String) result[2];
                Long quantitySold = (Long) result[3];

                String monthYear = String.format("%02d-%d", month, year);

                productDistributionByMonth
                    .computeIfAbsent(monthYear, k -> new HashMap<>())
                    .put(productName, quantitySold);
            }
            return productDistributionByMonth;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching product distribution by month", e);
        }
    }
    
    public List<CustomerOrder> findByProductName(String productName) {
        return em.createQuery(
            "SELECT DISTINCT o FROM CustomerOrder o JOIN o.orderItems i WHERE LOWER(i.product.productName) LIKE :productName", 
            CustomerOrder.class)
            .setParameter("productName", "%" + productName.toLowerCase() + "%")
            .getResultList();
    }
    public List<CustomerOrder> findByProductNameAndIncompleteStatusForCurrentUser(String productName, Customer currentUser) {
        try {
            return em.createQuery(
                    "SELECT DISTINCT o " +
                    "FROM CustomerOrder o " +
                    "JOIN o.orderItems i " +
                    "WHERE LOWER(i.product.productName) LIKE :productName " +
                    "AND o.orderStatus != :status " +
                    "AND o.customer = :customer", 
                    CustomerOrder.class)
                    .setParameter("productName", "%" + productName.toLowerCase() + "%")
                    .setParameter("status", "Completed")
                    .setParameter("customer", currentUser)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            return new ArrayList<>(); // Return an empty list to handle errors gracefully
        }
    }

    
    public List<CustomerOrder> findByProductNameAndCompleteStatusForCurrentUser(String productName, Customer currentUser) {
        try {
            return em.createQuery(
                    "SELECT DISTINCT o " +
                    "FROM CustomerOrder o " +
                    "JOIN o.orderItems i " +
                    "WHERE LOWER(i.product.productName) LIKE :productName " +
                    "AND o.orderStatus = :status " +
                    "AND o.customer = :customer", 
                    CustomerOrder.class)
                    .setParameter("productName", "%" + productName.toLowerCase() + "%")
                    .setParameter("status", "Completed")
                    .setParameter("customer", currentUser)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            return new ArrayList<>(); // Return an empty list to handle errors gracefully
        }
    }
    
    public List<CustomerOrder> findCompletedOrdersByDeliveryStaff(DeliveryStaff deliveryStaff) {
        try {
            return em.createQuery(
                    "SELECT o FROM CustomerOrder o WHERE o.orderStatus = :completedStatus AND o.delivery.deliveryStaff = :deliveryStaff", CustomerOrder.class)
                    .setParameter("completedStatus", "Completed")
                    .setParameter("deliveryStaff", deliveryStaff)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            return new ArrayList<>(); // Return an empty list to handle errors gracefully
        }
    }


    
}
