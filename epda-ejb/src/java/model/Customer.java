/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

/**
 *
 * @author vinni
 */
@Entity
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) 
    private Long customerId;
    
    private String name;
    private String password;
    private String gender;
    private String phone;
    private String ic;
    private String email;
    private String address;

    @OneToMany(mappedBy = "customer")
    private List<CustomerOrder> orders;
    
    @OneToMany(mappedBy = "customer")
    private List<DeliveryRatingFeedback> deliveryRF;
    
    @OneToMany
    private List<ShoppingCartItem> items;

    public Customer() {
        this.items = new ArrayList<>(); // Initialize the list
    }

    public Customer(Long customerId, String name, String password, String gender, String phone, String ic, String email, String address) {
        this.customerId = customerId;
        this.name = name;
        this.password = password;
        this.gender = gender;
        this.phone = phone;
        this.ic = ic;
        this.email = email;
        this.address = address;
        this.items = new ArrayList<>(); // Initialize the list
    }
    
    // New method to add an item to the cart
    public void addItem(ShoppingCartItem item) {
        if (items == null) {
            items = new ArrayList<>();
        }
        items.add(item);
    }

    // Getters and setters
    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }
    
    public List<DeliveryRatingFeedback> getDeliveryRF() {
        return deliveryRF;
    }

    public void setDeliveryRF(List<DeliveryRatingFeedback> deliveryRF) {
        this.deliveryRF = deliveryRF;
    }

    public List<ShoppingCartItem> getItems() {
        return items;
    }

    public void setItems(List<ShoppingCartItem> items) {
        this.items = items;
    }

    public List<CustomerOrder> getOrders() {
        return orders;
    }

    public void setOrders(List<CustomerOrder> orders) {
        this.orders = orders;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getIc() {
        return ic;
    }

    public void setIc(String ic) {
        this.ic = ic;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (customerId != null ? customerId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        return (this.customerId != null || other.customerId == null) && (this.customerId == null || this.customerId.equals(other.customerId));
    }

    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerId +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                ", ic='" + ic + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
