<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Method Distribution Report</title>
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

        #paymentChart {
            width: 100%;
            height: 500px;
            margin-top: 50px;
        }

        .no-data-message {
            text-align: center;
            font-size: 16px;
            color: #777;
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        function drawChart() {
            var data = google.visualization.arrayToDataTable([[
                'Payment Method', 'Count'
            ],
            <c:forEach var="entry" items="${paymentMethodDistribution}">
                ['${entry.key}', ${entry.value}],
            </c:forEach>
            ]);

            var options = {
                title: 'Payment Method Distribution',
                pieHole: 0.4,
                chartArea: {width: '80%', height: '80%'}
            };

            var chart = new google.visualization.PieChart(document.getElementById('paymentChart'));
            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">
        <h1>Payment Method Distribution Report</h1>
        <c:choose>
            <c:when test="${not empty paymentMethodDistribution}">
                <table>
                    <thead>
                        <tr>
                            <th>Payment Method</th>
                            <th>Count</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${paymentMethodDistribution}">
                            <tr>
                                <td>${entry.key}</td>
                                <td>${entry.value}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pie Chart -->
                <div id="paymentChart"></div>
                <script>
                    google.charts.setOnLoadCallback(drawChart);
                </script>
            </c:when>
            <c:otherwise>
                <div class="no-data-message">
                    <p>No data available for payment method distribution.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Back Button -->
        <a href="msGenerateReport.jsp" class="back-button">Back to Generate Reports</a>
    </div>
</body>
</html>
