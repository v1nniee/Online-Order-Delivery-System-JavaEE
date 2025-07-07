<%-- 
    Document   : editCustomer
    Created on : Nov 4, 2024, 1:58:43 AM
    Author     : vinni
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Customer</title>
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
            }
            label, input, button {
                display: block;
                margin: 10px auto;
                width: 100%;
            }
            button {
                padding: 10px;
                font-size: 16px;
                background-color: #333;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background-color: #555;
            }
            .back-button {
                margin-top: 15px;
                padding: 8px 16px;
                background-color: #777;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                display: inline-block;
                transition: background-color 0.3s;
            }
            .back-button:hover {
                background-color: #555;
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
            .message {
                color: red;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <jsp:include page="links.jsp" />
        </div>
        <div class="container">
            <h2>Update Customer</h2>


            <form action="MSManageAllCustomerInfo" method="post">
                <input type="hidden" name="action" value="updateOwnInfo">

                <label>Name:</label>
                <input type="text" name="name" value="${user.name}" required>

                <label>Password:</label>
                <input type="password" name="password" value="${user.password}" required>

                <label>Gender:</label>
                <input type="text" name="gender" value="${user.gender}" required>

                <label>Phone:</label>
                <input type="text" name="phone" value="${user.phone}" required>

                <label>IC:</label>
                <input type="text" name="ic" value="${user.ic}" required>

                <label>Email:</label>
                <input type="email" name="email" value="${user.email}" required>

                <label>Address:</label>
                <input type="text" name="address" value="${user.address}" required>

                <button type="submit">Save Changes</button>
            </form>
            <a href="home.jsp" class="back-button">Back to Home</a>
        </div>

        <!-- Modal for success message -->
        <div id="successModal" class="modal">
            <div class="modal-content">
                <h3>Your information was updated successfully.</h3>
                <button onclick="closeModal()">Close</button>
            </div>
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
                const modals = document.querySelectorAll(".modal");
                modals.forEach(modal => {
                    modal.style.display = "none";
                });
            }
        </script>
        
    </body>
</html>
