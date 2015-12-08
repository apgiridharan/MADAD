<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this page clears out session, loging out user--%><%
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>