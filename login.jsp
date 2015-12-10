<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01
    Author     : Aysha Al-Mahmoud
this is the login page which search for user/admin name and password in database, 
if it exists it will redirect each user to their home page, if it doesn't exist, pop up msg will appear  
--%>
  <%
    request.setCharacterEncoding("UTF-8");
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String type = "";%>
<sql:query var="result1" dataSource="jdbc/madad">
 SELECT * FROM  annotator WHERE Name= ? and Password= ?    
<sql:param value="<%=userid%>"/>
      <sql:param value="<%=pwd%>"/>
    </sql:query>

<sql:query var="result2" dataSource="jdbc/madad">
select Name, Password from manager where Name= ? and Password= ?    
<sql:param value="<%=userid%>"/>
      <sql:param value="<%=pwd%>"/>
    </sql:query>


<sql:query var="result3" dataSource="jdbc/madad">
select Name, Password from admin where Name= ? and Password= ?    
<sql:param value="<%=userid%>"/>
      <sql:param value="<%=pwd%>"/>
    </sql:query>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

    <c:set var="email" value="${result1.rows[0].Email}"/>

   <c:choose>
<c:when test="${result1.rowCount != 0}">
<% session.setAttribute("userid", userid);
type = "annotator";
String email = (String)pageContext.getAttribute("email");
session.setAttribute("userid", userid);    
session.setAttribute("type", type);
out.println("welcome " + userid );
out.println("<a href='logout.jsp'>Log out</a>");
response.sendRedirect("mainAnnotator.jsp");
%>
</c:when>


<c:otherwise >
    <c:choose>
       
    <c:when test="${result2.rowCount != 0}">
<% session.setAttribute("userid", userid);
type = "manager";
       session.setAttribute("type", type);
       out.println("welcome " + userid);
       out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("mainManager.jsp");%>
        </c:when>
    
    
 <c:otherwise >
     <c:choose>
     <c:when  test="${result3.rowCount != 0}">
     <%type = "admin";
     session.setAttribute("userid", userid);
       session.setAttribute("userid", userid);
        session.setAttribute("type", type);
          out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("mainAdmin.jsp");%>
        </c:when> 
<c:otherwise>
         <%
   out.println("<script type=\"text/javascript\">");
   out.println("alert('User or password incorrect');");
   out.println("location='index.jsp';");
   out.println("</script>");%>
        </c:otherwise>
     </c:choose>
 </c:otherwise>
    
</c:choose>
</c:otherwise>
   </c:choose>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
    <h1>${email}</h1> 
    
</body> 
</html>
