<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this page enters a new user (annotator/manager) into the database--%>

<% request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("user_name");    
    String pwd = request.getParameter("user_password");
    String email = "";
    email = request.getParameter("user_email");
    String age = "";
    age= request.getParameter("user_age");
        request.setCharacterEncoding("UTF-8");
    String language = "";
    language = request.getParameter("user_language");
    String Education_Level = "";
    Education_Level =request.getParameter("user_edu_level");
    String type = request.getParameter("user_type");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date date1 = new Date();
    String date = df.format(date1);
     String Institution= ""; 
     String Occupation="";
     
    if (type.equals("manager"))
    {
     Institution = request.getParameter("Institution");
     Occupation = request.getParameter("Occupation");
    }
    %>
   <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>          
 <c:set var="type" scope="session" value="<%=type%>" />

    <c:choose>
    
        <c:when test="${type eq 'annotator'}">
            <h1>lol</h1>
         <sql:update dataSource="jdbc/madad" var="insertAnnotator">
INSERT INTO annotator(Name, Email, Education_Level, Age, Native_Language,Date, Password) VALUES  (?,?,?,?,?,?,?);
            <sql:param value="<%=name%>" />
            <sql:param value="<%=email%>" />
            <sql:param value="<%=Education_Level%>" />
            <sql:param value="<%=age%>" />
            <sql:param value="<%=language%>" />
            <sql:param value="<%=date%>" />
            <sql:param value="<%=pwd%>" />
        </sql:update>

         <c:choose>
             <c:when test="${insertAnnotator > 0}" >
       
<% session.setAttribute("userid", name);
    response.sendRedirect("mainAnnotator.jsp");%>
        </c:when>
<c:otherwise>
<% 
 out.println("<script type=\"text/javascript\">");
   out.println("alert('Failed to register new annotator');");
   out.println("location='index.jsp';");
   out.println("</script>");
 %>
</c:otherwise>
        </c:choose>
    </c:when> <%--end annotator --%>
    

<c:otherwise>
    
       <c:choose>

<c:when test="${type eq 'manager'}">
 <sql:update dataSource="jdbc/madad" var="insertManager">
insert into manager(Name, Email, Education_Level, Age, Native_Language, Institution, Occupation, Password) values (?,?,?,?,?,?,?,?);
            <sql:param value="<%=name%>" />
            <sql:param value="<%=email%>" />
            <sql:param value="<%=Education_Level%>" />
            <sql:param value="<%=age%>" />
            <sql:param value="<%=language%>" />
            <sql:param value="<%=Institution%>" />
            <sql:param value="<%=Occupation%>" />
            <sql:param value="<%=pwd%>" />

        </sql:update>
<c:choose>
    <c:when test="${insertManager > 0}" >
       
<% session.setAttribute("userid", name);
    response.sendRedirect("mainManager.jsp");%>
        </c:when>
<c:otherwise>
<% 
 out.println("<script type=\"text/javascript\">");
   out.println("alert('Failed to register new manager');");
   out.println("location='index.jsp';");
   out.println("</script>");
 %>
</c:otherwise>
        </c:choose>

</c:when>
<c:otherwise>
         <% out.println("<script type=\"text/javascript\">");
   out.println("alert('Failed to register new account');");
   out.println("location='index.jsp';");
   out.println("</script>"); %>


</c:otherwise>
   </c:choose>
</c:otherwise>
 </c:choose>

</body> 
</html>