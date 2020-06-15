<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else if (session.getAttribute("user") != null && session.getAttribute("type") != null && (Integer) session.getAttribute("type") != 2) {
        out.println("Error, redirecting to client page.");
        response.setHeader("Refresh", "3;url=client_page.jsp");
    } else {
%>

<!doctype html>
<html lang="en">
<head>
    <title>Add new user</title>
    <link rel="stylesheet" href="bootstrap-4.5.0/css/bootstrap.min.css"/>

    <style>
        html,
        body {
            height: 100%;
        }

        body {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-align: center;
            align-items: center;
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            width: 100%;
            max-width: 330px;
            padding: 15px;
            margin: auto;
        }

        .form-signin .form-control {
            position: relative;
            box-sizing: border-box;
            height: auto;
            padding: 10px;
            font-size: 16px;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

    </style>
</head>
<body class="text-center">

<div class="align-content-md-center ml-auto">
    <img src="resources/bus_icon.png">
</div>
<form class="form-signin" action="add_user.jsp" method="post">
    <h1 class="h3 mb-3 font-weight-normal">Add new user</h1>
    <%
        PreparedStatement psSelectRecord = null;
        ResultSet rsSelectRecord = null;
        String sqlSelectRecord = "SELECT * FROM usertypes ";

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
    <select class='custom-select mt-lg-1' name='usertype_select' required autofocus>
        <option value='' disabled selected>Choose usertype</option>
        <%
            while (true) {
                try {
                    if (!rsSelectRecord.next()) break;
        %>
        <option value='<%=rsSelectRecord.getString("ID")%>'><%=rsSelectRecord.getString("name")%>
        </option>
        <%
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        %>
    </select>
    <input type="text" name="name" class="form-control mt-lg-1" placeholder="Name" required>
    <input type="email" name="email" class="form-control mt-lg-1" placeholder="Email" required>
    <input type="text" name="login" class="form-control mt-lg-1" placeholder="Login" required>
    <input type="password" name="password" class="form-control mt-lg-1" placeholder="Password" required>
    <button class="btn btn-lg btn-primary btn-block mt-lg-1" type="submit">Add</button>
</form>
</body>
</html>
<%
    }
%>