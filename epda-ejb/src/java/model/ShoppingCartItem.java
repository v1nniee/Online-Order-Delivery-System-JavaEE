/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

/**
 *
 * @author vinni
 */
@Entity
public class ShoppingCartItem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long shoppingCartItemId;
    
    private int quantity;
    
    @ManyToOne
    private Product product;
    
    public ShoppingCartItem() {
    }

    public ShoppingCartItem(Long shoppingCartItemId, int quantity, Product product) {
        this.shoppingCartItemId = shoppingCartItemId;
        this.quantity = quantity;
        this.product = product;
    }

    public Long getShoppingCartItemId() {
        return shoppingCartItemId;
    }

    public void setShoppingCartItemId(Long shoppingCartItemId) {
        this.shoppingCartItemId = shoppingCartItemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (shoppingCartItemId != null ? shoppingCartItemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ShoppingCartItem)) {
            return false;
        }
        ShoppingCartItem other = (ShoppingCartItem) object;
        if ((this.shoppingCartItemId == null && other.shoppingCartItemId != null) || (this.shoppingCartItemId != null && !this.shoppingCartItemId.equals(other.shoppingCartItemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.ShoppingCartItem[ id=" + shoppingCartItemId + " ]";
    }
    
}
