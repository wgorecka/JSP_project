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
        if (request.getParameter("name") != null && request.getParameter("email") != null &&
                request.getParameter("login") != null && request.getParameter("password") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            String usertype = request.getParameter("usertype_select");

            PreparedStatement psSelectRecord;
            PreparedStatement psInsert;
            ResultSet rsSelectRecord;
            String sqlSelectRecord = "SELECT * FROM users WHERE login='" + login + "'";

            assert conn != null;
            try {
                psSelectRecord = conn.prepareStatement(sqlSelectRecord);
                assert psSelectRecord != null;
                rsSelectRecord = psSelectRecord.executeQuery();
                if (rsSelectRecord.next()) {
                    out.println("Registration failed, this login already exists, please select another one.");
                    response.setHeader("Refresh", "3;url=registration.html");
                } else {
                    String sqlInsert = "INSERT INTO users (name, email, login, password, usertype, status) VALUES "
                            + "(" + "'" + name + "'" + "," + "'" + email + "'" + "," + "'" + login + "'" + "," + "'"
                            + password + "'" + "," + usertype + "," + "1" + ")";
                    psInsert = conn.prepareStatement(sqlInsert);
                    assert psInsert != null;
                    psInsert.executeUpdate(sqlInsert);
                    out.println("Adding new user successful.");
                    response.setHeader("Refresh", "3;url=employee_page.jsp");
                }

            } catch (SQLException e) {
                out.println("Adding new user failed, try again later.");
                e.printStackTrace();
            }
        }
    }
%>