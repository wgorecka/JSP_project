<%@ page language="java" import="java.sql.*" %>
<%@ include file="/WeronikaGorecka_JuliaMarcinkowska/basedados/basedados.jsp" %>
<%

    PreparedStatement psSelectRecord = null;
    ResultSet rsSelectRecord = null;
    String sqlSelectRecord = null;

    sqlSelectRecord = "SELECT * FROM users";
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
<html>
<head>
    <title>where clause in JDBC Query</title>
    <style>
        th {
            text-align: left;
            padding-left: 5px;
        }

        td {
            text-align: left;
            padding-left: 5px;
        }
    </style>
</head>

<body>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Morada</th>
        <th>Phone</th>
    </tr>
    <%
        int cnt = 1;
        while (rsSelectRecord.next()) {
    %>
    <tr>
        <td><%=rsSelectRecord.getString("ID")%>&nbsp;</td>
        <td><%=rsSelectRecord.getString("name")%>&nbsp;</td>
        <td><%=rsSelectRecord.getString("email")%>&nbsp;</td>
        <td><%=rsSelectRecord.getString("login")%>&nbsp;</td>
    </tr>
    <%
            cnt++;   /// increment of counter
        } /// End of while loop
    %>

</table>

</body>
</html>
<%
    try {
        if (psSelectRecord != null) {
            psSelectRecord.close();
        }
        if (rsSelectRecord != null) {
            rsSelectRecord.close();
        }


        if (conn != null) {
            conn.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>