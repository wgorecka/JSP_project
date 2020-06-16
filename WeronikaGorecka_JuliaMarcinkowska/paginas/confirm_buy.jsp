<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
        String date = request.getParameter("date");
        int course_id = Integer.parseInt(request.getParameter("course_id"));

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
    </style>
</head>
<body>
<div class="d-flex justify-content-center mt-lg-4 mb-lg-4">
    <div class="card">
        <div class="card-header">
            Your reservation
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
                    <%
                        if ((Integer) session.getAttribute("type") == 2) {
                    %>
                    <th width='600px'>Information about reservation</th>
                    <%
                    } else if ((Integer) session.getAttribute("type") == 1) {
                    %>
                    <th width='300px'>No of passengers</th>
                    <%
                        }
                    %>
                </tr>
                <%
                    while (true) {
                        try {
                            if (!rsSelectRecord.next()) break;
                            PreparedStatement psSelectRecord_c = null;
                            ResultSet rsSelectRecord_c = null;
                            String sql_c = "SELECT sum(pass_no) AS sum FROM tickets where course_id=" + course_id + " AND date='" + date +
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
                %>
                <tr>
                    <td><%=date%>
                    </td>
                    <td><%=rsSelectRecord.getString("city_from")%>
                    </td>
                    <td><%=rsSelectRecord.getString("city_to")%>
                    </td>
                    <td><%=rsSelectRecord.getString("hour_dep")%>
                    </td>
                    <td><%=rsSelectRecord.getString("hour_arr")%>
                    </td>
                    <td>
                        <form method='post' action='buy_ticket.jsp'>
                            <%
                                if ((Integer) session.getAttribute("type") == 2) {
                            %>
                            Number of passengers: <input type='number' class = 'my-lg-3' name='pass_no' min='1' max='<%=places_left%>' autofocus required/>
                            <%
                                } else if (((Integer) session.getAttribute("type") == 1)){
                            %>
                            <input type='number' name='pass_no' min='1' max='<%=places_left%>' autofocus required/>
                            <%
                                }
                            %>
                            <input type='hidden' name='course_id' value='<%=course_id%>'/>
                            <input type='hidden' name='date' value='<%=date%>'/>

                            <%
                                if ((Integer) session.getAttribute("type") == 2) {
                                    PreparedStatement psSelectRecord_u = null;
                                    ResultSet rsSelectRecord_u = null;
                                    String sql_u = "SELECT * FROM users WHERE usertype = 1";
                                    psSelectRecord_u = conn.prepareStatement(sql_u);
                                    assert psSelectRecord_u != null;
                                    rsSelectRecord_u = psSelectRecord_u.executeQuery();
                            %>
                            <select class='custom-select mx-lg-3 my-lg-3' name='user_select' required>
                                <option value='' disabled selected>Choose client</option>
                                <%
                                    while (true) {
                                        try {
                                            if (!rsSelectRecord_u.next()) break;
                                            String opt = rsSelectRecord_u.getString("name");
                                %>
                                <option value="<%=rsSelectRecord_u.getInt("ID")%>"><%=opt%>
                                </option>
                                <%
                                        } catch (SQLException throwables) {
                                            throwables.printStackTrace();
                                        }
                                    }
                                %>
                            </select>
                            <%
                                }
                            %>
                            <input type='submit' class='btn btn-dark mt-lg-1' value='Confirm purchase'/>
                        </form>
                    </td>
                </tr>
                <%
                                } catch(SQLException throwables){
                                throwables.printStackTrace();
                            }
                            }
                        } catch(SQLException throwables){
                        throwables.printStackTrace();
                    }
                    }
                %>
            </table>
            </p>
        </div>
    </div>
</div>
<div class="d-flex justify-content-center my-lg-3">
    <%
        if ((Integer) session.getAttribute("type") == 1) {
    %>
    <a href="client_page.jsp" class="btn btn-dark">Cancel</a>
    <%
        } else if ((Integer) session.getAttribute("type") == 2) {
    %>
    <a href="employee_page.jsp" class="btn btn-dark">Cancel</a>
    <%
        }
    %>
</div>
</body>
</html>
<%
    }
%>