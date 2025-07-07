/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 *
 * @author vinni
 */
@Entity
public class ManagingStaff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long managingStaffId;
    
    private String name;
    private String password;
    private String gender;
    private String phone;
    private String ic;
    private String email;
    private String address;
    

    public ManagingStaff() {
    }

    public ManagingStaff(Long managingStaffId, String name, String password, String gender, String phone, String ic, String email, String address) {
        this.managingStaffId = managingStaffId;
        this.name = name;
        this.password = password;
        this.gender = gender;
        this.phone = phone;
        this.ic = ic;
        this.email = email;
        this.address = address;
    }
    
    public Long getmanagingStaffId() {
        return managingStaffId;
    }
    
    public void setManagingStaffId(Long managingStaffId) {
        this.managingStaffId = managingStaffId;
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
        hash += (managingStaffId != null ? managingStaffId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ManagingStaff)) {
            return false;
        }
        ManagingStaff other = (ManagingStaff) object;
        if ((this.managingStaffId == null && other.managingStaffId != null) || (this.managingStaffId != null && !this.managingStaffId.equals(other.managingStaffId))) {
            return false;
        }
        return true;
    }

    @Override
    /*
    public String toString() {
        return "model.ManagingStaff[ id=" + managingStaffId + " ]";
    }
    */
    public String toString() {
        return "ManagingStaff{" +
                "managingStaffId=" + managingStaffId +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                ", ic='" + ic + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
    
}
