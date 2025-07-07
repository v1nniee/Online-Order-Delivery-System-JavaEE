/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;
import model.CustomerFacade;
import model.DeliveryStaff;
import model.DeliveryStaffFacade;
import model.ManagingStaff;
import model.ManagingStaffFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "MSManageStaffInfo", urlPatterns = {"/MSManageStaffInfo"})
public class MSManageStaffInfo extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;

    @EJB
    private ManagingStaffFacade managingStaffFacade;
    
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addStaff(request, response);
                break;
            case "search":
                searchForStaff(request, response);
                break;
            case "searchForDelete":
                searchForDelete(request, response);
                break;
            case "confirmDelete":
                confirmDelete(request, response);
                break;
            case "confirmUpdate":
                confirmUpdate(request, response);
                break;
            case "updateOwnInfo":
                updateOwnInfo(request, response);
                break;

            default:
                response.sendRedirect("msManageStaffInfo.jsp");
                break;
        }
    }

   
    
    private boolean isValidMalaysiaIC(String ic) {
        // Malaysian IC format is typically ##########
        return ic.matches("\\d{12}");
    }


    private boolean isValidPassword(String password) {
        // Password must be more than 5 characters
        return password != null && password.length() > 5;
    }

    private boolean isValidMalaysiaPhoneNumber(String phone) {
        // Malaysian phone numbers usually start with 01 and are between 10 to 11 digits in length
        return phone.matches("^01\\d{8,9}$");
    }
    
   private boolean isEmailDuplicate(String email) {
        List<ManagingStaff> managingStaffList = managingStaffFacade.findAll();
        List<DeliveryStaff> deliveryStaffList = deliveryStaffFacade.findAll();
        List<Customer> customerList = customerFacade.findAll();

        return managingStaffList.stream().anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
               deliveryStaffList.stream().anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
               customerList.stream().anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)); 
    }
   
   private Map<String, String> validateUserInput(String ic, String password, String phone, String email) {
        Map<String, String> result = new HashMap<>();
        
        if (isEmailDuplicate(email)) {
            result.put("valid", "false");
            result.put("message", "Email is already in use by another user.");
            return result;
        }

        if (!isValidMalaysiaIC(ic)) {
            result.put("valid", "false");
            result.put("message", "Invalid Malaysian IC format.");
            return result;
        }

        if (!isValidPassword(password)) {
            result.put("valid", "false");
            result.put("message", "Password must be more than 5 characters.");
            return result;
        }

        if (!isValidMalaysiaPhoneNumber(phone)) {
            result.put("valid", "false");
            result.put("message", "Invalid Malaysian phone number format.");
            return result;
        }

        result.put("valid", "true");
        return result;
    }

    private boolean isEmailDuplicate(String email, Long staffId, String staffType) {
        List<ManagingStaff> managingStaffList = managingStaffFacade.findAll();
        List<DeliveryStaff> deliveryStaffList = deliveryStaffFacade.findAll();
        List<Customer> customerList = customerFacade.findAll();

        switch (staffType.toLowerCase()) {
            case "managing":
                // Check if email exists in ManagingStaff list (excluding current staffId)
                boolean isDuplicateInManaging = managingStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email) && (staffId == null || !staff.getmanagingStaffId().equals(staffId)));

                // Check if email exists in DeliveryStaff or Customer lists
                boolean isDuplicateInDeliveryOrCustomer = deliveryStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
                        customerList.stream()
                        .anyMatch(customer -> customer.getEmail().equalsIgnoreCase(email));

                return isDuplicateInManaging || isDuplicateInDeliveryOrCustomer;

            case "delivery":
                // Check if email exists in DeliveryStaff list (excluding current staffId)
                boolean isDuplicateInDelivery = deliveryStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email) && (staffId == null || !staff.getDeliveryStaffId().equals(staffId)));

                // Check if email exists in ManagingStaff or Customer lists
                boolean isDuplicateInManagingOrCustomerForDelivery = managingStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
                        customerList.stream()
                        .anyMatch(customer -> customer.getEmail().equalsIgnoreCase(email));

                return isDuplicateInDelivery || isDuplicateInManagingOrCustomerForDelivery;

            case "customer":
                // Check if email exists in Customer list (excluding current staffId)
                boolean isDuplicateInCustomer = customerList.stream()
                        .anyMatch(customer -> customer.getEmail().equalsIgnoreCase(email) && (staffId == null || !customer.getCustomerId().equals(staffId)));

                // Check if email exists in ManagingStaff or DeliveryStaff lists
                boolean isDuplicateInManagingOrDeliveryForCustomer = managingStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
                        deliveryStaffList.stream()
                        .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email));

                return isDuplicateInCustomer || isDuplicateInManagingOrDeliveryForCustomer;

            default:
                throw new IllegalArgumentException("Invalid staff type provided: " + staffType);
        }
    }
    
    
    
    private Map<String, String> validateUserInput(String ic, String password, String phone, String email, Long staffId, String staffType) {
        Map<String, String> result = new HashMap<>();
        
        if (isEmailDuplicate(email, staffId,staffType)) {
            result.put("valid", "false");
            result.put("message", "Email is already in use by another user.");
            return result;
        }

        if (!isValidMalaysiaIC(ic)) {
            result.put("valid", "false");
            result.put("message", "Invalid Malaysian IC format.");
            return result;
        }

        if (!isValidPassword(password)) {
            result.put("valid", "false");
            result.put("message", "Password must be more than 5 characters.");
            return result;
        }

        if (!isValidMalaysiaPhoneNumber(phone)) {
            result.put("valid", "false");
            result.put("message", "Invalid Malaysian phone number format.");
            return result;
        }

        result.put("valid", "true");
        return result;
    }
    
    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        String staffType = request.getParameter("staffType");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String ic = request.getParameter("ic");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Map<String, String> validationResult = validateUserInput(ic, password, phone, email);

        if ("false".equals(validationResult.get("valid"))) {
            request.setAttribute("message",  validationResult.get("message"));
            request.setAttribute("showModal", true);
            request.getRequestDispatcher("MSDisplayAllStaffInfo").forward(request, response);
            return;
        }

        if ("managing".equals(staffType)) {
            // Create a ManagingStaff object with all the required fields
            ManagingStaff staff = new ManagingStaff(null, name, password, gender, phone, ic, email, address);
            managingStaffFacade.create(staff); // Persist the staff object
        } else if ("delivery".equals(staffType)) {
            // Create a DeliveryStaff object with all the required fields
            DeliveryStaff staff = new DeliveryStaff(null, name, password, gender, phone, ic, email, address);
            deliveryStaffFacade.create(staff); // Persist the staff object
        }

        // Set a success message and forward the request to display all staff info
        request.setAttribute("message", "Staff added successfully.");
        request.getRequestDispatcher("MSDisplayAllStaffInfo").forward(request, response);
    }



    private void searchForStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");

        List<ManagingStaff> managingStaffList = managingStaffFacade.findAll();
        List<DeliveryStaff> deliveryStaffList = deliveryStaffFacade.findAll();

        if (search != null && !search.isEmpty()) {
            managingStaffList = managingStaffList.stream()
                    .filter(staff -> staff.getName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList());

            deliveryStaffList = deliveryStaffList.stream()
                    .filter(staff -> staff.getName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList());
        }

        request.setAttribute("managingStaffList", managingStaffList);
        request.setAttribute("deliveryStaffList", deliveryStaffList);
        request.getRequestDispatcher("msManageStaffInfo.jsp").forward(request, response);
    }

    private void searchForDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffType = request.getParameter("staffType");
        String email = request.getParameter("email");
        Object staff = null;

        if ("managing".equals(staffType)) {
            staff = managingStaffFacade.findByEmail(email);
        } else if ("delivery".equals(staffType)) {
            staff = deliveryStaffFacade.findByEmail(email);
        }

        if (staff != null) {
            request.setAttribute("staff", staff);
            request.setAttribute("staffType", staffType);
        } else {
            request.setAttribute("message", "Staff not found.");
        }

        request.getRequestDispatcher("MSDisplayAllStaffInfo").forward(request, response);
    }

    private void confirmDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long staffId = Long.parseLong(request.getParameter("staffId"));
        String staffType = request.getParameter("staffType");

        if ("managing".equals(staffType)) {
            ManagingStaff staff = managingStaffFacade.find(staffId);
            if (staff != null) managingStaffFacade.remove(staff);
        } else if ("delivery".equals(staffType)) {
            DeliveryStaff staff = deliveryStaffFacade.find(staffId);
            if (staff != null) deliveryStaffFacade.remove(staff);
        }

        request.setAttribute("message", "Staff deleted successfully.");
        request.getRequestDispatcher("MSDisplayAllStaffInfo").forward(request, response);
    }

    private void confirmUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffType = request.getParameter("staffType");
        Long staffId = Long.parseLong(request.getParameter("staffId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String ic = request.getParameter("ic");

        Map<String, String> validationResult = validateUserInput(ic, password, phone, email, staffId,staffType);

        if ("false".equals(validationResult.get("valid"))) {
            request.setAttribute("message",  validationResult.get("message"));
            request.setAttribute("showModal", true);
            request.getRequestDispatcher("MSDisplayAllStaffInfo").forward(request, response);
            return;
        }

        if ("managing".equals(staffType)) {
            ManagingStaff staff = managingStaffFacade.find(staffId);
            if (staff != null) {
                staff.setName(name);
                staff.setEmail(email);
                staff.setPhone(phone);
                staff.setAddress(address);
                staff.setPassword(password);
                staff.setGender(gender);
                staff.setIc(ic);
                managingStaffFacade.edit(staff);
            }
        } else if ("delivery".equals(staffType)) {
            DeliveryStaff staff = deliveryStaffFacade.find(staffId);
            if (staff != null) {
                staff.setName(name);
                staff.setEmail(email);
                staff.setPhone(phone);
                staff.setAddress(address);
                staff.setPassword(password);
                staff.setGender(gender);
                staff.setIc(ic);
                deliveryStaffFacade.edit(staff);
            }
        }
        response.sendRedirect("MSDisplayAllStaffInfo");
    }

    private void updateOwnInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeliveryStaff currentUser = (DeliveryStaff) request.getSession().getAttribute("user");

        if (currentUser == null) {
            request.setAttribute("message", "User not logged in or session expired.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        // Extract the user ID from the user object
        Long currentUserId = currentUser.getDeliveryStaffId();

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String ic = request.getParameter("ic");
        String address = request.getParameter("address");

        Map<String, String> validationResult = validateUserInput(ic, password, phone, email, currentUserId,"delivery");

        if ("false".equals(validationResult.get("valid"))) {
            request.setAttribute("message",  validationResult.get("message"));
            request.getRequestDispatcher("dsEditDeliveryStaff.jsp").forward(request, response);
            return;
        }

        DeliveryStaff staff = deliveryStaffFacade.find(currentUserId);
        if (staff != null) {
            // Debugging to confirm old values
            System.out.println("Old staff values: " + staff);

            staff.setName(name);
            staff.setPassword(password);
            staff.setGender(gender);
            staff.setPhone(phone);
            staff.setIc(ic);
            staff.setAddress(address);

            System.out.println("Updated staff values: " + staff);

            try {
                deliveryStaffFacade.edit(staff);
                // Update the session attribute with the updated staff object
                request.getSession().setAttribute("user", staff);
                request.setAttribute("message", "Information updated successfully.");
            } catch (Exception e) {
                e.printStackTrace(); // Log the error
                request.setAttribute("message", "Failed to update information: " + e.getMessage());
            }
        } else {
            request.setAttribute("message", "Staff not found.");
        }

        request.getRequestDispatcher("dsEditDeliveryStaff.jsp").forward(request, response);
    }
    




    private void populateStaffData(Object staff, HttpServletRequest request) {
        if (staff instanceof ManagingStaff) {
            ((ManagingStaff) staff).setName(request.getParameter("name"));
            ((ManagingStaff) staff).setEmail(request.getParameter("email"));
            ((ManagingStaff) staff).setPhone(request.getParameter("phone"));
            ((ManagingStaff) staff).setAddress(request.getParameter("address"));
        } else if (staff instanceof DeliveryStaff) {
            ((DeliveryStaff) staff).setName(request.getParameter("name"));
            ((DeliveryStaff) staff).setEmail(request.getParameter("email"));
            ((DeliveryStaff) staff).setPhone(request.getParameter("phone"));
            ((DeliveryStaff) staff).setAddress(request.getParameter("address"));
        }
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
