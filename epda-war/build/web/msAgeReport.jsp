<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Age Report</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .container {
            padding-top: 100px; 
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        table th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #0056b3;
        }

        .chart-container {
            width: 100%;
            height: 500px;
            margin-top: 30px;
        }
    </style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});

        google.charts.setOnLoadCallback(drawCustomerChart);
        google.charts.setOnLoadCallback(drawDeliveryChart);
        google.charts.setOnLoadCallback(drawManagingChart);

        function drawCustomerChart() {
            var data = google.visualization.arrayToDataTable([
                ['Age Group', 'Count'],
                <c:forEach var="entry" items="${customerAge.entrySet()}">
                    ['${entry.key}', ${entry.value}],
                </c:forEach>
            ]);

            var options = {
                title: 'Customer Age Distribution',
                pieHole: 0.4,
                chartArea: {width: '80%', height: '80%'}
            };

            var chart = new google.visualization.PieChart(document.getElementById('customerChart'));
            chart.draw(data, options);
        }

        function drawDeliveryChart() {
            var data = google.visualization.arrayToDataTable([
                ['Age Group', 'Count'],
                <c:forEach var="entry" items="${deliveryAge.entrySet()}">
                    ['${entry.key}', ${entry.value}],
                </c:forEach>
            ]);

            var options = {
                title: 'Delivery Staff Age Distribution',
                pieHole: 0.4,
                chartArea: {width: '80%', height: '80%'}
            };

            var chart = new google.visualization.PieChart(document.getElementById('deliveryChart'));
            chart.draw(data, options);
        }

        function drawManagingChart() {
            var data = google.visualization.arrayToDataTable([
                ['Age Group', 'Count'],
                <c:forEach var="entry" items="${managingAge.entrySet()}">
                    ['${entry.key}', ${entry.value}],
                </c:forEach>
            ]);

            var options = {
                title: 'Managing Staff Age Distribution',
                pieHole: 0.4,
                chartArea: {width: '80%', height: '80%'}
            };

            var chart = new google.visualization.PieChart(document.getElementById('managingChart'));
            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h1>Age Distribution Report</h1>

        <h2>Customers</h2>
        <table>
            <thead>
                <tr> 
                    <th>Age Group</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entry" items="${customerAge.entrySet()}">
                    <tr>
                        <td>${entry.key}</td>
                        <td>${entry.value}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="customerChart" class="chart-container"></div>

        <h2>Delivery Staff</h2>
        <table>
            <thead>
                <tr>
                    <th>Age Group</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entry" items="${deliveryAge.entrySet()}">
                    <tr>
                        <td>${entry.key}</td>
                        <td>${entry.value}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="deliveryChart" class="chart-container"></div>

        <h2>Managing Staff</h2>
        <table>
            <thead>
                <tr>
                    <th>Age Group</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="entry" items="${managingAge.entrySet()}">
                    <tr>
                        <td>${entry.key}</td>
                        <td>${entry.value}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="managingChart" class="chart-container"></div>

        <!-- Back Button -->
        <a href="msGenerateReport.jsp" class="back-button">Back to Generate Reports</a>
    </div>
</body>
</html>
