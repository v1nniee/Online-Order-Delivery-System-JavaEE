<%-- 
    Document   : msViewOrder
    Created on : Nov 19, 2024, 8:28:14 PM
    Author     : vinni
--%>

<%@page import="model.CustomerOrder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Pending Orders</title>
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
        .no-orders {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 300px; 
            font-size: 18px;
            color: #555;
            text-align: center;
        }
        .order-item {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
        }
        .order-buttons {
            display: flex;
            gap: 10px;
        }
        .order-button {
            padding: 10px 15px;
            font-size: 14px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .order-button:hover {
            background-color: #0056b3;
        }
        .no-orders {
            font-size: 18px;
            color: #333;
            text-align: center;
            margin: auto;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>All Customer Orders</h2>
        <c:if test="${not empty allOrders}">
            <c:forEach var="order" items="${allOrders}">
                <div class="order-item">
                    <div>
                        <p><strong>Order ID:</strong> ${order.orderId}</p>
                        <p><strong>Customer Name:</strong> ${order.customer.name}</p>
                        <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                        <p><strong>Status:</strong> ${order.orderStatus}</p>
                    </div>
                    <div class="order-buttons">
                        <form action="MSDisplayOrderDetails" method="get" style="display:inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">Order Details</button>
                        </form>
                        <form action="MSDisplayDeliveryDetails" method="get" style="display:inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">Delivery Details</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty allOrders}">
            <p class="no-orders">No orders found.</p>
        </c:if>
    </div>
</body>
</html>
