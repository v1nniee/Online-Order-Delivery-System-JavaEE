/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vinni
 */
@Stateless
public class DeliveryRatingFeedbackFacade extends AbstractFacade<DeliveryRatingFeedback> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DeliveryRatingFeedbackFacade() {
        super(DeliveryRatingFeedback.class);
    }
    
}
