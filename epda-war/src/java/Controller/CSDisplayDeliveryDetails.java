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

/**
 *
 * @author vinni
 */
@WebServlet(name = "CSDisplayDeliveryDetails", urlPatterns = {"/CSDisplayDeliveryDetails"})
public class CSDisplayDeliveryDetails extends HttpServlet {

    @EJB
    private CustomerOrderFacade customerOrderFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr != null) {
            Long orderId = Long.parseLong(orderIdStr);
            CustomerOrder order = customerOrderFacade.find(orderId);

            if (order != null && order.getDelivery() != null) {
                
                Delivery delivery = order.getDelivery();
                System.out.println("delivery delivery: "+delivery.toString());
                request.setAttribute("delivery", delivery);
            }
        }

        request.getRequestDispatcher("csDisplayDeliveryDetails.jsp").forward(request, response);
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
