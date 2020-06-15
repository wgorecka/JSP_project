<%@ page language="java" import="java.sql.*" %>
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
    <title>Edit personal information</title>
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
<div>
<%
    int user_id = Integer.parseInt(request.getParameter("user_id"));
    PreparedStatement psSelectRecord = null;
    ResultSet rsSelectRecord = null;
    String sqlSelectRecord = "SELECT * FROM users WHERE ID=" + user_id;

    assert conn != null;

    try {
        psSelectRecord = conn.prepareStatement(sqlSelectRecord);
        assert psSelectRecord != null;
        rsSelectRecord = psSelectRecord.executeQuery();
        if (!rsSelectRecord.next()) {
            out.println("Could not get data");
        } else {


%>
</div>
<form class='form-signin' action='edit_data.jsp' method='post'>
    <h1 class='h3 mb-3 font-weight-normal'>Edit personal information</h1>
    <input type='text' name='name' class='form-control mt-lg-1' placeholder="Name" value='<%=rsSelectRecord.getString("name")%>'
           autofocus required/>
    <input type='email' name='email' class='form-control mt-lg-1' placeholder="Email" value='<%=rsSelectRecord.getString("email")%>'
           required/>
    <input type='text' name='login' class='form-control mt-lg-1' placeholder="Login" value='<%=rsSelectRecord.getString("login")%>'
           required/>
    <input type='password' name='password' class='form-control mt-lg-1' placeholder="Password"
           value='<%=rsSelectRecord.getString("password")%>' required/>
    <input type = 'hidden' name='user' value='<%=rsSelectRecord.getString("ID")%>'/>
    <button class='btn btn-lg btn-primary btn-block mt-lg-1' type='submit'>Submit</button>
</form>

</body>
</html>

<%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } }
%>