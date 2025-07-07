<%-- 
    Document   : viewOrderDetails
    Created on : Nov 19, 2024, 1:18:58 AM
    Author     : vinni
--%>

<%@page import="java.util.Base64"%>
<%@page import="model.Product"%>
<%@page import="model.OrderItem"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Details</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            flex-direction: column;
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 20px auto;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .order-summary {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            text-align: left;
        }
        .order-summary p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }
        .product-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }
        .product-item img {
            border-radius: 8px;
            max-width: 100px;
            height: auto;
            margin-right: 20px;
            object-fit: cover;
        }
        .product-details {
            flex: 1;
        }
        .product-details h3 {
            font-size: 18px;
            color: #444;
            margin: 0 0 5px;
        }
        .product-details p {
            margin: 3px 0;
            color: #555;
            font-size: 14px;
        }
        .back-button {
            display: inline-block;
            padding: 10px 15px;
            font-size: 14px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Order Details</h2>
        <div class="order-summary">
            <p><strong>Order ID:</strong> ${order.orderId}</p>
            <p><strong>Order Date:</strong> 
                <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
            </p>
            <p><strong>Order Status:</strong> ${order.orderStatus}</p>
            <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
        </div>
        <c:forEach var="item" items="${order.orderItems}">
            <div class="product-item">
                <c:if test="${item.product.base64Image != null}">
                    <img src="data:image/jpeg;base64,${item.product.base64Image}" alt="Product Image" width="150">
                </c:if>
                <c:if test="${item.product.base64Image == null}">
                    <img src="placeholder.jpg" alt="No Image Available" width="150">
                </c:if>
                <div class="product-details">
                    <h3>${item.product.productName}</h3>
                    <p><strong>Price: </strong>RM <fmt:formatNumber value="${item.product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                    <p><strong>Quantity:</strong> ${item.quantity}</p>
                    <p><strong>Total: </strong>RM <fmt:formatNumber value="${item.quantity * item.product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                </div>
            </div>
        </c:forEach>
        <a href="CSDisplayOrder" class="back-button">Back to Orders</a>
    </div>
</body>
</html>
