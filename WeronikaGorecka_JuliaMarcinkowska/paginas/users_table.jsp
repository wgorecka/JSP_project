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
        int user_id = (Integer) session.getAttribute("user");
        PreparedStatement psSelectRecord = null;
        ResultSet rsSelectRecord = null;
        String sqlSelectRecord = "SELECT * FROM users WHERE ID <>" + user_id +
                " ORDER BY CASE WHEN status = '0' THEN 1 WHEN status = '1' THEN 2 WHEN status = '-1' THEN 3 END ASC";

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
    <title>Users</title>
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
            height: 75px;
        }
    </style>
</head>

<body>
<div class="d-flex justify-content-end m-2">
    <a href="logout.jsp" class="btn btn-lg btn-dark mr-1">Log out</a>
</div>
<div class="d-flex">
    <img src="resources/bus_icon.png" class="mx-auto mt-lg-5 mb-lg-4" style="width: 250px;"/>
</div>
<div class="justify-content-center d-flex">
    <table style='text-align:center;'>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Login</th>
            <th>Usertype</th>
            <th>User status</th>
            <th></th>
        </tr>
        <%
            while (true) {
                try {
                    if (!rsSelectRecord.next()) break;
        %>
        <tr>
            <td><%=rsSelectRecord.getString("name")%>
            </td>
            <td><%=rsSelectRecord.getString("email")%>
            </td>
            <td><%=rsSelectRecord.getString("login")%>
            </td>
            <%
                String type = "";
                switch (rsSelectRecord.getInt("usertype")) {
                    case 1:
                        type = "Client";
                        break;
                    case 2:
                        type = "Admin";
                        break;
                }
            %>
            <td><%=type%>
            </td>
            <%
                String status = "";
                switch (rsSelectRecord.getInt("status")) {
                    case 0:
                        status = "Waiting for confirmation";
                        break;
                    case 1:
                        status = "Confirmed";
                        break;
                    case -1:
                        status = "Deleted";
                        break;
                }
            %>
            <td><%=status%>
            </td>
            <%
                if (rsSelectRecord.getInt("status") == 0) {
                    String href_conf = "confirm_client.jsp?user_id=" + rsSelectRecord.getString("ID");
            %>
            <td><a href="<%=href_conf%>" class='btn btn-dark'>Confirm</a></td>
            <%
            } else {
            %>
            <td></td>
            <%
                }
                if (rsSelectRecord.getInt("status") != -1) {
                    String href_edit = "edit_data_view.jsp?user_id=" + rsSelectRecord.getString("ID");
                    String href_del = "delete_user.jsp?user_id=" + rsSelectRecord.getString("ID");
            %>
            <td><a href='<%=href_edit%>' class='btn btn-dark'>Edit user</a></td>
            <td><a href='<%=href_del%>' class='btn btn-dark'>Delete user</a></td>
        </tr>
        <%
                    }
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        %>
    </table>
</div>
<div class="d-flex justify-content-center m-5">
    <a href='add_user_view.jsp' class='btn btn-dark'>Add new user</a>
</div>
</body>
</html>
<%
    }
%>