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
import model.Delivery;
import model.DeliveryFacade;
import model.DeliveryStaff;
import model.DeliveryStaffFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "MSAssignDeliveryStaffToOrder", urlPatterns = {"/MSAssignDeliveryStaffToOrder"})
public class MSAssignDeliveryStaffToOrder extends HttpServlet {

    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;
    
    @EJB
    private CustomerOrderFacade customerOrderFacade;

    @EJB
    private DeliveryFacade deliveryFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String deliveryStaffIdParam = request.getParameter("deliveryStaffId");
        String orderIdParam = request.getParameter("orderId");
        
        System.out.println("Received deliveryStaffIdParam: " + deliveryStaffIdParam);
        System.out.println("Received orderIdParam: " + orderIdParam);

        if (deliveryStaffIdParam == null || orderIdParam == null) {
            request.setAttribute("errorMessage", "Missing required parameters: deliveryStaffId or orderId.");
            request.getRequestDispatcher("home.jsp").forward(request, response);
            return;
        }

        try {
            Long deliveryStaffId = Long.parseLong(deliveryStaffIdParam);
            Long orderId = Long.parseLong(orderIdParam);


            DeliveryStaff deliveryStaff = deliveryStaffFacade.find(deliveryStaffId);
            CustomerOrder customerOrder = customerOrderFacade.find(orderId);

            if (deliveryStaff == null || customerOrder == null) {
                request.setAttribute("errorMessage", "Invalid Delivery Staff ID or Order ID.");
                request.getRequestDispatcher("home.jsp").forward(request, response);
                return;
            }

            // Create and save the Delivery
            Delivery delivery = new Delivery();
            delivery.setDeliveryDate(new Date());
            delivery.setDeliveryStatus("Delivery Staff Assigned");
            delivery.setDeliveryStaff(deliveryStaff);
            delivery.setOrder(customerOrder);
            deliveryFacade.create(delivery); // Save the new delivery record

            // Update the order status
            customerOrder.setOrderStatus("Delivery Staff Assigned");
            customerOrder.setDelivery(delivery);
            customerOrderFacade.edit(customerOrder); // Update the order in the database

            // Redirect to the order view page
            response.sendRedirect("MSDisplayOrderForDelivery");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Error processing numerical IDs. Please check your input.");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
