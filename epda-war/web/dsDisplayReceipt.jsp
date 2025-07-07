<%-- 
    Document   : dsviewReceipt
    Created on : Nov 24, 2024, 10:22:27 PM
    Author     : vinni
--%>

<%@page import="model.CustomerOrder"%>
<%@page import="model.OrderItem"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Receipt</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #696565;
            color: #fff;
        }
        .total {
            text-align: right;
            font-weight: bold;
        }
        .back-button {
            display: block;
            width: 100px;
            margin: 20px auto;
            text-align: center;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .back-button:hover {
            background-color: #0056b3;
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
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Order Receipt</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <td>${order.orderId}</td>
            </tr>
            <tr>
                <th>Order Date</th>
                <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/></td>
            </tr>
            <tr>
                <th>Customer Name</th>
                <td>${order.customer.name}</td>
            </tr>
            <tr>
                <th>Total Amount</th>
                <td><fmt:formatNumber value="${order.totalAmount}" /></td>
            </tr>
        </table>

        <h2>Order Items</h2>
        <table>
            <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total Price</th>
            </tr>
            <c:forEach var="item" items="${order.orderItems}">
                <tr>
                    <td>${item.product.productName}</td>
                    <td>${item.quantity}</td>
                    <td>RM ${item.product.productPrice}</td>
                    <td>RM ${item.totalPrice}</td>
                </tr>
            </c:forEach>
        </table>

        <a href="DSDisplayDeliveredandPaidOrder" class="back-button">Back</a>
    </div>
</body>
</html>
