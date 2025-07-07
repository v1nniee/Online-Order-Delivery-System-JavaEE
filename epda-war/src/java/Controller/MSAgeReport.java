/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CustomerFacade;
import model.DeliveryStaffFacade;
import model.ManagingStaffFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "MSAgeReport", urlPatterns = {"/MSAgeReport"})
public class MSAgeReport extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;
    @EJB
    private DeliveryStaffFacade deliveryStaffFacade;
    @EJB
    private ManagingStaffFacade managingStaffFacade;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch age distribution reports
        Map<String, Long> customerAge = customerFacade.getAgeDistributionFromIC();
        System.out.println("Customer Age Distribution: " + customerAge);
        Map<String, Long> deliveryAge = deliveryStaffFacade.getAgeDistributionFromIC();
        Map<String, Long> managingAge = managingStaffFacade.getAgeDistributionFromIC();

        // Add to request scope
        request.setAttribute("customerAge", customerAge);
        request.setAttribute("deliveryAge", deliveryAge);
        request.setAttribute("managingAge", managingAge);

        // Forward to JSP
        request.getRequestDispatcher("msAgeReport.jsp").forward(request, response);
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
