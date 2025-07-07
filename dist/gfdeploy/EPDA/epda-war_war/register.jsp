<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
            label {
                font-weight: bold;
            }
            input, select, textarea {
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .register-button {
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
            .register-button:hover {
                background-color: #555;
            }
            .login-link {
                margin-top: 15px;
                color: #777;
                font-size: 14px;
            }
            .login-link a {
                color: #333;
                text-decoration: none;
            }
            .login-link a:hover {
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
                background-color: rgba(0, 0, 0, 0.4);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                text-align: center;
                width: 300px;
            }
            .modal-content h3 {
                margin: 0 0 15px;
            }
            .modal-content button {
                background-color: #333;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
            }
            .modal-content button:hover {
                background-color: #555;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Customer Registration</h2>
            
            <form action="Register" method="POST">
                <label for="name">Name:</label>
                <input type="text" name="name" id="name" required>

                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required>

                <label for="gender">Gender:</label>
                <select name="gender" id="gender">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>

                <label for="phone">Phone:</label>
                <input type="text" name="phone" id="phone" required>

                <label for="ic">IC:</label>
                <input type="text" name="ic" id="ic" required>

                <label for="email">Email:</label>
                <input type="email" name="email" id="email" required>

                <label for="address">Address:</label>
                <textarea name="address" id="address" rows="3" required></textarea>

                <button type="submit" class="register-button">Register</button>
            </form>

            <p class="login-link">Already have an account? <a href="login.jsp">Log in here</a></p>
        </div>

        <!-- Modal for duplicate email error -->
        <div id="errorModal" class="modal">
            <div class="modal-content">
                <h3>Error</h3>
                <p>${message}</p>
                <button type="button" class="modal-button confirm" onclick="closeModal()">OK</button>
            </div>
        </div>

        <script>
            // Check if the message is set and display the modal
            const message = "${message}";
            if (message && message.trim() !== "") {
                const errorMessages = [
                    "Email is already in use by another user.",
                    "Invalid Malaysian IC format.",
                    "Password must be more than 5 characters.",
                    "Invalid Malaysian phone number format."
                ];
                const modal = errorMessages.some(error => message.includes(error)) 
                    ? document.getElementById("errorModal") 
                    : document.getElementById("successModal");
                modal.style.display = "flex";
            }

            // Function to close the modal
            function closeModal() {
                const modal = document.getElementById("errorModal");
                modal.style.display = "none";
            }
        </script>
    </body>
</html>
