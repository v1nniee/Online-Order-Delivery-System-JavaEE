/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import model.Product;
import model.ProductFacade;
import model.ShoppingCartItem;
import model.ShoppingCartItemFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSAddProducttoCart", urlPatterns = {"/CSAddProducttoCart"})
public class CSAddProducttoCart extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

    @EJB
    private ShoppingCartItemFacade shoppingCartItemFacade;

    @EJB
    private ProductFacade productFacade;
    
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
        String action = request.getParameter("action");

        if ("addToCart".equals(action)) {
            addToCart(request, response);
        } else {
            response.sendRedirect("CSDisplayProductCatalog");
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        Long productId = Long.parseLong(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Product product = productFacade.find(productId);
        if (product == null) {
            throw new ServletException("Product not found for ID: " + productId);
        }

        System.out.println("Customer ID: " + customer.getCustomerId());
        System.out.println("Product ID: " + product.getProductId());
        System.out.println("Quantity: " + quantity);

        // Check if the item already exists in the customer's cart
        boolean itemExists = false;
        for (ShoppingCartItem existingItem : customer.getItems()) {
            if (existingItem.getProduct().getProductId().equals(productId)) {
                // If the item exists, update its quantity
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                shoppingCartItemFacade.edit(existingItem); // Persist the updated item
                itemExists = true;
                break;
            }
        }

        if (!itemExists) {
            // If the item does not exist, create a new ShoppingCartItem
            ShoppingCartItem item = new ShoppingCartItem();
            item.setProduct(product);    // Set the product
            item.setQuantity(quantity);  // Set the quantity

            // Add the item to the customer's cart
            customer.addItem(item);

            // Persist the new item using shoppingCartItemFacade
            shoppingCartItemFacade.create(item);
        }

        // Persist the updated customer
        customerFacade.edit(customer);

        // Redirect back to the product catalog or cart page
        request.getRequestDispatcher("CSDisplayProductCatalog").forward(request, response);
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