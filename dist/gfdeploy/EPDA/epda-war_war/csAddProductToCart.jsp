<%@page import="java.util.Base64"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Product to Cart</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            padding: 100px;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
        }
        .product-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .product-card h3 {
            color: #444;
            font-size: 20px;
            margin-bottom: 10px;
        }
        .product-card p {
            margin: 8px 0;
            color: #555;
            font-size: 14px;
        }
        .product-card img {
            border-radius: 8px;
            margin: 10px auto; /* Centers the image horizontally */
            width: 150px;
            height: 150px; /* Fixed size for all images */
            object-fit: cover; /* Ensures the image fits without distortion */
            display: block; /* Ensures proper centering */
        }
        .add-button {
            padding: 10px 15px;
            font-size: 14px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: auto; /* Ensures button is aligned at the bottom */
        }
        .add-button:hover {
            background-color: #218838;
        }
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            width: 320px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
        }
        .modal-content h3 {
            margin-bottom: 15px;
            font-size: 18px;
        }
        .modal-content button {
            padding: 8px 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .modal-content button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Product Catalog</h2>

        <!-- Check if product list is empty -->
        <c:choose>
            <c:when test="${empty productList}">
                <p>No products available at the moment.</p>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach var="product" items="${productList}">
                        <div class="product-card">
                            <h3>${product.productName}</h3>
                            <p>${product.productDescription}</p>
                            <p>Price: RM <fmt:formatNumber value="${product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                            <c:if test="${not empty product.base64Image}">
                                <img src="data:image/jpeg;base64,${product.base64Image}" alt="Product Image" />
                            </c:if>
                            <c:if test="${empty product.base64Image}">
                                <img src="placeholder.jpg" alt="No Image Available" />
                            </c:if>
                            <button class="add-button" onclick="openModal('${product.productId}')">Add to Cart</button>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Modal for Quantity Selection -->
    <div id="quantityModal" class="modal">
        <div class="modal-content">
            <h3>Select Quantity</h3>
            <form action="CSAddProducttoCart" method="post">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="productId" id="modalProductId">
                <label for="quantity">Quantity:</label>
                <input type="number" name="quantity" id="quantity" min="1" value="1" required>
                <button type="submit" class="add-button confirm">Add to Cart</button>
            </form>
        </div>
    </div>
    <script>
        function openModal(productId) {
            document.getElementById("modalProductId").value = productId;
            document.getElementById("quantityModal").style.display = "flex";
        }

        function closeModal() {
            document.getElementById("quantityModal").style.display = "none";
        }
        
        function preventNegative(event) {
            if (event.key === '-' || event.key === 'e' || event.key === 'E') {
                event.preventDefault();
            }
        }

    </script>
</body>
</html>
