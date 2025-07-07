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
import model.CustomerOrder;
import model.CustomerOrderFacade;
import model.Delivery;
import model.DeliveryFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "DSUpdateDeliveryTaskStatus", urlPatterns = {"/DSUpdateDeliveryTaskStatus"})
public class DSUpdateDeliveryTaskStatus extends HttpServlet {

    @EJB
    private DeliveryFacade deliveryFacade;


    @EJB
    private CustomerOrderFacade customerOrderFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Retrieve parameters from the request
            Long deliveryId = Long.parseLong(request.getParameter("deliveryId"));
            String deliveryStatus = request.getParameter("deliveryStatus");

            // Find the delivery entity by ID
            Delivery delivery = deliveryFacade.find(deliveryId);

            if (delivery != null) {
                // Update the delivery status
                delivery.setDeliveryStatus(deliveryStatus);
                
                if ("Delivered".equalsIgnoreCase(deliveryStatus)) {
                    delivery.setCompletedDate(new java.util.Date());
                }
                
                deliveryFacade.edit(delivery);

                // Redirect back to the task list with a success message
                request.getSession().setAttribute("message", "Delivery status updated successfully!");
                response.sendRedirect("DSDisplayDeliveryTaskStatus");
            } else {
                // If the delivery is not found, redirect to an error page
                request.getSession().setAttribute("error", "Delivery not found!");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            // Handle exceptions and redirect to an error page
            request.getSession().setAttribute("error", "An error occurred while updating the delivery status.");
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
