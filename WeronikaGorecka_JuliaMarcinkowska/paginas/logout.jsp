<%
    session.removeAttribute("name");
    session.removeAttribute("user");
    session.invalidate();
    response.setHeader("Refresh", "0;url=index.jsp");
%>