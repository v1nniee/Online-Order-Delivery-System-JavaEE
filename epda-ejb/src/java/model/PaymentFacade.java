/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.text.SimpleDateFormat;
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
public class PaymentFacade extends AbstractFacade<Payment> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PaymentFacade() {
        super(Payment.class);
    }
    
    public void edit(Payment payment) {
        em.merge(payment);
    }
    
    public Map<String, Long> getPaymentMethodDistribution() {
        try {
            // Query to calculate total revenue grouped by payment method
            List<Object[]> results = em.createQuery(
                    "SELECT p.paymentMethod, COUNT(p.paymentId) " +
                    "FROM Payment p " +
                    "WHERE p.paymentStatus = 'Collected' " +
                    "GROUP BY p.paymentMethod", Object[].class)
                    .getResultList();

            // Map to hold the payment method and corresponding revenue count
            Map<String, Long> paymentMethodDistribution = new HashMap<>();

            for (Object[] result : results) {
                String paymentMethod = (String) result[0];
                Long count = (Long) result[1];
                paymentMethodDistribution.put(paymentMethod, count);
            }

            return paymentMethodDistribution;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching revenue distribution", e);
        }
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

    




    
}
