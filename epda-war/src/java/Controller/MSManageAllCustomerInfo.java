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
@WebServlet(name = "MSManageAllCustomerInfo", urlPatterns = {"/MSManageAllCustomerInfo"})
public class MSManageAllCustomerInfo extends HttpServlet {

    
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
            case "search":
                searchCustomer(request, response);
                break;
            case "confirmDelete":
                deleteCustomer(request, response);
                break;
            case "confirmUpdate":
                updateCustomer(request, response);
                break;
            case "updateOwnInfo":
                updateOwnInfo(request, response);
                break;
            default:
                displayAllCustomers(request, response);
                break;
        }
    }

    private void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");

        List<Customer> customerList = customerFacade.findAll()
                .stream()
                .filter(customer -> customer.getName().toLowerCase().contains(search.toLowerCase())
                        || customer.getEmail().toLowerCase().contains(search.toLowerCase()))
                .collect(Collectors.toList());

        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("msManageAllCustomerInfo.jsp").forward(request, response);
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long customerId = Long.valueOf(request.getParameter("customerId"));

        Customer customer = customerFacade.find(customerId);
        if (customer != null) {
            customerFacade.remove(customer);
            request.setAttribute("message", "Customer deleted successfully.");
        } else {
            request.setAttribute("message", "Customer not found.");
        }

        displayAllCustomers(request, response);
    }


    private boolean isEmailDuplicate(String email, Long staffId) {
        List<ManagingStaff> managingStaffList = managingStaffFacade.findAll();
        List<DeliveryStaff> deliveryStaffList = deliveryStaffFacade.findAll();
        List<Customer> customerList = customerFacade.findAll();

        // Check if email exists in Customer list (excluding current staffId)
        boolean isDuplicateInCustomer = customerList.stream()
                .anyMatch(customer -> customer.getEmail().equalsIgnoreCase(email) && (staffId == null || !customer.getCustomerId().equals(staffId)));

        // Check if email exists in ManagingStaff or DeliveryStaff lists
        boolean isDuplicateInManagingOrDeliveryForCustomer = managingStaffList.stream()
                .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email)) ||
                deliveryStaffList.stream()
                .anyMatch(staff -> staff.getEmail().equalsIgnoreCase(email));

        return isDuplicateInCustomer || isDuplicateInManagingOrDeliveryForCustomer;

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
    
    private Map<String, String> validateCustomerInput(String ic, String password, String phone, String email, Long customerId) {
        Map<String, String> result = new HashMap<>();
        
        if (isEmailDuplicate(email, customerId)) {
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




     protected void updateCustomer(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        Long customerId = Long.parseLong(request.getParameter("customerId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String ic = request.getParameter("ic");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        // Retrieve the existing customer record
        Customer customer = customerFacade.find(customerId);

        if (customer != null) {
            Map<String, String> validationResult = validateCustomerInput(ic, password, phone, email, customerId);

            if ("false".equals(validationResult.get("valid"))) {
                request.setAttribute("message",  validationResult.get("message"));
                request.setAttribute("showModal", true);
                request.getRequestDispatcher("MSDisplayAllCustomerInfo").forward(request, response);
                return;
            } else {
                customer.setName(name);
                customer.setEmail(email);
                customer.setPhone(phone);
                customer.setGender(gender);
                customer.setIc(ic);
                customer.setAddress(address);
                customer.setPassword(password);

                try {
                    customerFacade.edit(customer); // Save changes to the database
                    request.setAttribute("message", "Customer updated successfully.");
                } catch (Exception e) {
                    request.setAttribute("message", "Error updating customer: " + e.getMessage());
                }
            }
        } else {
            request.setAttribute("message", "Customer not found.");
        }

        // Redirect back to the customer management page
        request.getRequestDispatcher("MSDisplayAllCustomerInfo").forward(request, response);
    }

    private void displayAllCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customerList = customerFacade.findAll();
        request.setAttribute("customerList", customerList);
        request.getRequestDispatcher("msManageAllCustomerInfo.jsp").forward(request, response);
    }
    
    private void updateOwnInfo(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        // Retrieve the user object from the session
        Customer currentUser = (Customer) request.getSession().getAttribute("user");

        if (currentUser == null) {
            request.setAttribute("message", "User not logged in or session expired.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Extract the user ID from the user object
        Long currentUserId = currentUser.getCustomerId();

        // Get the updated data from the request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String ic = request.getParameter("ic");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        // Retrieve the existing user record from the database
        Customer user = customerFacade.find(currentUserId);

        if (user != null) {
            Map<String, String> validationResult = validateCustomerInput(ic, password, phone, email, currentUserId);

            if ("false".equals(validationResult.get("valid"))) {
                System.out.println("hiiiiiiiii");
                request.setAttribute("message",  validationResult.get("message"));

            } else {
                user.setName(name);
                user.setEmail(email);
                user.setPhone(phone);
                user.setGender(gender);
                user.setIc(ic);
                user.setAddress(address);
                user.setPassword(password);

                try {
                    customerFacade.edit(user); // Save changes to the database

                    // Update the session object
                    request.getSession().setAttribute("user", user);

                    request.setAttribute("message", "Your information was updated successfully.");
                } catch (Exception e) {
                    request.setAttribute("message", "Error updating your information: " + e.getMessage());
                }
            }
        } else {
            request.setAttribute("message", "User not found.");
        }

        // Redirect to the user profile page or another relevant page
        request.getRequestDispatcher("csEditCustomer.jsp").forward(request, response);
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
