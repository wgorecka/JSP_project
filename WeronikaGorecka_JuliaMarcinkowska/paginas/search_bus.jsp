<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
%>

<!doctype html>
<html lang="en">
<head>
    <title>Search</title>
    <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>

    <style>

        html,
        body {
            height: 100%;
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
<%
    PreparedStatement psSelectRecord = null;
    ResultSet rsSelectRecord = null;
    String sqlSelectRecord = "SELECT * FROM courses";

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
<form class='justify-content-center d-flex' action='bus_table.jsp' method='post'>
    <select class='custom-select w-25 mx-lg-3' name='route_select' required>
        <option value='' disabled selected>Choose route</option>
        <%
            while (true) {
                try {
                    if (!rsSelectRecord.next()) break;
                    String opt = rsSelectRecord.getString("city_from") + " - " + rsSelectRecord.getString("city_to");
        %>
        <option value="<%=rsSelectRecord.getInt("ID")%>"><%=opt%>
        </option>
        <%
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        %>
    </select>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>
    <input type='date' min='<%=sdf.format(new Date())%>' name='date_search' class='form-control w-25 mx-lg-3'
           placeholder='Date' required>
    <button class='btn btn-dark' type='submit'>Search</button>
</form>
</body>
</html>
<%
    }
%>