<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
 Document   : datasetArea
 Author     : Deema Alnuhait
 this page displays the corpus to be used in other readability annotation pages.  
 Email: deemaazizn@outlook.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%   request.setCharacterEncoding("UTF-8");
            String id=request.getParameter("ID");

            String state = request.getParameter("state");
            if(state != null && (state.equals("empty")))
              {
                  //          means there is no other text to compare with 
                      out.print("لا توجد نصوص أخرى لمقارنتها");
                  
              }
              else {
        %>
<sql:query var="rs" dataSource="jdbc/madad">
 select * from dataset where D_ID = '<%=id%>';
</sql:query> 
 <c:choose>
        <c:when test="${rs.rowCount > 0}">
            <c:forEach var="row" items="${rs.rows}">
                <%
                  try {
                Blob file = null;
                 byte[ ] fileData = null ;
                 DataSource ds = (DataSource) new InitialContext().lookup("jdbc/madad");
             Connection con = ds.getConnection(); 
                  String sql =  "select * from dataset where D_ID = "+id;
               Statement myStatement = con.createStatement();
                ResultSet rs=myStatement.executeQuery(sql);
                rs.next();
                file = rs.getBlob("content");
                    InputStream is = file.getBinaryStream();
                      fileData = file.getBytes(1,(int)file.length());
                              response.setContentLength(fileData.length);
                String ff = new String (fileData,StandardCharsets.UTF_8);
                %>
                <label dir="rtl" width="100%">
                                <%
 out.print(ff);
 %>
     

                </label>

 <%
                  }
                  catch(NullPointerException ex)
                  {
                      out.print("catch");
                  }
                %>
            </c:forEach>
        </c:when>
            <c:when test='${rs.rowCount == 0}'>
                <% //          means there is no other text to compare with 
                out.println("لا يوجد نص للعرض");
                %>
            </c:when>
          </c:choose>
<%
            }      
%>
    </body>
</html>