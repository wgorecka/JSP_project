<%@ page language="java" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>
<%
    if (request.getParameter("name") != null && request.getParameter("email") != null &&
            request.getParameter("login") != null && request.getParameter("password") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
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
                String sqlInsert = "INSERT INTO users (name, email, login, password, usertype) VALUES (" + "'" + name + "'" + ","
                        + "'" + email + "'" + "," + "'" + login + "'" + "," + "'" + password + "'" + "," + "1" + ")";
                psInsert = conn.prepareStatement(sqlInsert);
                assert psInsert != null;
                psInsert.executeUpdate(sqlInsert);
                out.println("Registration successful, please wait for account confirmation.");
                response.setHeader("Refresh", "3;url=index.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
