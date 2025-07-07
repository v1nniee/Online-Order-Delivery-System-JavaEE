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
import model.Customer;
import model.DeliveryRatingFeedback;
import model.DeliveryRatingFeedbackFacade;
import model.DeliveryStaff;
import model.DeliveryStaffFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSRateCommentDeliveryService", urlPatterns = {"/CSRateCommentDeliveryService"})
public class CSRateCommentDeliveryService extends HttpServlet {

    @EJB
    private DeliveryRatingFeedbackFacade deliveryRatingFeedbackFacade;

    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Ensure the session exists and retrieve the logged-in customer
        if (session == null || !(session.getAttribute("user") instanceof Customer)) {
            // Redirect to login if no valid session or user is not a Customer
            response.sendRedirect("login.jsp");
            return;
        }

        Customer customer = (Customer) session.getAttribute("user");

        try {
            // Retrieve form parameters
            Long deliveryStaffId = Long.parseLong(request.getParameter("deliveryStaffId"));
            double rating = Double.parseDouble(request.getParameter("rating"));
            String feedback = request.getParameter("feedback");

            // Find the delivery staff
            DeliveryStaff deliveryStaff = deliveryStaffFacade.find(deliveryStaffId);

            if (deliveryStaff != null) {
                // Create and save the feedback
                DeliveryRatingFeedback deliveryRatingFeedback = new DeliveryRatingFeedback();
                deliveryRatingFeedback.setCustomer(customer); // Set the customer
                deliveryRatingFeedback.setDeliveryStaff(deliveryStaff);
                deliveryRatingFeedback.setRating(rating);
                deliveryRatingFeedback.setFeedback(feedback);

                deliveryRatingFeedbackFacade.create(deliveryRatingFeedback);

                // Redirect with a success message
                request.getSession().setAttribute("message", "Thank you for your feedback!");
                response.sendRedirect("CSDisplayCompletedOrder");
            } else {
                // Handle case where delivery staff is not found
                request.getSession().setAttribute("error", "Delivery staff not found.");
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            // Handle exceptions
            request.getSession().setAttribute("error", "An error occurred while saving feedback.");
            response.sendRedirect("error.jsp");
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
