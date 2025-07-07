<%-- 
    Document   : addAnnouncement
    Created on : Nov 25, 2024, 2:14:25 PM
    Author     : vinni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Announcement</title>
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
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input, textarea { width: 100%; padding: 8px; margin: 5px 0 10px; border: 1px solid #ccc; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; }
        /* Modal styles */
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); }
        .modal-content { position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 400px; background: white; padding: 20px; border-radius: 10px; text-align: center; }
        .modal-buttons { margin-top: 20px; }
        .btn { padding: 10px 15px; margin: 0 5px; border: none; border-radius: 5px; cursor: pointer; }
        .btn-confirm { background-color: #28a745; color: white; }
        .btn-cancel { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h2>Add Announcement</h2>
        <form id="announcementForm" action="MSAddAnnouncement" method="post">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="content">Content:</label>
                <textarea id="content" name="content" rows="5" required></textarea>
            </div>
            <button type="button" onclick="showModal()">Save Announcement</button>
        </form>
    </div>

    <!-- Modal -->
    <div id="confirmationModal" class="modal">
        <div class="modal-content">
            <h3>Confirm Announcement</h3>
            <p>Are you sure you want to create this announcement?</p>
            <div class="modal-buttons">
                <button class="btn btn-confirm" onclick="submitForm()">Confirm</button>
                <button class="btn btn-cancel" onclick="closeModal()">Cancel</button>
            </div>
        </div>
    </div>

    <script>
        // Show the modal
        function showModal() {
            document.getElementById('confirmationModal').style.display = 'block';
        }

        // Close the modal
        function closeModal() {
            document.getElementById('confirmationModal').style.display = 'none';
        }

        // Submit the form
        function submitForm() {
            document.getElementById('announcementForm').submit();
        }
    </script>
</body>
</html>
