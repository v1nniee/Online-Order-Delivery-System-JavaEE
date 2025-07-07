<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                text-align: center;
            }
            h2 {
                color: #333;
                margin-bottom: 20px;
            }
            .error {
                color: #d9534f;
                background-color: #f2dede;
                border: 1px solid #ebccd1;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
            }
            label {
                font-weight: bold;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .login-button {
                padding: 10px;
                font-size: 16px;
                background-color: #333;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                margin-top: 10px;
            }
            .login-button:hover {
                background-color: #555;
            }
            .register-link {
                margin-top: 15px;
                color: #777;
                font-size: 14px;
            }
            .register-link a {
                color: #333;
                text-decoration: none;
            }
            .register-link a:hover {
                color: #555;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Login</h2>
            
            <!-- Error message is only displayed when there is an error -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="Login" method="POST">
                <label for="email">Email:</label>
                <input type="text" name="email" id="email" required>

                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required>

                <label for="userType">Role:</label>
                <select name="userType" id="userType" required>
                    <option value="managing">Managing Staff</option>
                    <option value="delivery">Delivery Staff</option>
                    <option value="customer">Customer</option>
                </select>

                <button type="submit" class="login-button">Login</button>
            </form>

            <!-- Link to customer registration page with a note -->
            <p class="register-link">New customer? <a href="register.jsp">Register here</a></p>
        </div>
    </body>
</html>
