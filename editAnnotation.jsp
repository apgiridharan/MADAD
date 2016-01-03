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
    Document   : edit Annotation
    Author     : Giridharan Planisamy 
    Email: apgiridharan@gmail.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


    <%
        int tokenID=Integer.parseInt(request.getParameter("tokenID").toString());
        int valueID=Integer.parseInt(request.getParameter("annotationValue").toString());
        if(request.getParameter("annotatorID")!=null)
        {
           int annotatorID=Integer.parseInt(request.getParameter("annotatorID").toString()); 
           %>
           <div id="tokenDiv<%=tokenID%>">
                <sql:update var="rs" dataSource="jdbc/madad">
                    UPDATE annotate_token SET AV_ID=<%=valueID%>
                    WHERE T_ID=<%=tokenID%> and A_ID=<%=annotatorID%>;
                 </sql:update>
                <c:choose>
                    <c:when test="${rs>0}" >
                        <span style="font-family: wingdings; font-size: 200%; color:green;">&#10004;</span>
                    </c:when>
                    <c:otherwise>
                        <span style="font-family: wingdings; font-size: 200%; color:red;">&#10006;</span>
                    </c:otherwise>
                </c:choose>
           </div>
           <%
        }
        else
       {
    %>
    <div id="editMessage">
   <sql:update var="rs" dataSource="jdbc/madad">
       UPDATE annotate_token SET AV_ID=<%=valueID%>
       WHERE T_ID=<%=tokenID%>;
    </sql:update>
       <c:choose>
           <c:when test="${rs>0}" >
               <span style="font-family: wingdings; font-size: 200%; color:green;">&#10004;</span>
           </c:when>
           <c:otherwise>
               <span style="font-family: wingdings; font-size: 200%; color:red;">&#10006;</span>
           </c:otherwise>
       </c:choose>
</div>
<%}%>