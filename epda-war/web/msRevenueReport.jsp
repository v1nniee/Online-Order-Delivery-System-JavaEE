<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Revenue Distribution</title>
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
        .month-section {
            margin-bottom: 30px;
        }
        .month-title {
            font-size: 20px;
            margin-bottom: 10px;
        }
        .chart-container {
            width: 80%;
            margin: 0 auto;
            padding-bottom: 20px;
        }
        .no-data-message {
            text-align: center;
            font-size: 16px;
            color: #777;
            margin-top: 20px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="navbar">
        <jsp:include page="links.jsp" />
    </div>
    <div class="container">

        <h1>Revenue Distribution by Date</h1>
        <c:choose>
            <c:when test="${not empty revenueByPaymentDate}">
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Total Revenue</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${revenueByPaymentDate}">
                            <tr>
                                <td>${entry.key}</td>
                                <td><fmt:formatNumber value="${entry.value}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var ctx = document.getElementById('revenueChart').getContext('2d');
                        var paymentDates = [];
                        var totalRevenues = [];
                        <c:forEach var="entry" items="${revenueByPaymentDate}">
                            paymentDates.push("${entry.key}");
                            totalRevenues.push(${entry.value});
                        </c:forEach>
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: paymentDates,
                                datasets: [{
                                    label: 'Total Revenue',
                                    data: totalRevenues,
                                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                                    borderColor: 'rgba(75, 192, 192, 1)',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    });
                </script>
            </c:when>
            <c:otherwise>
                <div class="no-data-message">
                    <p>No revenue data available for payment dates.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Back Button -->
        <a href="msGenerateReport.jsp" class="back-button">Back to Generate Reports</a>
    </div>
</body>
</html>
