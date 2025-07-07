/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;
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
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;
    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;

    @EJB
    private ManagingStaffFacade managingStaffFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String ic = request.getParameter("ic");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        
        try (PrintWriter out = response.getWriter()) {
            try {
                 Map<String, String> validationResult = validateUserInput(ic, password, phone, email);

                if ("false".equals(validationResult.get("valid"))) {
                    request.setAttribute("message",  validationResult.get("message"));
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                    
                } else {
                    Customer newCustomer = new Customer();
                    newCustomer.setName(name);
                    newCustomer.setPassword(password);
                    newCustomer.setGender(gender);
                    newCustomer.setPhone(phone);
                    newCustomer.setIc(ic);
                    newCustomer.setEmail(email);
                    newCustomer.setAddress(address);

                    customerFacade.create(newCustomer);
                    HttpSession session = request.getSession();
                    session.setAttribute("user", newCustomer);
                    session.setAttribute("userType", "customer");

                    request.getRequestDispatcher("Home").include(request, response);
                }
                
            } catch (Exception e) {
                e.printStackTrace(out);
                request.getRequestDispatcher("register.jsp").include(request, response);
                out.println("<br><br><br>Registration failed. Please check your input.");
            }
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
