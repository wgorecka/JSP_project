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
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        PreparedStatement psInsert;
        try {
            String sqlUpdate = "UPDATE users SET status= '-1' WHERE id=" + user_id;
            psInsert = conn.prepareStatement(sqlUpdate);
            assert psInsert != null;
            psInsert.executeUpdate(sqlUpdate);
            out.println("User has been successfully deleted.");
        } catch (SQLException ex) {
            out.println("Deletion of user failed. Try again later.");
            ex.printStackTrace();
        }
        response.setHeader("Refresh", "2;url=users_table.jsp");
    }
%>