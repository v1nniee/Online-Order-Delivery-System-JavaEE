/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Product;
import model.ProductFacade;

/**
 *
 * @author vinni
 */
@WebServlet(name = "MSManageProductInfo", urlPatterns = {"/MSManageProductInfo"})
@MultipartConfig
public class MSManageProductInfo extends HttpServlet {

    @EJB
    private ProductFacade productFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "searchForDelete":
                searchForDelete(request, response);
                break;
            case "confirmDelete":
                confirmDelete(request, response);
                break;
            case "search":
                searchForProduct(request, response);
                break;
            case "searchForUpdate":
                searchForUpdate(request, response);
                break;
            case "confirmUpdate":
                updateProduct(request, response);
                break;
            default:
                response.sendRedirect("MSDisplayProductInfo");
                break;
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract product details from the request
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        double productPrice = Double.valueOf(request.getParameter("productPrice"));

        List<Product> productList = productFacade.findAll();
        boolean productExists = productList.stream()
            .anyMatch(product -> product.getProductName().equalsIgnoreCase(productName));

        if (productExists) {
            request.setAttribute("message", "Product name already exists. Please choose a different name.");
            request.setAttribute("showModal", true);
            request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
            return;
        }

        // Handling file upload
        Part filePart = request.getPart("productImage");
        byte[] imageBytes = null;
        String imageType = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream();
                 ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                int nRead;
                byte[] data = new byte[1024];
                while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                imageBytes = buffer.toByteArray(); // Read the image data as a byte array
            }

            // Detect MIME type from the input stream
            imageType = filePart.getContentType();
            if (imageType == null || !imageType.startsWith("image/")) {
                throw new ServletException("Uploaded file is not an image.");
            }
        }

        // Create and set properties for the product
        Product product = new Product();
        product.setProductName(productName);
        product.setProductDescription(productDescription);
        product.setProductPrice(productPrice);
        product.setProductImage(imageBytes);

        // Save the product using EJB
        productFacade.create(product);

        // Set a success message and forward the request
        request.setAttribute("message", "Product added successfully.");
        request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
    }
    

    
    private void searchForDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        Product product = productFacade.findByProductName(productName);
        if (product != null) {
            if (product.getProductImage() != null) {
                String base64Image = Base64.getEncoder().encodeToString(product.getProductImage());
                product.setBase64Image(base64Image);
            }
            request.setAttribute("product", product);
        } else {
            request.setAttribute("message", "Product not found.");
        }
        request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
    }


    private void confirmDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the productId from the request
        String productId = request.getParameter("productId");

        if (productId != null && !productId.isEmpty()) {
            try {
                Product product = productFacade.find(Long.parseLong(productId));

                if (product != null) {
                    productFacade.remove(product);
                    request.setAttribute("message", "Product deleted successfully.");
                } else {
                    request.setAttribute("message", "Product not found.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Invalid product ID.");
            }
        } else {
            request.setAttribute("message", "Product ID is required.");
        }

        // Forward back to the manage product page
        request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
    }


    private void searchForProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        if ("search".equals(action) && search != null && !search.isEmpty()) {
            List<Product> productList = productFacade.findAll();
            productList = productList.stream()
                    .filter(product -> product.getProductName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList()); // Use Collectors.toList() for compatibility
            for (Product product : productList) {
                if (product.getProductImage() != null) {
                    product.setBase64Image(Base64.getEncoder().encodeToString(product.getProductImage()));
                }
            }
            request.setAttribute("productList", productList);
        } else {
            List<Product> productList = productFacade.findAll();
            for (Product product : productList) {
                if (product.getProductImage() != null) {
                    product.setBase64Image(Base64.getEncoder().encodeToString(product.getProductImage()));
                }
            }
            request.setAttribute("productList", productList);
        }
        request.getRequestDispatcher("msManageProduct.jsp").forward(request, response);
    }

    private void searchForUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        Product product = productFacade.findByProductName(productName);

        if (product != null) {
            request.setAttribute("product", product);
        } else {
            request.setAttribute("message", "Product not found.");
        }
        request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long productId = Long.parseLong(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        Double productPrice = Double.valueOf(request.getParameter("productPrice"));

        // Retrieve the existing product
        Product product = productFacade.find(productId);

        if (product != null) {
            // Check if product name already exists for a different product
            List<Product> productList = productFacade.findAll();
            boolean productExists = productList.stream()
                .anyMatch(p -> !p.getProductId().equals(productId) && p.getProductName().equalsIgnoreCase(productName));

            if (productExists) {
                request.setAttribute("message", "Product name already exists. Please choose a different name.");
                request.setAttribute("showModal", true);
                request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
                return;
            }

            product.setProductName(productName);
            product.setProductDescription(productDescription);
            product.setProductPrice(productPrice);

            // Handle new image upload
            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                try (InputStream inputStream = filePart.getInputStream();
                     ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                    byte[] data = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(data, 0, data.length)) != -1) {
                        buffer.write(data, 0, bytesRead);
                    }
                    buffer.flush();
                    product.setProductImage(buffer.toByteArray());
                }
            }

            // Update the product in the database
            productFacade.edit(product);

            request.setAttribute("message", "Product updated successfully.");
        } else {
            request.setAttribute("message", "Product not found.");
        }

        // Redirect to the product management page
        request.getRequestDispatcher("MSDisplayProductInfo").forward(request, response);
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
