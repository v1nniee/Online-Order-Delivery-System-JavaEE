<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delivery Details</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            flex-direction: column;
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 20px auto;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .delivery-summary {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            text-align: left;
        }
        .delivery-summary p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }
        .back-button {
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
        .back-button:hover {
            background-color: #0056b3;
        }
        .empty-orders-message {
            text-align: center;
            color: #555;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Delivery Details</h2>
        <c:choose>
            <c:when test="${not empty delivery}">
                <div class="delivery-summary">
                    <p><strong>Delivery ID:</strong> ${delivery.deliveryId}</p>
                    <p><strong>Delivery Date:</strong> 
                        <fmt:formatDate value="${delivery.deliveryDate}" pattern="dd-MM-yyyy" timeZone="Asia/Kuala_Lumpur"/>
                    </p>
                    <p><strong>Delivery Status:</strong> ${delivery.deliveryStatus}</p>
                    <c:if test="${not empty delivery.deliveryStaff}">
                        <p><strong>Delivery Staff:</strong> ${delivery.deliveryStaff.name}</p>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-orders-message">
                    <p>No delivery details are available at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a href="MSDisplayOrder" class="back-button">Back to Orders</a>
    </div>
</body>
</html>
