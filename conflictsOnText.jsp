<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%@page import="org.iwan.madad.utils.Dataset"%>

<%-- 
    Document   : Annotate Text
    Author     : Giridharan Planisamy
    this page enables the annotator to do the schema oriented annotation. 
    Email: apgiridharan@gmail.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="confilictValues">
    <%
        int tokenID=Integer.parseInt(request.getParameter("tokenID").toString());
    %>
   <sql:query var="rs" dataSource="jdbc/madad">
       SELECT annotator.Name,annotation_value.Value FROM annotate_token,tokens,annotator,annotation_value 
       WHERE annotate_token.T_ID=tokens.T_ID and annotation_value.AV_ID=annotate_token.AV_ID and
       annotate_token.A_ID=annotator.A_ID and annotate_token.T_ID=<%=tokenID%>;
    </sql:query>
   <table BORDER=2 width="400">
       <tr>
           <th>اسم الحواشي</th>
           <th>القيمة</th>
       </tr>
       <c:if test="${rs.rowCount > 0}">
           <c:forEach var="row" items="${rs.rows}">
               <tr>
                   <td>${row.Name}</td>
                   <td>${row.value}</td>
               </tr>
           </c:forEach>
       </c:if>
   </table> 
</div>