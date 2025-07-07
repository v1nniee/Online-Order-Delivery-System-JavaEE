<%@page import="model.Customer"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Customers</title>
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


        .search-bar {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            padding: 10px;
            width: 50%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-bar button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #0056b3;
        }

        .customer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .customer-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
        }

        .customer-card h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .customer-card p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .customer-card button {
            margin: 5px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-size: 14px;
        }

        .update-button {
            background-color: #007bff;
        }

        .delete-button {
            background-color: #dc3545;
        }

        .update-button:hover {
            background-color: #0056b3;
        }

        .delete-button:hover {
            background-color: #a71d2a;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 400px;
        }

        .modal-content input, 
        .modal-content textarea, 
        .modal-content select, 
        .modal-content button {
            width: calc(100% - 20px);
            margin-bottom: 10px;
            padding: 10px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .modal-content button {
            background-color: #007bff;
            color: white;
            border: none;
        }

        .modal-content .cancel {
            background-color: #dc3545;
        }

        .modal-content .cancel:hover {
            background-color: #a71d2a;
        }
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            width: 320px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
        }

        .modal-content button {
            margin-top: 15px;
            padding: 10px 15px;
            border-radius: 5px;
        }

    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Manage Customer Information</h2>
        <div class="search-bar">
            <form action="MSManageAllCustomerInfo" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="search" placeholder="Search customers by name..." required>
                <button type="submit">Search</button>
            </form>
        </div>

        <c:choose>
            <c:when test="${not empty customerList}">
                <div class="customer-grid">
                    <c:forEach var="customer" items="${customerList}">
                        <div class="customer-card">
                            <h3>${customer.name}</h3>
                            <p><strong>Email:</strong> ${customer.email}</p>
                            <p><strong>Phone:</strong> ${customer.phone}</p>
                            <p><strong>Gender:</strong> ${customer.gender}</p>
                            <p><strong>IC:</strong> ${customer.ic}</p>
                            <p><strong>Address:</strong> ${customer.address}</p>
                            <button class="update-button" 
                                onclick="openUpdateModal('${customer.customerId}', '${customer.name}', '${customer.email}', '${customer.phone}', '${customer.gender}', '${customer.ic}', '${customer.address}', 
                                            '${customer.password}')">
                                Update
                            </button>
                            <button class="delete-button" 
                                onclick="openDeleteModal('${customer.customerId}', '${customer.name}')">Delete</button>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; margin-top: 100px;">
                    <p style="font-size: 18px; color: #555;">No customers available at the moment.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>


        <!-- Update Modal -->
        <div id="updateModal" class="modal">
            <div class="modal-content">
                <h3>Update Customer</h3>
                <form action="MSManageAllCustomerInfo" method="post">
                    <input type="hidden" name="action" value="confirmUpdate">
                    <input type="hidden" name="customerId" id="updateCustomerId">
                    <input type="text" name="name" id="updateCustomerName" placeholder="Name" required>
                    <input type="email" name="email" id="updateCustomerEmail" placeholder="Email" required>
                    <input type="text" name="phone" id="updateCustomerPhone" placeholder="Phone" required>
                    <select name="gender" id="updateCustomerGender" required>
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <input type="text" name="ic" id="updateCustomerIC" placeholder="IC" required>
                    <textarea name="address" id="updateCustomerAddress" placeholder="Address" rows="3" required></textarea>
                    <input type="password" name="password" id="updateCustomerPassword" placeholder="Password" required>
                    <button type="submit">Save Changes</button>
                    <button type="button" class="cancel" onclick="closeUpdateModal()">Cancel</button>
                </form>
            </div>
        </div>

        <!-- Delete Modal -->
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <h3>Delete Customer</h3>
                <p>Are you sure you want to delete <strong id="deleteCustomerName"></strong>?</p>
                <form action="MSManageAllCustomerInfo" method="post">
                    <input type="hidden" name="action" value="confirmDelete">
                    <input type="hidden" name="customerId" id="deleteCustomerId">
                    <button type="submit">Yes, Delete</button>
                    <button type="button" class="cancel" onclick="closeDeleteModal()">Cancel</button>
                </form>
            </div>
        </div>
    </div>
    
    <c:if test="${not empty showModal}">
        <div id="emailExistsModal" class="modal" style="display: flex;">
            <div class="modal-content">
                <h3>Error</h3>
                <p>${message}</p>
                <button type="button" class="modal-button confirm" onclick="closeEmailExistsModal()">OK</button>
            </div>
        </div>
    </c:if>
    

    <script>
        function openUpdateModal(id, name, email, phone, gender, ic, address, password) {
            document.getElementById("updateCustomerId").value = id;
            document.getElementById("updateCustomerName").value = name;
            document.getElementById("updateCustomerEmail").value = email;
            document.getElementById("updateCustomerPhone").value = phone;
            document.getElementById("updateCustomerGender").value = gender;
            document.getElementById("updateCustomerIC").value = ic;
            document.getElementById("updateCustomerAddress").value = address;
            document.getElementById("updateCustomerPassword").value = password;
            document.getElementById("updateModal").style.display = "flex";
        }

        function closeUpdateModal() {
            document.getElementById("updateModal").style.display = "none";
        }

        function openDeleteModal(id, name) {
            document.getElementById("deleteCustomerId").value = id;
            document.getElementById("deleteCustomerName").innerText = name;
            document.getElementById("deleteModal").style.display = "flex";
        }

        function closeDeleteModal() {
            document.getElementById("deleteModal").style.display = "none";
        }
        
        function closeEmailExistsModal() {
            document.getElementById("emailExistsModal").style.display = "none";
        }
    </script>
</body>
</html>
