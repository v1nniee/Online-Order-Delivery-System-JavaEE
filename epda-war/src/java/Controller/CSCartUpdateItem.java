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
import model.CustomerFacade;
import model.ShoppingCartItem;
import model.ShoppingCartItemFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSCartUpdateItem", urlPatterns = {"/CSCartUpdateItem"})
public class CSCartUpdateItem extends HttpServlet {

     @EJB
    private CustomerFacade customerFacade;

    @EJB
    private ShoppingCartItemFacade shoppingCartItemFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String itemIdStr = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");
        System.out.println("quantity:"+quantityStr);
        System.out.println("itemId:"+itemIdStr);

        if (action != null && itemIdStr != null && quantityStr != null) {
            try {
                Long itemId = Long.parseLong(itemIdStr);
                int quantity = Integer.parseInt(quantityStr);
                

                ShoppingCartItem item = customer.getItems().stream()
                        .filter(cartItem -> cartItem.getShoppingCartItemId().equals(itemId))
                        .findFirst().orElse(null);

                if (item != null) {
                    if ("add".equals(action)) {
                        quantity += 1;
                        System.out.println("quantity+:"+quantity);
                    } else if ("remove".equals(action)) {
                        quantity -= 1;
                        System.out.println("quantity:-"+quantity);
                    }
                    
                    if (quantity > 0) {
                        // Update quantity and persist changes
                        item.setQuantity(quantity);
                        shoppingCartItemFacade.edit(item);
                    } else {
                        
                        customer.getItems().remove(item);
                        customerFacade.edit(customer);
                        shoppingCartItemFacade.remove(item);
                    }

                    
                }
            } catch (NumberFormatException e) {
                // Log error and display a user-friendly message
                e.printStackTrace();
                request.setAttribute("errorMessage", "Invalid input data.");
            }
        }

        // Refresh customer and cart items
        Customer refreshedCustomer = customerFacade.find(customer.getCustomerId());
        session.setAttribute("user", refreshedCustomer);

        request.setAttribute("cartItems", refreshedCustomer.getItems());
        request.getRequestDispatcher("CSDisplayCartItems").forward(request, response);
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
