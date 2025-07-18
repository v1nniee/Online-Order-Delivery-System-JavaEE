/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DeliveryStaff;
import model.DeliveryStaffFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "DSUpdateDeliveryStaffStatus", urlPatterns = {"/DSUpdateDeliveryStaffStatus"})
public class DSUpdateDeliveryStaffStatus extends HttpServlet {

    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && "delivery".equals(session.getAttribute("userType"))) {
            DeliveryStaff user = (DeliveryStaff) session.getAttribute("user");

            String newStatus = request.getParameter("newStatus");

            // Update status in the database
            deliveryStaffFacade.updateDeliveryStaffStatus(user.getDeliveryStaffId(), newStatus);

            // Update the session attribute
            user.setDeliveryStaffStatus(newStatus);
            session.setAttribute("user", user);

            // Redirect back to the JSP
            request.getRequestDispatcher("dsUpdateDeliveryStaffStatus.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login if not authorized
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
