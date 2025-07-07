<%-- 
    Document   : dsViewFeedback
    Created on : Nov 20, 2024, 4:37:36 AM
    Author     : vinni
--%>

<%@page import="model.DeliveryRatingFeedback"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Delivery Feedback</title>
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
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Your Delivery Feedback</h2>
        <c:choose>
            <c:when test="${not empty feedbackList}">
                <c:forEach var="feedback" items="${feedbackList}">
                    <div class="card">
                        <h3>Feedback ID: ${feedback.deliveryRatingFeedbackId}</h3>
                        <p><strong>Customer:</strong> ${feedback.customer.name} (${feedback.customer.email})</p>
                        <p><strong>Rating:</strong> ${feedback.rating} / 5</p>
                        <p><strong>Feedback:</strong> ${feedback.feedback}</p>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; margin-top: 100px;">
                    <p style="font-size: 18px; color: #555;">No feedback available at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
