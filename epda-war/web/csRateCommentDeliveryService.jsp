<%-- 
    Document   : rateCommentDeliveryService
    Created on : Nov 20, 2024, 3:44:29 AM
    Author     : vinni
--%>

<%@page import="model.CustomerOrder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Rate and Comment Delivery Service</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .container {
            padding-top: 100px;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
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
        .button {
            margin-top: 15px;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            max-width: 400px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Rate and Comment Delivery Services</h2>
        <c:forEach var="order" items="${completedOrders}">
            <div class="card">
                <h3>Order ID: ${order.orderId}</h3>
                <p><strong>Order Date:</strong> 
                    <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                </p>
                <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                <button class="button" onclick="showModal(${order.delivery.deliveryStaff.deliveryStaffId})">Rate and Comment</button>
            </div>
        </c:forEach>
    </div>

    <!-- Modal -->
    <div class="modal" id="ratingModal">
        <div class="modal-content">
            <h2>Rate and Comment</h2>
            <form action="CSRateCommentDeliveryService" method="post">
                <input type="hidden" name="deliveryStaffId" id="deliveryStaffId">
                <label for="rating">Rating (1-5):</label>
                <input type="number" name="rating" id="rating" min="1" max="5" required>
                <br><br>
                <label for="feedback">Comment:</label>
                <textarea name="feedback" id="feedback" rows="4" required></textarea>
                <br><br>
                <button type="submit" class="button">Submit</button>
            </form>
            <button class="button" onclick="closeModal()">Cancel</button>
        </div>
    </div>

    <script>
        const modal = document.getElementById('ratingModal');
        const deliveryStaffIdInput = document.getElementById('deliveryStaffId');

        function showModal(deliveryStaffId) {
            deliveryStaffIdInput.value = deliveryStaffId;
            modal.style.display = 'flex';
        }

        function closeModal() {
            modal.style.display = 'none';
        }
        function preventNegative(event) {
            if (event.key === '-' || event.key === 'e' || event.key === 'E') {
                event.preventDefault();
            }
        }

    </script>
</body>
</html>
