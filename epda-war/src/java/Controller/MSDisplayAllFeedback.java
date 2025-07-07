/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DeliveryRatingFeedback;
import model.DeliveryRatingFeedbackFacade;
import model.ManagingStaff;

/**
 *
 * @author vinni
 */
@WebServlet(name = "MSDisplayAllFeedback", urlPatterns = {"/MSDisplayAllFeedback"})
public class MSDisplayAllFeedback extends HttpServlet {
    @EJB
    private DeliveryRatingFeedbackFacade deliveryRatingFeedbackFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Ensure the session exists and the logged-in user is a ManagingStaff
        if (session != null && session.getAttribute("user") instanceof ManagingStaff) {
            // Retrieve all feedback
            List<DeliveryRatingFeedback> allFeedback = deliveryRatingFeedbackFacade.findAll();

            request.setAttribute("allFeedback", allFeedback);
            request.getRequestDispatcher("msDisplayAllFeedback.jsp").forward(request, response);
        } else {
            // Redirect to login if no valid session or user is not a ManagingStaff
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
