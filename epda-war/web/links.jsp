<%-- 
    Document   : links
    Created on : Sep 24, 2024, 12:59:29 PM
    Author     : guan.kiat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Links Page</title>
        <style>
            /* Reset default margin and padding */
            body, html {
                margin: 0;
                padding: 0;
            }

            /* Style the navigation bar */
            .navbar {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #333;
                width: 100%;
                padding: 10px;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            /* Style each link */
            .navbar a {
                color: white;
                padding: 12px 20px;
                text-decoration: none;
                font-size: 16px;
                font-family: Arial, sans-serif;
                transition: background-color 0.3s;
            }

            /* Hover effect */
            .navbar a:hover {
                background-color: #555;
                color: white;
            }

            /* Add space for fixed navbar */
            .content {
                padding-top: 50px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation bar -->
        <div class="navbar">
            <a href="Home">Home</a>

            <% 
                String userType = (String) session.getAttribute("userType");
                if ("managing".equals(userType)) { 
            %>
                <a href="msAddAnnouncement.jsp">Add Announcement</a>
                 <a href="MSDisplayAllStaffInfo">Manage Staff Information</a>
                 <a href="MSDisplayAllCustomerInfo">Manage Customer Information</a>
                <a href="MSDisplayProductInfo">Manage Product Information</a>
                <a href="MSDisplayOrder">View Orders</a>
                <a href="MSDisplayOrderForDelivery">Assign Delivery</a> <!-- !!! -->
                <a href="msGenerateReport.jsp">View Reports</a>
                <a href="MSDisplayAllFeedback">View Feedback</a>
                

            <% 
                } else if ("delivery".equals(userType)) { 
            %>
                <a href="dsEditDeliveryStaff.jsp">Edit Profile</a>
                <a href="dsUpdateDeliveryStaffStatus.jsp">Update Delivery Staff Status</a>
                <a href="DSDisplayDeliveryTaskStatus">Update Assigned Delivery Task Status</a>
                <a href="DSDisplayDeliveredOrder">Collect Payment on Delivered Order</a>
                <a href="DSDisplayDeliveredandPaidOrder">View Delivered and Paid Order</a>
                <a href="DSDisplayFeedback">View Feedback</a>

            <% 
                } else if ("customer".equals(userType)) { 
            %>
                
                <a href="csEditCustomer.jsp">Edit Profile</a>
                <a href="CSDisplayProductCatalog">Browse Product</a>
                <a href="CSDisplayCartItems">View Cart</a>
                <a href="CSDisplayOrder">View Pending Orders</a>
                <a href="CSDisplayCompletedOrders">View Completed Orders</a>
                <a href="CSDisplayCompletedOrder">Rate Service</a>

            <% 
                } 
            %>

            <a href="Logout">Logout</a>
        </div>

        <!-- Page Content -->
        <div class="content">
            <!-- Rest of your page content goes here -->
        </div>
    </body>
</html>
