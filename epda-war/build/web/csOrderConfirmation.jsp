<%-- 
    Document   : orderConfirmation
    Created on : Nov 19, 2024, 1:00:01 AM
    Author     : vinni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Confirmation</title>
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
        h3 {
            color: #333; 
        }
        p { 
            color: #555; 
        }
        .btn { 
            margin-top: 20px; padding: 10px 20px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; 
        }
        .btn:hover {
            background-color: #218838; 
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Order Confirmation</h2>
        <p>Thank you for your order, <strong>${customerName}</strong>!</p>
        <h3>Order ID: ${orderId}</h3>
        <p class="total-price">Total Amount: RM <fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
        <p>Your order is now being processed.</p>
        <a href="CSDisplayOrder" class="btn">View Order</a>
    </div>
</body>
</html>
