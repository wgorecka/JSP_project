<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>
<%
    if (request.getParameter("login") != null && request.getParameter("password") != null) {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        PreparedStatement psSelectRecord;
        ResultSet rsSelectRecord;

        String sqlSelectRecord = "SELECT * FROM users WHERE login='" + login + "' AND password='" + password + "'";

        assert conn != null;
        try {
            psSelectRecord = conn.prepareStatement(sqlSelectRecord);
            assert psSelectRecord != null;
            rsSelectRecord = psSelectRecord.executeQuery();
            if (!rsSelectRecord.next()) {
                out.println("Error while logging in");
                session.setAttribute("user", -1);
                session.setAttribute("type", -1);
                response.setHeader("Refresh", "3;url=index.jsp");
            } else if (rsSelectRecord.getInt("status") == 1) {
                session.setAttribute("user", rsSelectRecord.getInt("ID"));
                session.setAttribute("type", rsSelectRecord.getInt("usertype"));
            } else if (rsSelectRecord.getInt("status") == 0) {
                out.println("Your account is registered, but not yet confirmed.");
                session.setAttribute("user", -1);
                session.setAttribute("type", -1);
                response.setHeader("Refresh", "3;url=index.jsp");
            } else {
                out.println("Invalid login or password, please try to log in again or contact administrator.");
                session.setAttribute("user", -1);
                session.setAttribute("type", -1);
                response.setHeader("Refresh", "3;url=index.jsp");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        switch ((Integer) session.getAttribute("type")) {
            case 1:
                response.setHeader("Refresh", "0.5;url=client_page.jsp");
                break;
            case 2:
                response.setHeader("Refresh", "0.5;url=employee_page.jsp");
                break;
        }

    }
%>
