<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Report Selection</title>
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
        .report-button {
            display: block;
            width: 100%;
            max-width: 250px;
            padding: 15px;
            margin: 10px auto;
            font-size: 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.3s;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }
        .report-button:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }
    </style>
</head>
    <body>
        <div class="navbar">
            <jsp:include page="links.jsp" />
        </div>
        <div class="container">
            <h2>Generate Reports</h2>
            <form action="MSAgeReport" method="post">
                <button type="submit" class="report-button">Age Distribution Report</button>
            </form>
            <form action="MSGenderReport" method="post">
                <button type="submit" class="report-button">Gender Distribution Report</button>
            </form>
            <form action="MSPaymentMethodReport" method="post">
                <button type="submit" class="report-button">Payment Method Distribution Report</button>
            </form>
            <form action="MSRevenueReport" method="post">
                <button type="submit" class="report-button">Revenue Distribution Report</button>
            </form>
            <form action="MSProductDistributedbyMonth" method="post">
                <button type="submit" class="report-button">Product Distribution by Month Report</button>
            </form>
            
        </div>
    </body>
</html>