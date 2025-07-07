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
import javax.persistence.ManyToOne;

/**
 *
 * @author vinni
 */
@Entity
public class DeliveryRatingFeedback implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long deliveryRatingFeedbackId;
    
    @ManyToOne
    private DeliveryStaff deliveryStaff;

    @ManyToOne
    private Customer customer;
    
    private double rating; 
    private String feedback; 

    public DeliveryRatingFeedback() {
    }

    public DeliveryRatingFeedback(Long deliveryRatingFeedbackId, DeliveryStaff deliveryStaff, Customer customer, double rating, String feedback) {
        this.deliveryRatingFeedbackId = deliveryRatingFeedbackId;
        this.deliveryStaff = deliveryStaff;
        this.customer = customer;
        this.rating = rating;
        this.feedback = feedback;
    }

    public Long getDeliveryRatingFeedbackId() {
        return deliveryRatingFeedbackId;
    }

    public void setDeliveryRatingFeedbackId(Long deliveryRatingFeedbackId) {
        this.deliveryRatingFeedbackId = deliveryRatingFeedbackId;
    }

    public DeliveryStaff getDeliveryStaff() {
        return deliveryStaff;
    }

    public void setDeliveryStaff(DeliveryStaff deliveryStaff) {
        this.deliveryStaff = deliveryStaff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (deliveryRatingFeedbackId != null ? deliveryRatingFeedbackId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DeliveryRatingFeedback)) {
            return false;
        }
        DeliveryRatingFeedback other = (DeliveryRatingFeedback) object;
        if ((this.deliveryRatingFeedbackId == null && other.deliveryRatingFeedbackId != null) || (this.deliveryRatingFeedbackId != null && !this.deliveryRatingFeedbackId.equals(other.deliveryRatingFeedbackId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.DeliveryRatingFeedback[ deliveryRatingFeedbackId=" + deliveryRatingFeedbackId + " ]";
    }
    
}
