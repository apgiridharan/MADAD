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
    String recordToDelete = request.getParameter("taskID");
    %>
    
    <c:set var="r" value="<%=recordToDelete%>"/>
    <!-- Deleting from task table-->
    <sql:update var="del" dataSource="jdbc/madad">
        DELETE FROM task
        WHERE ta_ID = '${r}';
    </sql:update>
    
    <!--Deleting from annotation_style table-->
    <sql:update var="del" dataSource="jdbc/madad">
        DELETE FROM annotation_style
        WHERE ta_ID = '${r}';
    </sql:update>
      
    <!--Deleting from assigned_to table  -->
    <sql:update var="del" dataSource="jdbc/madad">
        DELETE FROM assigned_to
        WHERE ta_ID = '${r}';
    </sql:update>
 
     <div id="deleteMessage" >
               <% 
       out.println("<script type=\"text/javascript\">");
       out.println("alert('.تم حذف المهمة بنجاح');");
       out.println("</script>");
            %>    
          <table border="1" width="100%">
              <tr>
                  <th align="center"><h3>مهمة</h3></th>
                  <th align="center"><h3>الحالة</h3></th>
                  <th align="center"><h3>تاريخ التأسيس</h3></th>
              </tr>
                        <sql:query var="rs" dataSource="jdbc/madad">
                              SELECT * FROM task;
                          </sql:query>  

                     <c:choose>    
                              <c:when test="${rs.rowCount == 0}">   <!--  this print mean "nothing" -->
                                  <%

                                     out.print("لا يوجد");     
                                  %>
                              </c:when>
                      <c:when test="${rs.rowCount > 0}">
                          <c:forEach var="row" items="${rs.rows}">
                              <tr>
                                  <td>
                           <input type="hidden" id="task${row.ta_ID}" value="${row.Description}"/>
                           <input type="radio" id="taskID" name="taskID" onclick="loadDescription(this.value)" value="${row.ta_ID}">${row.Task_Name}<br>
                                  </td>
                                  <td>${row.status}</td>
                                  <td>${row.Date}</td>
                              </tr>
                          </c:forEach>
                      </c:when>
                          </c:choose>
          </table>
                  </div>
        </body>
</html>