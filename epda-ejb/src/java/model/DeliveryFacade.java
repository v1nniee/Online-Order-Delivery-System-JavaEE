/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vinni
 */
@Stateless
public class DeliveryFacade extends AbstractFacade<Delivery> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DeliveryFacade() {
        super(Delivery.class);
    }
    
    public Delivery find(Long id) {
        return em.find(Delivery.class, id);
    }
    
    public void edit(Delivery delivery) {
        em.merge(delivery);
    }
    
    public List<Delivery> findDeliveriesByDeliveryStaff(DeliveryStaff deliveryStaff) {
        return em.createQuery(
                "SELECT d FROM Delivery d WHERE d.deliveryStaff = :deliveryStaff AND d.deliveryStatus != :deliveredStatus", Delivery.class)
                .setParameter("deliveryStaff", deliveryStaff)
                .setParameter("deliveredStatus", "Delivered")
                .getResultList();
    }

    
    public List<CustomerOrder> findDeliveredOrdersByDeliveryStaff(DeliveryStaff deliveryStaff) {
        return em.createQuery(
                "SELECT d.order FROM Delivery d WHERE d.deliveryStaff = :deliveryStaff " +
                "AND d.deliveryStatus = :status AND d.order.orderStatus != :completedStatus", CustomerOrder.class)
                .setParameter("deliveryStaff", deliveryStaff)
                .setParameter("status", "Delivered")
                .setParameter("completedStatus", "Completed")
                .getResultList();
    }
    

    public List<Delivery> findCompletedDeliveriesByDeliveryStaff(DeliveryStaff deliveryStaff) {
        return em.createQuery(
                "SELECT d FROM Delivery d " +
                "JOIN d.order o " + 
                "WHERE d.deliveryStaff = :deliveryStaff AND o.orderStatus = :completedStatus", Delivery.class)
                .setParameter("deliveryStaff", deliveryStaff)
                .setParameter("completedStatus", "Completed")
                .getResultList();
    }



}

    
    
