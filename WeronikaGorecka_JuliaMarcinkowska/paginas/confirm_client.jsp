<%--<?php--%>
<%--include "../basedados/basedados.h";--%>

<%--session_start();--%>
<%--if (!isset($_SESSION["user"]) || !isset($_SESSION["type"]) || $_SESSION["type"] == -1) {--%>
<%--    echo "Error, you are not logged in, redirecting to main page.";--%>
<%--    header('refresh:2; url=index.html');--%>
<%--    exit();--%>
<%--}--%>
<%--if (isset($_SESSION["user"]) && isset($_SESSION["type"]) && $_SESSION["type"] == -1) {--%>
<%--    echo "Error, redirecting to employee page.";--%>
<%--    header('refresh:2; url=employee_page.jsp');--%>
<%--    exit();--%>
<%--}--%>
<%--global $conn;--%>

<%--$user_id = $_GET["user_id"];--%>
<%--$sql_cc = "UPDATE users SET status='" . 1 . "' WHERE id=" . $user_id;--%>
<%--$retval_cc = mysqli_query($conn, $sql_cc);--%>
<%--if (!$retval_cc) {--%>
<%--    die('Could not update data: ' . mysqli_error($conn));--%>
<%--}--%>
<%--if (mysqli_affected_rows($conn) == 1)--%>
<%--    echo "Client confirmed.";--%>
<%--else--%>
<%--    echo "Confirmation of client failed. Try again later.";--%>
<%--header('refresh:2; url=users_table.jsp');--%>

<%--?>--%>