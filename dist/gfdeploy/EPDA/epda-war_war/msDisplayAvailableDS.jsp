<%@page import="model.DeliveryStaff"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Delivery Staff</title>
    <style>
        /* Existing styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            padding-top: 100px;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .deliveryStaff-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .deliveryStaff-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
        }
        .deliveryStaff-card h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }
        .deliveryStaff-card p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }
        .deliveryStaff-card button {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .deliveryStaff-card button:hover {
            background-color: #0056b3;
        }
        .no-deliveryStaff-message {
            text-align: center;
            margin-top: 50px;
            font-size: 18px;
            color: #555;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
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
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }
        .modal-content h2 {
            margin-bottom: 20px;
        }
        .modal-content button {
            margin: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal-content .confirm {
            background-color: #007bff;
            color: white;
        }
        .modal-content .cancel {
            background-color: #f44336;
            color: white;
        }
    </style>
    <script>
        function showConfirmationModal(deliveryStaffId, orderId) {
            const modal = document.getElementById('confirmationModal');
            modal.style.display = 'flex';

            // Update the hidden form values
            document.getElementById('confirmDeliveryStaffId').value = deliveryStaffId;
            document.getElementById('confirmOrderId').value = orderId;
        }


        function closeModal() {
            const modal = document.getElementById('confirmationModal');
            modal.style.display = 'none';
        }
    </script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h1>Available Delivery Staff</h1>

        <c:choose>
            <c:when test="${not empty availableDeliveryStaffs}">
                <div class="deliveryStaff-grid">
                    <c:forEach var="deliveryStaff" items="${availableDeliveryStaffs}">
                        <div class="deliveryStaff-card">
                            <h3>${deliveryStaff.name}</h3>
                            <p><strong>Email:</strong> ${deliveryStaff.email}</p>
                            <p><strong>Phone:</strong> ${deliveryStaff.phone}</p>
                            <p><strong>Gender:</strong> ${deliveryStaff.gender}</p>
                            <p><strong>IC:</strong> ${deliveryStaff.ic}</p>
                            <p><strong>Address:</strong> ${deliveryStaff.address}</p>
                            <button onclick="showConfirmationModal('${deliveryStaff.deliveryStaffId}', '${orderId}')">Select for Order</button>

                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-deliveryStaff-message">
                    There's no delivery staff available now.
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirmationModal" class="modal">
        <div class="modal-content">
            <h2>Confirm Selection</h2>
            <p>Are you sure you want to assign this delivery staff to the order?</p>
            <form action="MSAssignDeliveryStaffToOrder" method="post">
                <input type="hidden" id="confirmDeliveryStaffId" name="deliveryStaffId" value="">
                <input type="hidden" id="confirmOrderId" name="orderId" value="">
                <button type="submit" class="confirm">Confirm</button>
                <button type="button" class="cancel" onclick="closeModal()">Cancel</button>
            </form>

        </div>
    </div>
</body>
</html>
