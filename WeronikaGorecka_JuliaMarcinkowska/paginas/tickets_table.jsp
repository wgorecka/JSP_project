<%--<?php--%>

<%--session_start();--%>
<%--if (!isset($_SESSION["user"]) || !isset($_SESSION["type"]) || $_SESSION["type"] == -1) {--%>
<%--    echo "Error, you are not logged in, redirecting to main page.";--%>
<%--    header('refresh:2; url=index.html');--%>
<%--    exit();--%>
<%--}--%>

<%--if (isset($_SESSION["user"]) && isset($_SESSION["type"]) && $_SESSION["type"] == 1) {--%>
<%--    echo "Error, redirecting to client page.";--%>
<%--    header('refresh:2; url=client_page.php');--%>
<%--    exit();--%>
<%--}--%>
<%--?>--%>

<!doctype html>
<html lang="en">
<head>
    <title>Reservations</title>
    <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>

    <style>

        html,
        body {
            height: 100%;
        }

        th {
            width: 170px;
        }
    </style>
</head>

<body>
<div class="d-flex justify-content-end m-2">
    <a href="logout.php" class="btn btn-lg btn-dark mr-1">Log out</a>
</div>
<div class="d-flex">
    <img src="resources/bus_icon.png" class="mx-auto mt-lg-5 mb-lg-4" style="width: 250px;"/>
</div>
<div class="justify-content-center d-flex">
    <table style='text-align:center;'>
        <tr>
            <th>Date</th>
            <th>Name</th>
            <th>City from</th>
            <th>City to</th>
            <th>Departure time</th>
            <th>Arrival time</th>
            <th>No of tickets</th>
            <th>Reservation status</th>
            <th></th>
        </tr>
<%--        <?php--%>
<%--        include "../basedados/basedados.h";--%>

<%--        global $conn;--%>
<%--        if ($_SESSION["type"] == 3) {--%>
<%--            $sql = "SELECT * FROM tickets ORDER BY CASE WHEN status = '0' THEN 1 WHEN status = '1' THEN 2 WHEN status = '-1' THEN 3 END ASC";--%>
<%--        } elseif ($_SESSION["type"] == 2) {--%>
<%--            $sql = "SELECT * FROM tickets ORDER BY date desc";--%>
<%--        }--%>

<%--        $retval = mysqli_query($conn, $sql);--%>
<%--        if (!$retval) {--%>
<%--            die('Could not get data: ' . mysqli_error($conn));--%>
<%--        }--%>
<%--        while ($row = mysqli_fetch_array($retval)) {--%>
<%--            echo "<tr><td>" . $row["date"] . "</td>";--%>
<%--            $sql_u = "SELECT * FROM users WHERE ID =" . $row["user_id"];--%>
<%--            $retval_u = mysqli_query($conn, $sql_u);--%>
<%--            if (!$retval_u) {--%>
<%--                die('Could not get data: ' . mysqli_error($conn));--%>
<%--            }--%>
<%--            $user = mysqli_fetch_array($retval_u);--%>
<%--            echo "<td>" . $user['name'] . "</td>";--%>
<%--            $sql_c = "SELECT * FROM courses WHERE ID =" . $row["course_id"];--%>
<%--            $retval_c = mysqli_query($conn, $sql_c);--%>
<%--            if (!$retval_c) {--%>
<%--                die('Could not get data: ' . mysqli_error($conn));--%>
<%--            }--%>
<%--            $course = mysqli_fetch_array($retval_c);--%>
<%--            echo "<td>" . $course['city_from'] . "</td>";--%>
<%--            echo "<td>" . $course['city_to'] . "</td>";--%>
<%--            echo "<td>" . $course['hour_dep'] . "</td>";--%>
<%--            echo "<td>" . $course['hour_arr'] . "</td>";--%>
<%--            echo "<td>" . $row["pass_no"] . "</td>";--%>
<%--            switch ($row["status"]) {--%>
<%--                case 0:--%>
<%--                    $status = "Reserved";--%>
<%--                    break;--%>
<%--                case 1:--%>
<%--                    $status = "Payed for";--%>
<%--                    break;--%>
<%--                case -1:--%>
<%--                    $status = "Cancelled";--%>
<%--                    break;--%>
<%--            }--%>
<%--            echo "<td>" . $status . "</td>";--%>
<%--            if ($_SESSION["type"] == 3) {--%>
<%--                if ($row["status"] != -1) {--%>
<%--                    echo "<td><a href='cancel_reservation.php?ticket_id=" . $row['ID'] . "' class='btn btn-dark'>Cancel</a></td>";--%>
<%--                }--%>
<%--                if ($row["status"] == 0) {--%>
<%--                    echo "<td><a href='confirm_ticket.php?ticket_id=" . $row['ID'] . "' class='btn btn-dark'>Confirm</a></td>";--%>
<%--                }--%>
<%--            }--%>
<%--            echo "</tr>";--%>
<%--        }--%>
<%--        ?>--%>
    </table>
</div>
</body>
</html>