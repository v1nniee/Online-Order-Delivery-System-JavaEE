<%-- 
    Document   : viewCart
    Created on : Nov 15, 2024, 3:42:00 AM
    Author     : vinni
--%>


<%@page import="model.ShoppingCartItem"%>
<%@page import="model.Product"%>
<%@page import="java.util.Base64"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Cart</title>
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
        .cart-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .cart-item img {
            border-radius: 8px;
            max-width: 100px;
            height: auto;
            margin-right: 20px;
            object-fit: cover;
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
        .checkout-button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-align: center;
            margin-top: 20px;
        }
        .checkout-button:hover {
            background-color: #218838;
        }
        .empty-cart-message {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 300px; 
            font-size: 18px;
            color: #555;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Your Shopping Cart</h2>
        <c:if test="${not empty cartItems}">
            <c:forEach var="item" items="${cartItems}">
                <div class="cart-item">
                    <c:if test="${not empty item.product.base64Image}">
                        <img src="data:image/jpeg;base64,${item.product.base64Image}" alt="Product Image" width="150">
                    </c:if>
                    <c:if test="${empty item.product.base64Image}">
                        <img src="placeholder.jpg" alt="No Image Available" width="150">
                    </c:if>
                    <div class="item-details">
                        <h3>${item.product.productName}</h3>
                        <p>Price: RM <fmt:formatNumber value="${item.product.productPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
                        <p>Total: RM <fmt:formatNumber value="${item.product.productPrice * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>

                        <form action="CSCartUpdateItem" method="post" style="display: inline-block;">
                            <input type="hidden" name="itemId" value="${item.shoppingCartItemId}">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="quantity" value="${item.quantity}">
                            <button type="submit">-</button>
                        </form>
                        <span>${item.quantity}</span>
                        <form action="CSCartUpdateItem" method="post" style="display: inline-block;">
                            <input type="hidden" name="itemId" value="${item.shoppingCartItemId}">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="quantity" value="${item.quantity}">
                            <button type="submit">+</button>
                        </form>

                    </div>
                </div>

            </c:forEach>

            <form action="CSProceedtoCheckout" method="post">
                <button type="submit" class="checkout-button">Proceed to Checkout</button>
            </form>
        </c:if>
        <c:if test="${empty cartItems}">
            <div class="empty-cart-message">
                <p>Your cart is currently empty.</p>
            </div>
        </c:if>
    </div>
</body>
</html>