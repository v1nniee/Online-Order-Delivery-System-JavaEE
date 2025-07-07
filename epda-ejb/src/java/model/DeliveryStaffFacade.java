/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vinni
 */
@Stateless
public class DeliveryStaffFacade extends AbstractFacade<DeliveryStaff> {

    @PersistenceContext(unitName = "epda-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DeliveryStaffFacade() {
        super(DeliveryStaff.class);
    }
    
    public void edit(DeliveryStaff deliveryStaff) {
        em.merge(deliveryStaff);
    }

    
    public DeliveryStaff findByEmail(String email) {
        try {
            return em.createQuery("SELECT d FROM DeliveryStaff d WHERE d.email = :email", DeliveryStaff.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<DeliveryStaff> findAvailableDeliveryStaff() {
        return em.createQuery("SELECT d FROM DeliveryStaff d WHERE d.deliveryStaffStatus = :status", DeliveryStaff.class)
                 .setParameter("status", "Available")
                 .getResultList();
    }
    
    public void updateDeliveryStaffStatus(Long deliveryStaffId, String newStatus) {
        DeliveryStaff staff = em.find(DeliveryStaff.class, deliveryStaffId);
        if (staff != null) {
            staff.setDeliveryStaffStatus(newStatus);
            em.merge(staff);
        }
    }
    
    public List<DeliveryRatingFeedback> findFeedbackForDeliveryStaff(DeliveryStaff deliveryStaff) {
        try {
            return em.createQuery("SELECT d FROM DeliveryRatingFeedback d WHERE d.deliveryStaff = :deliveryStaff", DeliveryRatingFeedback.class)
                     .setParameter("deliveryStaff", deliveryStaff)
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            return new ArrayList<>(); // Return an empty list to avoid null pointer issues
        }
    }


    public Map<String, Long> getAgeDistributionFromIC() {
        try {
            // Adjusted query to fetch the IC numbers as String
            List<String> icList = em.createQuery(
                    "SELECT c.ic FROM DeliveryStaff c WHERE c.ic IS NOT NULL", String.class)
                    .getResultList();
            

            // Now calculate the age in Java
            Map<String, Long> ageDistribution = new HashMap<>();

            // Current year and month for age calculation
            Calendar today = Calendar.getInstance();
            int currentYear = today.get(Calendar.YEAR);
            int currentMonth = today.get(Calendar.MONTH) + 1;  // Months are 0-indexed in Calendar

            for (String ic : icList) {
                if (ic != null && ic.length() >= 12) { // Ensure valid IC format
                    String yearStr = ic.substring(0, 2);
                    String monthStr = ic.substring(2, 4);
                    String dayStr = ic.substring(4, 6);

                    int birthYear = Integer.parseInt(yearStr);
                    // Determine if the year is pre-2000 or post-2000
                    if (birthYear >= 0 && birthYear <= 22) { // Adjust for post-2000 births
                        birthYear += 2000;
                    } else {
                        birthYear += 1900;
                    }

                    int birthMonth = Integer.parseInt(monthStr);
                    int birthDay = Integer.parseInt(dayStr);

                    // Create a Calendar object for the birthdate
                    Calendar birthDate = new GregorianCalendar(birthYear, birthMonth - 1, birthDay);

                    // Calculate the age
                    int age = currentYear - birthYear;
                    if (currentMonth < birthMonth || (currentMonth == birthMonth && today.get(Calendar.DAY_OF_MONTH) < birthDay)) {
                        age--;  // Subtract 1 if the birthday hasn't occurred yet this year
                    }

                    // Group age into ranges (e.g., 20-29, 30-39)
                    String ageGroup = (age / 5) * 5 + "-" + ((age / 5) * 5 + 4);

                    // Add to the distribution map, counting occurrences of each age group
                    ageDistribution.put(ageGroup, ageDistribution.getOrDefault(ageGroup, 0L) + 1);
                }
            }


            return ageDistribution;
        } catch (Exception e) {
            e.printStackTrace();  // Log the exception for debugging
            throw new RuntimeException("Error fetching age distribution", e); // Rethrow if necessary
        }
    }
    public Map<String, Long> getGenderDistribution() {
        try {
            // Fetch the list of genders from the database
            List<String> genderList = em.createQuery(
                    "SELECT c.gender FROM DeliveryStaff c WHERE c.gender IS NOT NULL", String.class)
                    .getResultList();

            // Create a map to store the gender distribution
            Map<String, Long> genderDistribution = new HashMap<>();

            for (String gender : genderList) {
                // Normalize gender values to avoid issues with casing or unexpected inputs
                String normalizedGender = gender.trim().toLowerCase();

                // Use meaningful keys, e.g., "Male", "Female", "Other"
                switch (normalizedGender) {
                    case "m":
                    case "male":
                        normalizedGender = "Male";
                        break;
                    case "f":
                    case "female":
                        normalizedGender = "Female";
                        break;
                    default:
                        normalizedGender = "Other";
                        break;
                }

                // Update the distribution map
                genderDistribution.put(normalizedGender, genderDistribution.getOrDefault(normalizedGender, 0L) + 1);
            }

            return genderDistribution;
        } catch (Exception e) {
            e.printStackTrace();  // Log the exception for debugging
            throw new RuntimeException("Error fetching gender distribution", e); // Rethrow if necessary
        }
    }
}
