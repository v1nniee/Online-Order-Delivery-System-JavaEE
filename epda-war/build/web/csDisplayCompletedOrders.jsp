<%-- 
    Document   : viewCompletedOrder
    Created on : Nov 22, 2024, 7:17:59 PM
    Author     : vinni
--%>

<%@page import="model.CustomerOrder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Orders</title>
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
        .order-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: left;
        }
        .item-details {
            flex: 1;
        }
        .item-details h3 {
            font-size: 18px;
            color: #444;
            margin: 0 0 5px;
        }
        .item-details p {
            margin: 3px 0;
            color: #555;
            font-size: 14px;
        }
        .order-buttons {
            margin-top: 15px;
            text-align: center;
        }
        .order-button {
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
        .order-button:hover {
            background-color: #0056b3;
        }
        .empty-orders-message {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 300px; 
            font-size: 18px;
            color: #555;
            text-align: center;
        }
        .modal {
            display: none; /* Ensure the modal is hidden by default */
            position: fixed;
            z-index: 10;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            text-align: center;
        }
        .close-button {
            float: right;
            font-size: 18px;
            cursor: pointer;
        }
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

    </style>

</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Your Completed Orders</h2>
        <div class="search-bar">
            <form action="CSSearchCompletedOrder" method="get" style="display: inline;">
                <input type="text" name="search" placeholder="Search by product name..." value="${param.search}">
                <button type="submit">Search</button>
            </form>
            <form action="CSDisplayCompletedOrders" method="get" style="display: inline;">
                <button type="submit">Display All</button>
            </form>
        </div>



        <c:if test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-item">
                    <div class="item-details">
                        <h3>Order ID: ${order.orderId}</h3>
                        <p><strong>Order Date:</strong> 
                            <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                        </p>
                        <p><strong>Delivered by:</strong> 
                            <fmt:formatDate value="${order.delivery.completedDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                        </p>
                        <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                    </div>

                    <div class="order-buttons">
                        <!-- Button to display receipt -->
                        <form action="CSDisplayReceipt" method="get" style="display: inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">View Receipt</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty orders}">
            <div class="empty-orders-message">
                <p>No orders found. Please try searching with a different product name or there's no completed product yet.</p>
            </div>
        </c:if>
    </div>



</body>
</html>
