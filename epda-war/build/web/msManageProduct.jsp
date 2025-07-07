<%@page import="java.util.Base64"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.Base64"%>
<%@page import="model.Product"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Products</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: block;
        }

        .container {
            padding-top: 100px;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .navbar {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #333;
            width: 100%;
            padding: 10px;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .navbar a {
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            font-family: Arial, sans-serif;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #555;
            color: white;
        }

        /* Add padding to body or main container to avoid overlap */
        .container {
            padding-top: 100px; /* Adjust this value based on the height of your navbar */
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Add Product Form */
        .add-form {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .add-form form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .add-form input, .add-form button {
            margin: 10px 0;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .add-form button {
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-form button:hover {
            background-color: #218838;
        }

        /* Search Bar */
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-bar input[type="text"] {
            width: 60%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-bar button {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-bar button:hover {
            background-color: #0056b3;
        }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .product-card {
            background-color: #fff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .product-card img {
            border-radius: 8px;
            margin: 10px auto; /* Centers the image horizontally */
            width: 150px; /* Fixed width */
            height: 150px; /* Fixed height */
            object-fit: cover; /* Ensures the image fits without distortion */
            display: block; /* Ensures proper centering */
        }

        .product-card {
            background-color: #fff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            display: flex;
            flex-direction: column; /* Ensures the content stacks vertically */
            justify-content: space-between; /* Ensures equal spacing */
            align-items: center; /* Centers content horizontally */
        }

        .product-card button {
            margin-top: auto; /* Pushes the buttons to the bottom of the card */
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .update-button {
            background-color: #007bff;
            color: #fff;
        }

        .delete-button:hover {
            background-color: #cc0000;
        }

        .update-button:hover {
            background-color: #0056b3;
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

        .modal-content button {
            margin-top: 15px;
            padding: 10px 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>

    <div class="container">
        <h2>Manage Product Information</h2>
        <!-- Add Product Form -->
        <div class="add-form">
            <h2>Add New Product</h2>
            <form action="MSManageProductInfo" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <input type="text" name="productName" placeholder="Product Name" required>
                <input type="text" name="productDescription" placeholder="Product Description" required>
                <input type="number" name="productPrice" placeholder="Price" step="0.01" min="0.1" required>
                <input type="file" name="productImage" accept="image/*" required>
                <button type="submit">Add Product</button>
            </form>
        </div>

        <!-- Search Bar -->        
        <div class="search-bar">
            <form action="MSManageProductInfo" method="get" style="display: inline;">
                <input type="hidden" name="action" value="search">
                <input type="text" name="search" placeholder="Search products by name...">
                <button type="submit">Search</button>
            </form>
            <form action="MSManageProductInfo" method="get" style="display: inline;">
                <input type="hidden" name="action" value="displayAll">
                <button type="submit">Display All Products</button>
            </form>
        </div>

        <!-- Product Grid -->
        <div class="product-grid">
            <c:forEach var="product" items="${productList}">
                <div class="product-card">
                    <h3>${product.productName}</h3>
                    <p>${product.productDescription}</p>
                    <p>Price: RM <fmt:formatNumber value="${product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                    <c:if test="${not empty product.base64Image}">
                        <img src="data:image/jpeg;base64,${product.base64Image}" alt="Product Image">
                    </c:if>
                    <c:if test="${empty product.base64Image}">
                        <img src="placeholder.jpg" alt="No Image Available">
                    </c:if>
                    <button class="update-button" 
                        onclick="openUpdateModal('${product.productId}', '${product.productName}', '${product.productDescription}', ${product.productPrice})">
                        Update
                    </button>

                    <button class="delete-button" 
                        onclick="openDeleteModal('${product.productId}', '${product.productName}')">
                        Delete
                    </button>
                </div>
            </c:forEach>
        </div>
        
        <div id="updateModal" class="modal">
        <div class="modal-content">
            <h3>Update Product Details</h3>
            <form action="MSManageProductInfo" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="confirmUpdate">
                <input type="hidden" name="productId" id="updateProductId">

                <label for="updateProductName">Product Name:</label>
                <input type="text" name="productName" id="updateProductName" required>

                <label for="updateProductDescription">Product Description:</label>
                <input type="text" name="productDescription" id="updateProductDescription" required>

                <label for="updateProductPrice">Product Price: RM</label>
                <input type="number" name="productPrice" id="updateProductPrice" step="0.01" min="0.1" required>


                <label for="updateProductImage">Update Product Image:</label>
                <input type="file" name="productImage" id="updateProductImage" accept="image/*">

                <button type="submit" class="modal-button confirm">Save Changes</button>
                <button type="button" class="modal-button cancel" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Delete Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h3>Delete Product</h3>
            <p>Are you sure you want to delete <strong id="deleteProductName"></strong>?</p>
            <form action="MSManageProductInfo" method="post">
                <input type="hidden" name="action" value="confirmDelete">
                <input type="hidden" name="productId" id="deleteProductId">
                <button type="submit" class="modal-button confirm">Delete</button>
                <button type="button" class="modal-button cancel" onclick="closeDeleteModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Product Exists Modal -->
    <c:if test="${not empty showModal}">
        <div id="productExistsModal" class="modal" style="display: flex;">
            <div class="modal-content">
                <h3>Product Already Exists</h3>
                <p>${message}</p>
                <button type="button" class="modal-button confirm" onclick="closeProductExistsModal()">OK</button>
            </div>
        </div>
</c:if>

    <script>
        function openUpdateModal(productId, productName, productDescription, productPrice, productStock) {
            // Get modal elements
            const modal = document.getElementById("updateModal");
            document.getElementById("updateProductId").value = productId;
            document.getElementById("updateProductName").value = productName;
            document.getElementById("updateProductDescription").value = productDescription;
            document.getElementById("updateProductPrice").value = productPrice;

            // Display the modal
            modal.style.display = "flex";
        }

        function closeUpdateModal() {
            document.getElementById("updateModal").style.display = "none";
        }

        function openDeleteModal(productId, productName) {
            const modal = document.getElementById("deleteModal");
            document.getElementById("deleteProductId").value = productId;
            document.getElementById("deleteProductName").innerText = productName;
            modal.style.display = "flex";
        }

        // Function to close the delete modal
        function closeDeleteModal() {
            document.getElementById("deleteModal").style.display = "none";
        }

        // Function to close the product exists modal
        function closeProductExistsModal() {
            document.getElementById("productExistsModal").style.display = "none";
        }
        function preventNegative(event) {
            if (event.key === '-' || event.key === 'e' || event.key === 'E') {
                event.preventDefault();
            }
        }


    </script>
</body>
</html>
