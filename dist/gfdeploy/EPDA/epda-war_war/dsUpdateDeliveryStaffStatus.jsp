<%-- 
    Document   : updateDeliveryStaffStatus
    Created on : Nov 19, 2024, 11:38:32 PM
    Author     : vinni
--%>
<%@page import="model.DeliveryStaff"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Delivery Status</title>
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

        .status-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 400px;
            margin: auto; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            text-align: center; 
            height: 100%; 
        }


        .status-card h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .status-card p {
            font-size: 16px;
            color: #555;
            margin: 10px 0;
        }

        .status-card button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .status-card button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Update Delivery Staff Status</h2>
        <c:if test="${userType == 'delivery'}">
            <div class="status-card">
                <h3>Welcome, ${user.name}</h3>
                <c:choose>
                    <c:when test="${user.deliveryStaffStatus != null}">
                        <p>Current Status: <strong>${user.deliveryStaffStatus}</strong></p>
                        <form action="DSUpdateDeliveryStaffStatus" method="post">
                            <input type="hidden" name="newStatus" 
                                   value="${user.deliveryStaffStatus == 'Available' ? 'Unavailable' : 'Available'}">
                            <button type="submit">
                                Switch to ${user.deliveryStaffStatus == 'Available' ? 'Unavailable' : 'Available'}
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <p>Your status is not set yet.</p>
                        <form action="DSUpdateDeliveryStaffStatus" method="post">
                            <input type="hidden" name="newStatus" value="Available">
                            <button type="submit">
                                Set Status to Available
                            </button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${userType != 'delivery'}">
            <p>You are not authorized to view this page.</p>
        </c:if>
    </div>
</body>
</html>
