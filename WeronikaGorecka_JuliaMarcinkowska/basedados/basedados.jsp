<%@ page language="java" import="java.sql.*" %>
<%
    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (InstantiationException e) {
        e.printStackTrace();
    } catch (IllegalAccessException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    String jdbcURL = "jdbc:mysql://127.0.0.1:3306/cbbus_jsp";
    try {
        conn = DriverManager.getConnection(jdbcURL, "root", "");
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>