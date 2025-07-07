<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Staff</title>
    <style>
        /* Use the same styles as manageProductInfo.jsp */
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

        .navbar a {
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            font-family: Arial, sans-serif;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #555;
            color: white;
        }

        .container {
            padding-top: 100px;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .add-form {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .add-form form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .add-form input, .add-form button, .add-form select {
            margin: 10px 0;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .add-form button {
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-form button:hover {
            background-color: #218838;
        }

        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-bar input[type="text"], .search-bar select {
            width: 60%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-bar button {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-bar button:hover {
            background-color: #0056b3;
        }

        .staff-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .staff-title {
            grid-column: span 3; /* This will make the title span across the row */
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }


        .staff-card {
            background-color: #fff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .staff-card button {
            margin: 5px;
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .delete-button {
            background-color: red;
            color: #fff;
        }

        .update-button {
            background-color: #007bff;
            color: #fff;
        }

        .delete-button:hover {
            background-color: #cc0000;
        }

        .update-button:hover {
            background-color: #0056b3;
        }

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
        <h2>Manage Staff Information</h2>
        <!-- Add Staff Form -->
        <div class="add-form">
            <h2>Add New Staff</h2>
            <form action="MSManageStaffInfo" method="post">
                <input type="hidden" name="action" value="add">

                <select name="staffType" required>
                    <option value="managing">Managing Staff</option>
                    <option value="delivery">Delivery Staff</option>
                </select>

                <input type="text" name="name" placeholder="Staff Name" required>
                <input type="password" name="password" placeholder="Password" required>

                <select name="gender" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="other">Other</option>
                </select>

                <input type="text" name="phone" placeholder="Phone Number" required>
                <input type="text" name="ic" placeholder="IC Number" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="text" name="address" placeholder="Address" required>

                <button type="submit">Add Staff</button>
            </form>
        </div>


        <!-- Search Bar -->
        <div class="search-bar">
            <form action="MSManageStaffInfo" method="get" style="display: inline;">
                <input type="hidden" name="action" value="search">
                <input type="text" name="search" placeholder="Search staff by name...">
                <button type="submit">Search</button>
            </form>
            <form action="MSDisplayAllStaffInfo" method="get" style="display: inline;">
                <button type="submit">Display All Staff</button>
            </form>
        </div>


        <!-- Staff Grid -->
        <div class="staff-grid">
            <!-- Title for Managing Staff -->
            <div class="staff-title">Managing Staff</div>
            <c:forEach var="staff" items="${managingStaffList}">
                <div class="staff-card">
                    <h3>${staff.name}</h3>
                    <p>Gender: ${staff.gender}</p>
                    <p>Phone: ${staff.phone}</p>
                    <p>IC: ${staff.ic}</p>
                    <p>Email: ${staff.email}</p>
                    <p>Address: ${staff.address}</p>
                    <button 
                        class="update-button" 
                        onclick="openUpdateModal(
                            'managing', 
                            '${staff.managingStaffId}', 
                            '${staff.name}', 
                            '${staff.email}', 
                            '${staff.phone}', 
                            '${staff.address}', 
                            '${staff.password}', 
                            '${staff.gender}', 
                            '${staff.ic}'
                        )">
                        Update
                    </button>

                     <button 
                        class="delete-button" 
                        onclick="openDeleteModal('managing', '${staff.managingStaffId}', '${staff.name}')">
                        Delete
                    </button>
                </div>
            </c:forEach>

            <!-- Delivery Staff Section -->
            <div class="staff-title">Delivery Staff</div>
            <c:forEach var="staff" items="${deliveryStaffList}">
                <div class="staff-card">
                    <h3>${staff.name}</h3>
                    <p>Gender: ${staff.gender}</p>
                    <p>Phone: ${staff.phone}</p>
                    <p>IC: ${staff.ic}</p>
                    <p>Email: ${staff.email}</p>
                    <p>Address: ${staff.address}</p>
                    <button 
                        class="update-button" 
                        onclick="openUpdateModal(
                            'delivery', 
                            '${staff.deliveryStaffId}', 
                            '${staff.name}', 
                            '${staff.email}', 
                            '${staff.phone}', 
                            '${staff.address}', 
                            '${staff.password}', 
                            '${staff.gender}', 
                            '${staff.ic}'
                        )">
                        Update
                    </button>

                    <button 
                        class="delete-button" 
                        onclick="openDeleteModal('delivery', '${staff.deliveryStaffId}', '${staff.name}')">
                        Delete
                    </button>
                </div>
            </c:forEach>

            
            <div id="updateModal" class="modal">
                <div class="modal-content">
                    <h3>Update Staff</h3>
                    <form action="MSManageStaffInfo" method="post" style="display: flex; flex-direction: column; align-items: stretch;">
                        <input type="hidden" name="action" value="confirmUpdate">
                        <input type="hidden" name="staffType" id="updateStaffType">
                        <input type="hidden" name="staffId" id="updateStaffId">

                        <label for="updateStaffName">Name:</label>
                        <input type="text" name="name" id="updateStaffName" placeholder="Name" required>

                        <label for="updatePassword">Current Password:</label>
                        <input type="password" name="password" id="updatePassword" placeholder="Password" required>

                        <label for="updateGender">Gender:</label>
                        <select name="gender" id="updateGender" required>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>


                        <label for="updateStaffPhone">Phone:</label>
                        <input type="text" name="phone" id="updateStaffPhone" placeholder="Phone" required>

                        <label for="updateIC">IC:</label>
                        <input type="text" name="ic" id="updateIC" placeholder="IC" required>

                        <label for="updateStaffEmail">Email:</label>
                        <input type="email" name="email" id="updateStaffEmail" placeholder="Email" required>

                        <label for="updateStaffAddress">Address:</label>
                        <input type="text" name="address" id="updateStaffAddress" placeholder="Address" required>

                        <button type="submit" style="margin-top: 20px;">Save Changes</button>
                        <button type="button" onclick="closeUpdateModal()" style="margin-top: 10px;">Cancel</button>
                    </form>
                </div>
            </div>


            
            <div id="deleteModal" class="modal">
                <div class="modal-content">
                    <h3>Delete Staff</h3>
                    <p>Are you sure you want to delete <strong id="deleteStaffName"></strong>?</p>
                    <form action="MSManageStaffInfo" method="post">
                        <input type="hidden" name="action" value="confirmDelete">
                        <input type="hidden" name="staffType" id="deleteStaffType">
                        <input type="hidden" name="staffId" id="deleteStaffId">
                        <button type="submit">Confirm Delete</button>
                        <button type="button" onclick="closeDeleteModal()">Cancel</button>
                    </form>
                </div>
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
        function openUpdateModal(staffType, staffId, name, email, phone, address, password, gender, ic) {
            // Populate hidden fields
            document.getElementById("updateStaffType").value = staffType; // managing or delivery
            document.getElementById("updateStaffId").value = staffId;
            document.getElementById("updateStaffName").value = name;
            document.getElementById("updateStaffEmail").value = email;
            document.getElementById("updateStaffPhone").value = phone;
            document.getElementById("updateStaffAddress").value = address;
            document.getElementById("updatePassword").value = password;
            
            document.getElementById("updateIC").value = ic;
            
            // Set gender dropdown
            const genderDropdown = document.getElementById("updateGender");
            for (let i = 0; i < genderDropdown.options.length; i++) {
                if (genderDropdown.options[i].value.toLowerCase() === gender.toLowerCase()) {
                    genderDropdown.options[i].selected = true;
                    break;
                }
            }

            // Show the modal
            document.getElementById("updateModal").style.display = "flex";
        }

        function closeUpdateModal() {
            document.getElementById("updateModal").style.display = "none";
        }
        
        function openDeleteModal(staffType, staffId, staffName) {
            document.getElementById("deleteStaffType").value = staffType;
            document.getElementById("deleteStaffId").value = staffId;
            document.getElementById("deleteStaffName").innerText = staffName;
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
