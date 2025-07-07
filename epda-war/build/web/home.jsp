<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Online Order Delivery System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
            }
            .navbar {
                background-color: #333;
                padding: 15px;
                text-align: center;
            }
            .navbar a {
                color: #fff;
                text-decoration: none;
                padding: 10px 20px;
                display: inline-block;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .navbar a:hover {
                background-color: #555;
            }
            .container {
                width: 80%;
                margin: 50px auto;
                text-align: center;
                padding-top: 80px;
            }
            h1 {
                color: #333;
                font-size: 24px;
            }
            .section {
                margin: 20px 0;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .section h2 {
                color: #333;
                font-size: 20px;
                margin: 0;
            }
            .section p {
                color: #666;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <div class="navbar">
            <jsp:include page="links.jsp" />
        </div>

        <!-- Main Container -->
        <div class="container">
            <h1>Hi ${user.name}, welcome to the APU Convenience Store Online Order Delivery System!</h1>
            
            <!-- Announcements Section -->
            <div class="section">
                <h2>Announcements</h2>
                <c:choose>
                    <c:when test="${not empty latestAnnouncement 
                                   and not empty latestAnnouncement.title 
                                   and not empty latestAnnouncement.content}">
                        <h3>${latestAnnouncement.title}</h3>
                        <p>${latestAnnouncement.content}</p>
                    </c:when>
                    <c:otherwise>
                        <p>No announcements at the moment. Please check back later.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Footer -->
            <div class="section">
                <p>&copy; 2024 APU Convenience Store - Online Order Delivery System</p>
            </div>
        </div>
    </body>
</html>
