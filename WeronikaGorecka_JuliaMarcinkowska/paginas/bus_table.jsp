<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
        int course_id = Integer.parseInt(request.getParameter("route_select"));
        String date_sel = request.getParameter("date_search");
        PreparedStatement psSelectRecord = null;
        ResultSet rsSelectRecord = null;
        String sqlSelectRecord = "SELECT * FROM courses WHERE ID=" + course_id;

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
    <title>Search results</title>
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
    <a href="logout.jsp" class="btn btn-lg btn-dark mr-1">Log out</a>
</div>
<div class="d-flex">
    <img src="resources/bus_icon.png" class="mx-auto mt-lg-5 mb-lg-4" style="width: 250px;"/>
</div>
<div class="justify-content-center d-flex">
    <table style='text-align:center;'>
        <tr>
            <th>Date</th>
            <th>City from</th>
            <th>City to</th>
            <th>Departure time</th>
            <th>Arrival time</th>
            <th>Price</th>
            <th>No of places left</th>
            <th></th>
        </tr>
        <%
            while (true) {
                try {
                    if (!rsSelectRecord.next()) break;
                    PreparedStatement psSelectRecord_c = null;
                    ResultSet rsSelectRecord_c = null;
                    String sql_c = "SELECT sum(pass_no) AS sum FROM tickets where course_id=" + course_id + " AND date='" + date_sel +
                            "'AND status <> '-1'";

                    assert conn != null;
                    try {
                        psSelectRecord_c = conn.prepareStatement(sql_c);
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    }

                    try {
                        assert psSelectRecord_c != null;
                        rsSelectRecord_c = psSelectRecord_c.executeQuery();
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    }
                    while (true) {
                        try {
                            if (!rsSelectRecord_c.next()) break;
                            int places_left = rsSelectRecord.getInt("capacity") - rsSelectRecord_c.getInt("sum");
                            String href = "confirm_buy.jsp?date=" + date_sel + "&course_id=" + course_id;
        %>
        <tr>
            <td><%=date_sel%>
            </td>
            <td><%=rsSelectRecord.getString("city_from")%>
            </td>
            <td><%=rsSelectRecord.getString("city_to")%>
            </td>
            <td><%=rsSelectRecord.getString("hour_dep")%>
            </td>
            <td><%=rsSelectRecord.getString("hour_arr")%>
            </td>
            <td><%=rsSelectRecord.getString("price")%>
            </td>
            <td><%=places_left%>
            </td>
            <td><a href="<%=href%>" class='btn btn-dark'>Buy</a></td>
        </tr>
        <%
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                    }
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        %>
    </table>
</div>
</body>
</html>
<%
    }
%>