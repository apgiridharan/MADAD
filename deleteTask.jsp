<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : deleteTask
    Author     : Deema Alnuhait
    this page deletes task identified by ManageTask's pages. 
    Email: deemaazizn@outlook.com --%>

<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
    <%
    String str = "";
    String recordToDelete = request.getParameter("ID");
    %>
    
    <c:set var="r" value="<%=recordToDelete%>"/>
    <sql:update var="del" dataSource="jdbc/madad">
        DELETE FROM task
        WHERE T_ID = '${r}';
    </sql:update>
  <% 
       out.println("<script type=\"text/javascript\">");
       out.println("alert('.تم حذف المهمة بنجاح');");
        out.println("location='manageTask.jsp';");
       out.println("</script>");
%>
     
        </body>
</html>