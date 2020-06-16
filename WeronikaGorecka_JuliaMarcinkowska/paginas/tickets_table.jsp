<%@ page language="java" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else if (session.getAttribute("user") != null && session.getAttribute("type") != null && (Integer) session.getAttribute("type") != 2) {
        out.println("Error, redirecting to employee page.");
        response.setHeader("Refresh", "3;url=client_page.jsp");
    } else {
%>

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
        <%
            PreparedStatement psSelectRecord = null;
            ResultSet rsSelectRecord = null;
            String sqlSelectRecord = "SELECT * FROM tickets ORDER BY CASE WHEN status = '0' THEN 1 WHEN status = '1' " +
                    "THEN 2 WHEN status = '-1' THEN 3 END ASC";
            assert conn != null;
            try {
                psSelectRecord = conn.prepareStatement(sqlSelectRecord);
                assert psSelectRecord != null;
                rsSelectRecord = psSelectRecord.executeQuery();
                if (!rsSelectRecord.next()) {
                    out.println("Could not get data");
                } else {

                    while (true) {

                        PreparedStatement psSelectRecord_u = null;
                        ResultSet rsSelectRecord_u = null;
                        String sql_u = "SELECT * FROM users WHERE ID=" + rsSelectRecord.getInt("user_id");
                        psSelectRecord_u = conn.prepareStatement(sql_u);
                        assert psSelectRecord_u != null;
                        rsSelectRecord_u = psSelectRecord_u.executeQuery();

                        if (!rsSelectRecord_u.next()) {
                            out.println("Could not get data");
                        }

                        PreparedStatement psSelectRecord_c = null;
                        ResultSet rsSelectRecord_c = null;
                        String sql_c = "SELECT * FROM courses WHERE ID=" + rsSelectRecord.getInt("course_id");
                        psSelectRecord_c = conn.prepareStatement(sql_c);
                        assert psSelectRecord_c != null;
                        rsSelectRecord_c = psSelectRecord_c.executeQuery();

                        if (!rsSelectRecord_c.next()) {
                            out.println("Could not get data");
                        } %>
        <tr>
            <td><%=rsSelectRecord.getString("date")%>
            </td>
            <td><%=rsSelectRecord_u.getString("name")%>
            </td>
            <td><%=rsSelectRecord_c.getString("city_from")%>
            </td>
            <td><%=rsSelectRecord_c.getString("city_to")%>
            </td>
            <td><%=rsSelectRecord_c.getString("hour_dep")%>
            </td>
            <td><%=rsSelectRecord_c.getString("hour_arr")%>
            </td>
            <td><%=rsSelectRecord.getString("pass_no")%>
            </td>
            <%
                String status = "";
                switch (rsSelectRecord.getInt("status")) {
                    case 0:
                        status = "Reserved";
                        break;
                    case 1:
                        status = "Payed for";
                        break;
                    case -1:
                        status = "Cancelled";
                        break;
                }
            %>
            <td><%=status%>
            </td>
            <% if (rsSelectRecord.getInt("status") != -1) {
                String href_cancel = "cancel_reservation.jsp?ticket_id=" + rsSelectRecord.getString("ID");
            %>
            <td><a href="<%=href_cancel%>" class='btn btn-dark'>Cancel</a></td>
            <% }
                if (rsSelectRecord.getInt("status") == 0) {
                    String href_confirm = "confirm_ticket.jsp?ticket_id=" + rsSelectRecord.getString("ID");
            %>
            <td><a href="<%=href_confirm%>" class='btn btn-dark'>Confirm</a></td>
            <%
                }
            %>
        </tr>
        <%
                            if (!rsSelectRecord.next()) break;
                        }

                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</div>
<div class="d-flex justify-content-center m-5">
    <a href='search_bus.jsp' class='btn btn-dark'>Add new reservation</a>
</div>
</body>
</html>