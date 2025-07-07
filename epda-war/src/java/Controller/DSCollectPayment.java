/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CustomerOrder;
import model.CustomerOrderFacade;
import model.Payment;
import model.PaymentFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "DSCollectPayment", urlPatterns = {"/DSCollectPayment"})
public class DSCollectPayment extends HttpServlet {

     @EJB
    private CustomerOrderFacade customerOrderFacade;

    @EJB
    private PaymentFacade paymentFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve the order ID from the request
            Long orderId = Long.parseLong(request.getParameter("orderId"));

            // Find the customer order by ID
            CustomerOrder order = customerOrderFacade.find(orderId);

            if (order != null) {
                // Update order and payment statuses
                order.setOrderStatus("Completed");
                Payment payment = order.getPayment();
                if (payment != null) {
                    payment.setPaymentStatus("Collected");
                    payment.setPaymentDate(new Date());
                    paymentFacade.edit(payment);
                }

                // Save the updated order
                customerOrderFacade.edit(order);

                // Redirect back to the delivered orders list with a success message
                request.getSession().setAttribute("message", "Payment collected successfully for Order ID: " + orderId);
                response.sendRedirect("DSDisplayDeliveredOrder");
            } else {
                // If the order is not found, redirect to an error page
                request.getSession().setAttribute("error", "Order not found!");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            // Handle exceptions and redirect to an error page
            request.getSession().setAttribute("error", "An error occurred while collecting payment.");
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
