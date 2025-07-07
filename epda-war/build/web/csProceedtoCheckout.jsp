<%-- 
    Document   : proceedtoCheckout
    Created on : Nov 15, 2024, 3:44:33 AM
    Author     : vinni
--%>


<%@page import="model.Customer"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Checkout</title>
    <style>
        /* Styles for checkout */
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
        .total-price { 
            font-size: 20px; margin-top: 20px; 
        }
        .payment-options {
            margin-top: 20px; 
        }
        .form-group { 
            margin-top: 15px; 
        }
        label { 
            font-size: 14px; color: #333; 
        }
        .text-info { 
            font-size: 14px; color: #555; margin-top: 5px; 
        }
        .pay-button {
            padding: 10px 20px;
            margin: 10px 0;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-align: center; 
            transition: background-color 0.3s ease; 
            display: inline-block; 
            text-decoration: none; 
        }

        .pay-button:hover {
            background-color: #218838;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s ease;
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
        <h2>Checkout Summary</h2>

        <p class="total-price">Total Price: RM <fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
        
        <h3>Delivery Information</h3>
        <!-- Display delivery address as non-editable text -->
        <div class="form-group">
            <label>Delivery Address:</label>
            <p class="text-info">${user.address}</p>
        </div>
        
        <!-- Display phone number as non-editable text -->
        <div class="form-group">
            <label>Phone Number:</label>
            <p class="text-info">${user.phone}</p>
        </div>
        
        <h3>Choose Payment Method</h3>
        <form action="CSPlaceOrder" method="post">
            <div class="payment-options">
                <label>
                    <input type="radio" name="paymentMethod" value="cash" required> Pay by Cash
                </label><br>
                <label>
                    <input type="radio" name="paymentMethod" value="card" required> Pay by Card
                </label>
            </div>
            <button type="submit" class="pay-button">Place Order</button>
        </form>
        
        <a href="CSDisplayCartItems" class="back-button">Back to Cart</a>
    </div>
</body>
</html>
