/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.CustomerFacade;
import model.CustomerOrder;
import model.CustomerOrderFacade;
import model.OrderItem;
import model.OrderItemFacade;
import model.Payment;
import model.PaymentFacade;
import model.ShoppingCartItem;
import model.ShoppingCartItemFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSPlaceOrder", urlPatterns = {"/CSPlaceOrder"})
public class CSPlaceOrder extends HttpServlet {

    @EJB
    private ShoppingCartItemFacade shoppingCartItemFacade;

    @EJB
    private OrderItemFacade orderItemFacade;

    @EJB
    private CustomerOrderFacade customerOrderFacade;
    
    
    @EJB
    private PaymentFacade paymentFacade; 
    
    @EJB
    private CustomerFacade customerFacade;
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

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<ShoppingCartItem> cartItems = customer.getItems();
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("CSDisplayCartItems");
            return;
        }
        List<ShoppingCartItem> itemsToRemove = new ArrayList<>(cartItems);

        CustomerOrder order = new CustomerOrder();
        order.setOrderDate(new Date());
        order.setOrderStatus("Pending");
        order.setCustomer(customer);

        double totalAmount = 0;
        List<OrderItem> orderItems = new ArrayList<>();
        for (ShoppingCartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItems.add(orderItem);
            orderItemFacade.create(orderItem); 
            totalAmount += cartItem.getProduct().getProductPrice() * cartItem.getQuantity();
        }
        order.setOrderItems(orderItems);
        order.setTotalAmount(totalAmount);

        String paymentMethod = request.getParameter("paymentMethod");
        Payment payment = new Payment();
        payment.setPaymentMethod(paymentMethod);
        payment.setPaymentStatus("Pending");
        payment.setPaymentDate(new Date());
        

        try {
            paymentFacade.create(payment);
            order.setPayment(payment);
            customerOrderFacade.create(order);

            customer.getItems().clear();
            customerFacade.edit(customer);
            
            for (ShoppingCartItem cartItem : itemsToRemove) {
                shoppingCartItemFacade.remove(cartItem); 
            }

            // Pass order details to JSP
            request.setAttribute("customerName", customer.getName());
            request.setAttribute("orderId", order.getOrderId());
            request.setAttribute("totalAmount", totalAmount);

            // Forward to the JSP page for display
            request.getRequestDispatcher("csOrderConfirmation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Logs the error to server logs for debugging
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your order.");
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
