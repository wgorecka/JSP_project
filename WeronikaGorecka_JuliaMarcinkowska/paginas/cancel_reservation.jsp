<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
        int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
        PreparedStatement psInsert;
        try {
            String sqlUpdate = "UPDATE tickets SET status= '-1' WHERE id=" + ticket_id;
            psInsert = conn.prepareStatement(sqlUpdate);
            assert psInsert != null;
            psInsert.executeUpdate(sqlUpdate);
            out.println("Your reservation has been successfully cancelled.");
        } catch (SQLException ex) {
            out.println("Cancellation of your reservation failed. Try again later or contact us.");
            ex.printStackTrace();
        }
        if ((Integer) session.getAttribute("type") == 1) {
            response.setHeader("Refresh", "2;url=client_page.jsp");
        } else {
            response.setHeader("Refresh", "2;url=employee_page.jsp");
        }
    }
%>