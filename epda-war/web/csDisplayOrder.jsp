<%-- 
    Document   : viewOrder
    Created on : Nov 19, 2024, 1:10:23 AM
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
    <script>
        function openModal(orderId, currentPaymentMethod) {
            const modal = document.getElementById('paymentModal');
            document.getElementById('modalOrderId').value = orderId;
            document.getElementById('currentPaymentMethod').innerText = currentPaymentMethod;
            modal.style.display = 'flex'; // Show the modal
        }

        function closeModal() {
            document.getElementById('paymentModal').style.display = 'none'; // Hide the modal
        }
        function openDeleteModal(orderId) {
            const modal = document.getElementById('deleteModal');
            document.getElementById('deleteOrderId').value = orderId; // Set the order ID in the hidden input field
            modal.style.display = 'flex'; // Show the modal
        }

        function closeDeleteModal() {
            const modal = document.getElementById('deleteModal');
            modal.style.display = 'none'; // Hide the modal
        }

        function submitDeleteForm() {
            document.getElementById('deleteForm').submit(); // Submit the delete form
        }

        
    </script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Your Pending Orders</h2>
        <div class="search-bar">
            <form action="CSSearchOrder" method="get" style="display: inline;">
                <input type="text" name="search" placeholder="Search by product name..." value="${param.search}">
                <button type="submit">Search</button>
            </form>
            <form action="CSDisplayOrder" method="get" style="display: inline;">
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
                        <p><strong>Order Status:</strong> ${order.orderStatus}</p>
                        <p><strong>Total Amount: </strong>RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                    </div>
                    <div class="order-buttons">
                        <form action="CSDisplayOrderDetails" method="get" style="display:inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">Order Details</button>
                        </form>
                        <form action="CSDisplayDeliveryDetails" method="get" style="display:inline;">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <button type="submit" class="order-button">Delivery Details</button>
                        </form>
                        <c:if test="${order.orderStatus == 'Pending'}">
                            <!-- Update Payment -->
                            <button class="order-button" type="button" 
                                onclick="openModal('${order.orderId}', '${order.payment.paymentMethod}')">
                                Update Order
                            </button>

                            <!-- Delete Order -->
                            <button class="order-button" type="button" onclick="openDeleteModal('${order.orderId}')">
                                Delete Order
                            </button>
                        </c:if>
                    </div>
                            
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty orders}">
            <div class="empty-orders-message">
                <p>No orders found. Please try searching with a different product name or check your order history.</p>
            </div>
        </c:if>
    </div>
    
    <!-- Modal -->
    <div id="paymentModal" class="modal">
        <div class="modal-content">
            <span class="close-button" onclick="closeModal()">&times;</span>
            <h3>Update Payment Method</h3>
            <p>Current Payment Method: <span id="currentPaymentMethod"></span></p>
            <form action="CSUpdateOrder" method="post">
                
                <input type="hidden" id="modalOrderId" name="orderId">
                <label for="newPaymentMethod">Choose Payment Method:</label>
                <select name="paymentMethod" id="newPaymentMethod">
                    <option value="Cash">Cash</option>
                    <option value="Card">Card</option>
                </select>
                <button type="submit" class="order-button">Save</button>
            </form>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close-button" onclick="closeDeleteModal()">&times;</span>
            <h3>Confirm Deletion</h3>
            <p>Are you sure you want to delete this order?</p>
            <form id="deleteForm" action="CSDeleteOrder" method="post">
                <input type="hidden" id="deleteOrderId" name="orderId">
                <button type="button" class="order-button" style="background-color: #dc3545;" onclick="submitDeleteForm()">Delete</button>
                <button type="button" class="order-button" style="background-color: #6c757d;" onclick="closeDeleteModal()">Cancel</button>
            </form>
        </div>
    </div>

</body>
</html>
