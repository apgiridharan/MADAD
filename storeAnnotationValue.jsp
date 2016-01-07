<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : storeAnnotationValue
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
                        SELECT T_ID FROM tokens WHERE value='﻿<%=text%>';
        </sql:query> 
           
        <c:if test="${rs.rowCount > 0}">
            <c:forEach items="${rs.rows}" var="row">
                <sql:query var="rs1" dataSource="jdbc/madad">
                            SELECT * FROM annotate_token WHERE T_ID='${row.T_ID}' and A_ID='<%=userID%>';
                </sql:query>
            
                <c:if test="${rs1.rowCount > 0}">
                    
                                <sql:update var="rs2" dataSource="jdbc/madad">
                                    UPDATE annotate_token SET AV_ID='<%=value%>' 
                                    WHERE T_ID='${row.T_ID}' and A_ID='﻿<%=userID%>';
                                </sql:update>
                   
                </c:if>
                <c:if test="${rs1.rowCount == 0}">
                                <sql:update var="rs2" dataSource="jdbc/madad">
                                    INSERT INTO annotate_token
                                    (`A_ID`,`T_ID`,`AV_ID`)
                                    VALUES
                                    ('<%=userID%>','${row.T_ID}','<%=value%>');
                                </sql:update>
                </c:if>
            </c:forEach>
         </c:if>
    </body>
</html>
