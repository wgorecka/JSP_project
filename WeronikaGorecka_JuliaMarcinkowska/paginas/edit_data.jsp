<%@ page language="java" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>

<%
    if (session.getAttribute("user") == null || session.getAttribute("type") == null || (Integer) session.getAttribute("type") == -1) {
        out.println("Error, you are not logged in, redirecting to main page.");
        response.setHeader("Refresh", "3;url=index.jsp");
    } else {
        if (session.getAttribute("user") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String login = request.getParameter("login");
            String password = request.getParameter("password");
            int user_id = Integer.parseInt(request.getParameter("user"));
            int type = (Integer) session.getAttribute("type");

            PreparedStatement psSelectRecord = null;
            PreparedStatement psUpdate = null;
            ResultSet rsSelectRecord = null;
            String sqlSelectRecord = "SELECT * FROM users WHERE ID='" + user_id + "'";

            assert conn != null;

            try {
                psSelectRecord = conn.prepareStatement(sqlSelectRecord);
                assert psSelectRecord != null;
                rsSelectRecord = psSelectRecord.executeQuery();
                if (!rsSelectRecord.next()){
                    out.println("Could not get data");
                } else {
                    String sqlUpdate =  "UPDATE users SET name='" + name + "', email='" + email + "', login='" + login
                            + "', password='" + password + "' WHERE id=" + user_id;
                    psUpdate = conn.prepareStatement(sqlUpdate);
                    assert psUpdate != null;
                    psUpdate.executeUpdate(sqlUpdate);
                    out.println("Edition of personal information successful.");


                    switch(type){
                        case 1:
                            response.setHeader("Refresh", "4;url=client_page.jsp");
                            break;
                        case 2:
                            response.setHeader("Refresh", "4;url=employee_page.jsp");
                            break;
                    }

                }

            } catch (SQLException e) {
                e.printStackTrace();
            }


        } else response.setHeader("Refresh", "4;url=index.jsp");
    }
%>