<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : nextDocCompare
    Author     : Deema Alnuhait
    this page does the database insertion part for readability comparasion annotation
    Email: deemaazizn@outlook.com. --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
//   userID ="17";
   
    request.setCharacterEncoding("UTF8");
    String str = "";
    
    String DP_ID = request.getParameter("DP_ID");
    String T_ID = request.getParameter("ID");
    String DS_ID = request.getParameter("DS_ID");
    String value = request.getParameter("value");
    String str2 = ""; 
    %>
<html>
    <head>
    </head>
    <body>
     <sql:query var="rs" dataSource="jdbc/madad">
        SELECT * 
        FROM compare_to 
        WHERE T_ID = '<%=T_ID%>' 
        AND U_ID ='<%=userID%>' 
        AND DP_ID ='<%=DP_ID%>'
        AND DS_ID ='<%=DS_ID%>'; 
    </sql:query>
    <c:choose>
        
   <!-- if the annotator changes the value he has assigned previously, the changes updated. -->
         <c:when test="${rs.rowCount > 0}"> 
             <c:forEach var="row" items="${rs.rows}">
                 <sql:update var="rs2" dataSource="jdbc/madad">
                     UPDATE compare_to 
                     SET value =N' "<%=value%>"
                     WHERE U_ID = '<%=userID%>' 
                     AND DP_ID='<%=DP_ID%>'
                     AND DS_ID='<%=DS_ID%>'
                     AND T_ID='<%=T_ID%>' ;
                 </sql:update>
             </c:forEach>
         </c:when>
                 <c:otherwise>
                     <sql:update var="rs3" dataSource="jdbc/madad">
                         INSERT INTO compare_to
                         (`DP_ID`, `DS_ID`, `value`, `U_ID`, `T_ID`) 
                         VALUES (‘<%=DP_ID%>’,’<%=DS_ID%>’,N'”<%=value%>”',’<%=userID%>’,’<%=T_ID%>’) ;
                     </sql:update>
                 </c:otherwise>
                     </c:choose>
<%
response.sendRedirect("compareReadability.jsp?ID="+T_ID);
%>
  </body>
</html>