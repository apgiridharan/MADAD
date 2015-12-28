<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : test
    Created on : Dec 27, 2015, 1:42:24 PM
    Author     : Giri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String text=request.getParameter("selectedText");
            String value=request.getParameter("value");
            String userID=request.getParameter("userID");
            String datasetID=request.getParameter("datasetID");
        %>
        <input type="text" id="result" value="<%=text%>">
        <input type="text" id="re" value="<%=value%>">
        <input type="text" id="res" value="<%=userID%>">
        <input type="text" id="resu" value="<%=datasetID%>">
        
        <sql:query var="rs" dataSource="jdbc/madad">
                        SELECT token_ID FROM tokenized_words WHERE value='﻿<%=text%>';
        </sql:query> 
           
        <c:if test="${rs.rowCount > 0}">
            <c:forEach items="${rs.rows}" var="row">
                        <sql:update var="rs2" dataSource="jdbc/madad">
                            INSERT INTO annotate
                            (`U_ID`,`D_ID`,`Token_ID`,`Value`)
                            VALUES
                            ('<%=userID%>','<%=datasetID%>','${row.token_ID}','<%=value%>');
                        </sql:update>
            </c:forEach>
         </c:if>
    </body>
</html>
