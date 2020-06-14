<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else if (session.getAttribute("user") != null && session.getAttribute("type") != null && (Integer) session.getAttribute("type") != 1) {
        out.println("Error, redirecting to employee page.");
        response.setHeader("Refresh", "3;url=employee_page.jsp");
    } else {
        int user_id = (Integer) session.getAttribute("user");
        PreparedStatement psSelectRecord = null;
        ResultSet rsSelectRecord = null;
        String sqlSelectRecord = "SELECT * FROM users WHERE ID='" + user_id + "'";

        assert conn != null;
        try {
            psSelectRecord = conn.prepareStatement(sqlSelectRecord);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        try {
            assert psSelectRecord != null;
            rsSelectRecord = psSelectRecord.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
%>
<!doctype html>
<html lang="en">
<head>
    <title>Client page</title>
    <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>

    <style>
        html,
        body {
            height: 100%;
        }

        th {
            width: 200px;
        }

        tr {
            height: 50px;
        }
    </style>
</head>

<body class="text-center">
<div class="d-flex justify-content-end m-2">
    <a href="logout.jsp" class="btn btn-lg btn-dark mr-1">Log out</a>
</div>
<div class="d-flex">
    <img src="resources/bus_icon.png" class="mx-auto mt-lg-5 mb-lg-4" style="width: 250px;"/>
</div>
<div class="d-flex justify-content-center">
    <div class="card">
        <div class="card-header">
            Your personal data
        </div>
        <div class="card-body">
            <p class="card-text">
                <%
                    while (true) {
                        try {
                            if (!rsSelectRecord.next()) break;

                %>
                <b>Your name:</b> <%=rsSelectRecord.getString("name")%> <br>
                <b>Your email: </b><%=rsSelectRecord.getString("email")%> <br>
                <b>Your login: </b><%=rsSelectRecord.getString("login")%> <br>
                <%
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                    }
                    String href = "edit_data_view.jsp?user_id=" + user_id;
                %>
                <a href="<%=href%>" class='btn btn-dark mt-md-3'>Edit</a>
            </p>
        </div>
    </div>
</div>
<div class="d-flex justify-content-center mt-lg-4 mb-lg-4">
    <div class="card">
        <div class="card-header">
            Your reservations
        </div>
        <div class="card-body">
            <p class="card-text">
            <table style='text-align:center;'>
                <tr>
                    <th>Date</th>
                    <th>City from</th>
                    <th>City to</th>
                    <th>Departure time</th>
                    <th>Arrival time</th>
                    <th>No of passengers</th>
                    <th>Status</th>
                    <th></th>
                </tr>
                <%--                <?php--%>
                <%--                $sql = "SELECT * FROM tickets WHERE user_id=" . $user_id;--%>
                <%--                $retval = mysqli_query($conn, $sql);--%>
                <%--                if (!$retval) {--%>
                <%--                    die('Could not get data: ' . mysqli_error($conn));--%>
                <%--                }--%>
                <%--                while ($row = mysqli_fetch_array($retval)) {--%>
                <%--                    echo "<tr><td>" . $row["date"] . "</td>";--%>
                <%--                    $sql_c = "SELECT * FROM courses WHERE ID =" . $row["course_id"];--%>
                <%--                    $retval_c = mysqli_query($conn, $sql_c);--%>
                <%--                    if (!$retval_c) {--%>
                <%--                        die('Could not get data: ' . mysqli_error($conn));--%>
                <%--                    }--%>
                <%--                    $course = mysqli_fetch_array($retval_c);--%>
                <%--                    echo "<td>" . $course['city_from'] . "</td>";--%>
                <%--                    echo "<td>" . $course['city_to'] . "</td>";--%>
                <%--                    echo "<td>" . $course['hour_dep'] . "</td>";--%>
                <%--                    echo "<td>" . $course['hour_arr'] . "</td>";--%>
                <%--                    echo "<td>" . $row['pass_no'] . "</td>";--%>
                <%--                    switch ($row["status"]) {--%>
                <%--                        case 0:--%>
                <%--                            $status = "Reserved";--%>
                <%--                            break;--%>
                <%--                        case 1:--%>
                <%--                            $status = "Payed for";--%>
                <%--                            break;--%>
                <%--                        case -1:--%>
                <%--                            $status = "Cancelled";--%>
                <%--                            break;--%>
                <%--                    }--%>
                <%--                    echo "<td>" . $status . "</td>";--%>
                <%--                    if ($row["status"] == 0) {--%>
                <%--                        echo "<td><a href='cancel_reservation.php?ticket_id=" . $row['ID'] . "' class='btn btn-dark'>Cancel</td></tr>";--%>
                <%--                    } else {--%>
                <%--                        echo "</tr>";--%>
                <%--                    }--%>

                <%--                }--%>
                <%--                ?>--%>
            </table>
            <br>
            </p>
            <a href="search_bus.jsp" class="btn btn-dark">Buy new ticket</a>
        </div>
    </div>
</div>
<div class="jumbotron d-flex justify-content-center">
    <div class="container">
        <h1 class="display-4">Contact information</h1>
        <p class="lead">
        <h3><b>CBBus</b> <br></h3>
        <div class="d-flex justify-content-center">
            <table>
                <tr>
                    <th></th>
                    <th></th>
                </tr>
                <tr>
                    <td class="pr-lg-5"><b>Adress:</b></td>
                    <td class="pl-lg-5">Av. 1 de Maio 235,<br>6000-086 Castelo Branco</td>
                </tr>
                <tr>
                    <td class="pr-lg-5"><b>Contact:</b></td>
                    <td class="pl-lg-5">info@cbbus.pt<br>+351 695 246 213</td>
                </tr>
                <tr>
                    <td class="pr-lg-5"><b>Operating hours:</b></td>
                    <td class="pl-lg-5">Monday to friday: 9.00 am to 19.00 pm <br>
                        Saturday: 10.00 am to 14.00 <br>
                        Sunday: Closed
                    </td>
                </tr>
            </table>
        </div>
        </p>
    </div>
</div>
</body>
</html>
<%
    }
%>