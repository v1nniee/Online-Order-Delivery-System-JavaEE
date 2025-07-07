<%@page import="model.Delivery"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delivered and Paid Orders</title>
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
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
        }
        .card h3 {
            font-size: 18px;
            color: #444;
            margin-bottom: 10px;
        }
        .card p {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
        }

        .order-button{
            margin-top: 15px;
        }
        .order-button{
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
        .order-button {
            background-color: #0056b3;
        }
        .empty-orders-message {
            text-align: center;
            margin-top: 100px;
            font-size: 18px;
            color: #555;
        }
    </style>
    <script>
        function viewReceipt(orderId) {
            // Redirect to the receipt page or open a modal
            alert('View receipt for Order ID: ' + orderId);
            // Example: window.location.href = 'viewReceipt.jsp?orderId=' + orderId;
        }
    </script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Delivered and Paid Orders</h2>
        <c:choose>
            <c:when test="${not empty deliveredAndPaidOrders}">
                <c:forEach var="order" items="${deliveredAndPaidOrders}">
                    <div class="card">
                        <h3>Order ID: ${order.orderId}</h3>
                        <p><strong>Order Date:</strong> 
                            <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                        </p>
                        <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                        <p><strong>Status:</strong> ${order.orderStatus}</p>
                       
                        <form action="DSDisplayReceipt" method="get" style="display: inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">View Receipt</button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-orders-message">
                    <p>No delivered and paid orders are available at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
