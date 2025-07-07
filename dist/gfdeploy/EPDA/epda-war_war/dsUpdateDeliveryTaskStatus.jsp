<%@page import="model.Delivery"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Delivery Task Status</title>
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
        .update-button {
            margin-top: 15px;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .update-button:hover {
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
            max-width: 400px;
            text-align: center;
        }
        .modal-content h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }
        .modal-content select, .modal-content button {
            margin-top: 10px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .close-button {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .close-button:hover {
            background-color: #a71d2a;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Orders To Be Delivered</h2>
        <c:choose>
            <c:when test="${not empty deliveries}">
                <c:forEach var="delivery" items="${deliveries}">
                    <div class="card">
                        <h3>Delivery ID: ${delivery.deliveryId}</h3>
                        <p><strong>Order ID:</strong> ${delivery.order.orderId}</p>
                        <p><strong>Date::</strong> 
                            <fmt:formatDate value="${delivery.deliveryDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                        </p>
                        <p><strong>Status:</strong> ${delivery.deliveryStatus}</p>
                        <button class="update-button" onclick="openModal(${delivery.deliveryId}, '${delivery.deliveryStatus}')">Update Status</button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; margin-top: 100px;">
                    <p style="font-size: 18px; color: #555;">No delivery tasks are currently assigned.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>


    <!-- Modal -->
    <div class="modal" id="updateModal">
        <div class="modal-content">
            <h2>Update Delivery Status</h2>
            <form action="DSUpdateDeliveryTaskStatus" method="post">
                <input type="hidden" name="deliveryId" id="modalDeliveryId">
                <label for="deliveryStatus">Select Status:</label>
                <select name="deliveryStatus" id="modalDeliveryStatus" required>
                    <option value="In Progress">In Progress</option>
                    <option value="Delivered">Delivered</option>
                    <option value="Failed">Failed</option>
                </select>
                <button type="submit" class="update-button">Save Changes</button>
            </form>
            <button class="close-button" onclick="closeModal()">Cancel</button>
        </div>
    </div>

    <script>
        const modal = document.getElementById('updateModal');
        const modalDeliveryId = document.getElementById('modalDeliveryId');
        const modalDeliveryStatus = document.getElementById('modalDeliveryStatus');

        function openModal(deliveryId, currentStatus) {
            modal.style.display = 'flex';
            modalDeliveryId.value = deliveryId;
            modalDeliveryStatus.value = currentStatus;
        }

        function closeModal() {
            modal.style.display = 'none';
        }
    </script>
</body>
</html>
