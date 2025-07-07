<%@page import="model.CustomerOrder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Collect Payment</title>
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
        /* Modal styles */
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
        .modal-content h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
       
        .modal-content form {
            margin-bottom: 10px; /* Space between confirm and cancel buttons */
        }

        .modal-content .confirm-button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            width: 100%; /* Full width for centered alignment */
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-content .confirm-button:hover {
            background-color: #0056b3;
        }

        .modal-content .cancel-button {
            background-color: #f4f4f4;
            color: #555;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            width: 100%; /* Full width for centered alignment */
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-content .cancel-button:hover {
            background-color: #ddd;
        }

    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Pending Payment Delivered Orders</h2>
        <c:choose>
            <c:when test="${not empty deliveredOrders}">
                <c:forEach var="order" items="${deliveredOrders}">
                    <div class="card">
                        <p><strong>Date:</strong> 
                            <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                        </p>
                        <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                        <p><strong>Status:</strong> ${order.orderStatus}</p>
                        <button class="button" onclick="showModal('${order.orderId}')">Collect Payment</button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; margin-top: 100px;">
                    <p style="font-size: 18px; color: #555;">No orders are currently pending for payment collection.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>



    <!-- Modal -->
    <div class="modal" id="confirmationModal">
        <div class="modal-content">
            <h2>Confirm Payment Collection</h2>
            <p>Are you sure you want to collect payment for this order?</p>
            <form id="paymentForm" action="DSCollectPayment" method="post">
                <input type="hidden" name="orderId" id="modalOrderId">
                <button type="submit" class="button confirm-button">Yes, Collect Payment</button>
            </form>
            <button class="button cancel-button" onclick="closeModal()">Cancel</button>
        </div>
    </div>


    <script>
        const modal = document.getElementById('confirmationModal');
        const modalOrderId = document.getElementById('modalOrderId');

        // Show the modal and set the orderId in the hidden input
        function showModal(orderId) {
            modalOrderId.value = orderId; // Set the order ID in the modal
            modal.style.display = 'flex'; // Show the modal
        }

        // Close the modal
        function closeModal() {
            modal.style.display = 'none'; // Hide the modal
        }
    </script>
</body>
</html>
