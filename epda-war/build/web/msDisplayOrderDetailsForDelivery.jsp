<%-- 
    Document   : msViewOrderDetailsForDelivery
    Created on : Nov 19, 2024, 10:30:59 PM
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
        .product-item {
            display: flex;
            background-color: #fff;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            align-items: center;
        }
        .product-item img {
            max-width: 100px;
            margin-right: 20px;
        }
        .product-details {
            flex: 1;
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
        <div>
            <p><strong>Order ID:</strong> ${order.orderId}</p>
            <p><strong>Customer:</strong> ${order.customer.name}</p>
            <p><strong>Status:</strong> ${order.orderStatus}</p>
           <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
        </div>
        <c:forEach var="item" items="${order.orderItems}">
            <div class="product-item">
                <c:if test="${item.product.base64Image != null}">
                    <img src="data:image/jpeg;base64,${item.product.base64Image}" alt="Product Image">
                </c:if>
                <div class="product-details">
                    <p><strong>Product:</strong> ${item.product.productName}</p>
                    <p><strong>Quantity:</strong> ${item.quantity}</p>
                    <p><strong>Total: </strong>RM <fmt:formatNumber value="${item.quantity * item.product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                </div>
            </div>
        </c:forEach>
        <a href="MSDisplayOrderForDelivery" class="back-button">Back to Orders</a>
    </div>
</body>
</html>
