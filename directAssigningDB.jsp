<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
 Document   : directAssigningDB
 Author     : Deema Alnuhait
 the datdabase connection part of direct Assigning annotation type.    
 Email: deemaazizn@outlook.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
<%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
   request.setCharacterEncoding("UTF8");
   String D_ID = request.getParameter("D_ID");
   String T_ID = request.getParameter("TT_ID");
   String value = request.getParameter("slider-1");
   String difficultWords=request.getParameter("difficultWords");
   System.out.print("the words are"+difficultWords);
   //to eliminate blank space at both ends
   difficultWords=difficultWords.trim();
   
   userID="22";
   T_ID="1";
   D_ID="36";
   
%>
    <sql:query var="rs" dataSource="jdbc/madad">
        SELECT * FROM assign_value WHERE U_ID ='<%=userID%>'
        AND T_ID = '<%=T_ID%>'
        AND D_ID =  '<%=D_ID%>';
    </sql:query>
    <c:choose>
        <c:when test="${rs.rowCount > 0}">
            <sql:update var="rs2" dataSource="jdbc/madad">
                UPDATE assign_value 
                SET value ="<%=value%>"
                WHERE U_ID ='<%=userID%>'
                AND T_ID ='<%=T_ID%>'
                AND D_ID ='<%=D_ID%>';
            </sql:update>
        </c:when>
        <c:when test="${rs.rowCount == 0}">
            <sql:update var="rs3" dataSource="jdbc/madad">
                INSERT INTO 
                assign_value (U_ID,D_ID,value,T_ID) 
                VALUES ('<%=userID%>','<%=D_ID%>','<%=value%>','<%=T_ID%>');
            </sql:update>
        </c:when>
    </c:choose>
           
                <%
                response.sendRedirect("directAssigning.jsp?state=done");
                %>
    </body>
</html>