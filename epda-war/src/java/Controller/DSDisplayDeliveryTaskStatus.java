/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Delivery;
import model.DeliveryFacade;
import model.DeliveryStaff;

/**
 *
 * @author vinni
 */
@WebServlet(name = "DSDisplayDeliveryTaskStatus", urlPatterns = {"/DSDisplayDeliveryTaskStatus"})
public class DSDisplayDeliveryTaskStatus extends HttpServlet {

    @EJB
    private DeliveryFacade deliveryFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Ensure the session exists and the logged-in user is a DeliveryStaff
        if (session != null && session.getAttribute("user") instanceof DeliveryStaff) {
            DeliveryStaff deliveryStaff = (DeliveryStaff) session.getAttribute("user");
            
            // Retrieve deliveries assigned to the logged-in DeliveryStaff
            List<Delivery> deliveries = deliveryFacade.findDeliveriesByDeliveryStaff(deliveryStaff);
            
            // Set the deliveries attribute for the JSP page
            request.setAttribute("deliveries", deliveries);
            request.getRequestDispatcher("dsUpdateDeliveryTaskStatus.jsp").forward(request, response);
        } else {
            // Redirect to login if no valid session or user is not DeliveryStaff
            response.sendRedirect("login.jsp");
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
