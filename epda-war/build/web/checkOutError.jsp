<%-- 
    Document   : checkOutError
    Created on : Nov 24, 2024, 11:04:03 PM
    Author     : vinni
--%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Failed</title>
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #f8d7da; color: #721c24; }
        .container { max-width: 600px; margin: 50px auto; padding: 20px; background-color: #fff; border: 1px solid #f5c6cb; border-radius: 5px; }
        h2 { color: #721c24; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Order Failed</h2>
        <p>${errorMessage}</p>
        <a href="DisplayCartItems" style="color: #0056b3;">Go Back to Cart</a>
    </div>
</body>
</html>
