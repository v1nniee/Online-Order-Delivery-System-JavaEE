/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;

    @EJB
    private CustomerFacade customerFacade;

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

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        Object user = null;
        String name = null;

        try {
            switch (userType) {
                case "managing":
                    user = managingStaffFacade.findByEmail(email);
                    if (user != null && ((ManagingStaff) user).getPassword().equals(password)) {
                        name = ((ManagingStaff) user).getName();
                    }
                    break;
                case "delivery":
                    user = deliveryStaffFacade.findByEmail(email);
                    if (user != null && ((DeliveryStaff) user).getPassword().equals(password)) {
                        name = ((DeliveryStaff) user).getName();
                    }
                    break;
                case "customer":
                    user = customerFacade.findByEmail(email);
                    if (user != null && ((Customer) user).getPassword().equals(password)) {
                        name = ((Customer) user).getName();
                    }
                    break;
                default:
                    request.setAttribute("error", "Invalid user type selected.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
            }

            if (user == null || name == null) {
                request.setAttribute("error", "Invalid email or password. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userType", userType);

            request.getRequestDispatcher("Home").include(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
