<%@page import="java.util.ArrayList"%>
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
<%@page import="org.iwan.madad.utils.*"%>

<%-- 
    Document   : Annotate Text
    Author     : Giridharan Planisamy
    this page enables the annotator to do the schema oriented annotation. 
    Email: apgiridharan@gmail.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="annotationSet">
    <%
        Dataset data=(Dataset)session.getAttribute("dataset");
        int currentFileID=data.getCurrentFileID();
        int userID=Integer.parseInt(request.getParameter("annotatorID").toString());
        Schema schema=new Schema();
        ArrayList<Schema> list=schema.getSchemaList();
        int listSize=list.size();
    %>
   <sql:query var="rs" dataSource="jdbc/madad">
       SELECT annotator.Name,annotation_value.Value,tokens.value,tokens.T_ID FROM annotate_token,tokens,annotator,annotation_value 
       WHERE annotate_token.T_ID=tokens.T_ID and annotation_value.AV_ID=annotate_token.AV_ID and
       annotate_token.A_ID=annotator.A_ID and tokens.f_ID=<%=currentFileID%> and annotate_token.A_ID=<%=userID%>;
    </sql:query>
   <table BORDER=2 width="400" align="center">
       <tr>
           <th>نص</th>
           <th>القيمة</th>
           <th colspan="2">تحرير</th>
       </tr>
       <c:if test="${rs.rowCount > 0}">
           <c:forEach var="row" items="${rs.rows}">
               <tr>
                   <th>${row.value}</th>
                   <th>${row.Value}</th>
                   <td>
                       <div width="80%">
                         <select onchange="editAnnotationSet(${row.T_ID},this.value);">
                                    <option value="">change value</option>
                           <%
                            for(int i=0;i<listSize;i++)
                            {
                                Schema schema1=new Schema();
                                schema1=list.get(i);
                                %>
                                <option value="<%=schema1.getId()%>"><%=schema1.getValue()%></option>
                                 <%   
                            }
                            %>
                         </select>
                         </div>   
                   </td>
                   <td>
                    <div id="tokenDiv${row.T_ID}">
                    </div></td>
                   
               </tr>
           </c:forEach>
       </c:if>
   </table> 
</div>