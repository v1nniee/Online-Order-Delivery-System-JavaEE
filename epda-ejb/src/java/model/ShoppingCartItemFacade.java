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
public class ShoppingCartItemFacade extends AbstractFacade<ShoppingCartItem> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ShoppingCartItemFacade() {
        super(ShoppingCartItem.class);
    }
    
    public void create(ShoppingCartItem shoppingCartItem) {
        em.persist(shoppingCartItem);
    }

    public ShoppingCartItem find(Object id) {
        return em.find(ShoppingCartItem.class, id);
    }

    public void edit(ShoppingCartItem shoppingCartItem) {
        em.merge(shoppingCartItem);
    }

    public void remove(ShoppingCartItem shoppingCartItem) {
        em.remove(em.merge(shoppingCartItem));
    }

    // Additional method to retrieve all items if needed
    public List<ShoppingCartItem> findAll() {
        return em.createQuery("SELECT i FROM ShoppingCartItem i", ShoppingCartItem.class).getResultList();
    }
    

    
    public ShoppingCartItem findById(Long id) {
        return em.find(ShoppingCartItem.class, id);
    }


}
