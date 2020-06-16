<%@ page contentType="text/html; ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
        int user_id = 0;
        if ((Integer) session.getAttribute("type") == 1) {
            user_id = (Integer) session.getAttribute("user");
        } else if ((Integer) session.getAttribute("type") == 2) {
            user_id = Integer.parseInt(request.getParameter("user_select"));
        }
        String date = request.getParameter("date");
        int course_id = Integer.parseInt(request.getParameter("course_id"));
        int pass_no = Integer.parseInt(request.getParameter("pass_no"));

        PreparedStatement psInsert;
        try {
            String sqlInsert = "INSERT INTO tickets (course_id, user_id, pass_no, date) VALUES (" + course_id + ","
                    + user_id + "," + pass_no + "," + "'" + date + "'" + ")";
            psInsert = conn.prepareStatement(sqlInsert);
            assert psInsert != null;
            psInsert.executeUpdate(sqlInsert);
            if ((Integer) session.getAttribute("type") == 1) {
                out.println("Reservation successful. You will receive an email with payment information. If we don't receive" +
                        " payment in 3 working days, your reservation will be cancelled.");
            } else if ((Integer) session.getAttribute("type") == 2) {
                out.println("Reservation successful. Chosen client will receive an email with payment information.");
            }
        } catch (SQLException ex) {
            out.println("Reservation failed, try again later or contact us.");
        }
        if ((Integer) session.getAttribute("type") == 1) {
            response.setHeader("Refresh", "4;url=client_page.jsp");
        } else if ((Integer) session.getAttribute("type") == 2) {
            response.setHeader("Refresh", "4;url=employee_page.jsp");
        }
    }
%>