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
import model.CustomerOrder;
import model.CustomerOrderFacade;
import model.Payment;
import model.PaymentFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSDeleteOrder", urlPatterns = {"/CSDeleteOrder"})
public class CSDeleteOrder extends HttpServlet {

    @EJB
    private CustomerOrderFacade customerOrderFacade;

    @EJB
    private PaymentFacade paymentFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr != null) {
            try {
                Long orderId = Long.parseLong(orderIdStr);
                CustomerOrder order = customerOrderFacade.find(orderId);

                if (order != null && order.getCustomer().equals(customer)) {
                    // First, delete the order
                    customerOrderFacade.remove(order);
                    System.out.println("Order with ID " + orderId + " deleted successfully.");

                    // Then, delete the associated payment if it exists
                    Payment payment = order.getPayment();
                    if (payment != null) {
                        paymentFacade.remove(payment);
                        System.out.println("Associated payment with ID " + payment.getPaymentId() + " deleted successfully.");
                    }

                    response.sendRedirect("CSDisplayOrder?message=Order and payment deleted successfully!");
                } else {
                    response.sendRedirect("CSDisplayOrder?message=Invalid order or insufficient permissions.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("CSDisplayOrder?message=An error occurred while deleting the order.");
            }
        } else {
            response.sendRedirect("CSDisplayOrder?message=No order ID provided.");
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
