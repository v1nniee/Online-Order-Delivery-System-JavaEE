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
public class ProductFacade extends AbstractFacade<Product> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductFacade() {
        super(Product.class);
    }
    
    public List<Product> findAll(){
        return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
    }
    
    public Product findByProductName(String productName) {
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.productName = :productName", Product.class)
                     .setParameter("productName", productName)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<Product> findByProductNameLike(String productName) {
        return em.createQuery("SELECT p FROM Product p WHERE p.productName LIKE :productName", Product.class)
                 .setParameter("productName", "%" + productName + "%")
                 .getResultList();
    }

    

    
    
    
}
