<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : compareReadability
    Author     : Deema Alnuhait
    in this page the annotator will be able to do the readability annotation (comparing). two texts will be shown and the comparison will be based on predefined norms that the manger declared in create anotation task
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
   userID = "12";
   
   %>
<!DOCTYPE html>

<html>
    <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>تقييم مقروئية النص(مقارنة)</title>
        <link rel="stylesheet" href="css.css">
        <style>
             #buttons{ 
            display: block;
             max-width: auto;
             min-width: auto;
             margin: 90px auto auto auto;
             padding: 10px 20px;
             border-radius: 8px;
             position: relative;
             max-height: auto;
           }
          h1  
           {
	-webkit-border-radius: 20px 20px 0 0;
	-moz-border-radius: 20px 20px 0 0;
	border-radius: 20px 20px 0 0;
           }
            iframe{ 
  background: #f4f7f8;
  border-radius: 8px;
  position: relative;
           }
            button {  
	background-color: #33cc77;
	color: #fff;
	display: block;
	margin: 0 auto;
	padding: 4px 0;
	width: 100px;
}
           </style>
 
    </head>
    <body>
        <div id="wrapper">
          <div id="header">
      <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">

  		<ul class="nav">
  			<li>
  				<a href="logout.jsp">تسجيل الخروج</a>
  			</li>
                        <li>
  				<a href="index.jsp">الرئيسية</a>
  			</li>
  		</ul>
   <header style="margin-top: 10px;">
          <label style="font-size:30pt; font-weight: bold;">Arabic annotation tool</label><br><br>
            <label style="font-size:20pt; ">(تحشية المدونات العربية)</label>
    </header>
  </div>
            
            
            
             <div id="wrapper">
   <div id="header">
      <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">

  		<ul class="nav">
  			<li>
  				<a href="logout.jsp">تسجيل الخروج</a>
  			</li>
                        <li>
  				<a href="index.jsp">الرئيسية</a>
  			</li>
  		</ul>
   <header style="margin-top: 10px;">
          <label style="font-size:30pt; font-weight: bold;">Arabic annotation tool</label><br><br>
            <label style="font-size:20pt; ">(تحشية المدونات العربية)</label>
    </header>
  </div>
             <form method="post" action="nextDocCompare.jsp" name="form_list">
       <%  String index ="";
           String D_ID="";
           String state = "";
           String D_Name  = "";
           String T_ID = request.getParameter("ID");
          T_ID ="55";
    %>
    <sql:query var="rs1" dataSource="jdbc/madad">
        SELECT * 
        FROM task,dataset,annotation_style,comparison_mode 
        WHERE task.T_ID='<%=T_ID%>' AND annotation_style.T_ID='<%=T_ID%>'  AND annotation_style.D_ID = dataset.D_ID AND comparison_mode.A_ID=annotation_style.A_ID;  
    </sql:query>
        <c:choose>
                    <c:when test="${rs1.rowCount == 0}">
                        <%
                          out.print("لا توجد مهمة لعرضها");   
                        %>
                    </c:when>
            <c:when test="rs1.rowCount > 0">
                <c:forEach var="row" items="${rs1.rows}">
                     <c:set var="D_Name" value="${row.dataset.name}"/>
                   <c:set var="D_ID" value="${row.dataset.D_ID}"/>
                   <sql:query var="rsr" dataSource="jdbc/madad">
                       SELECT * 
                       FROM dataset 
                       ORDER BY D_ID ASC;
                   </sql:query>
     <c:set var="numr" value="${rsr.rows}"/> 
     <c:choose>
         
     <c:when test="${numr <= 1}">
         <%
           state =    "empty"; 
         %>
     </c:when>
     <c:otherwise>
         <sql:query var="rs2" dataSource="jdbc/madad">
             select * from dataset where D_ID NOT IN 
             ( SELECT DS_ID from compare_to 
             where DP_ID = ‘<%=D_ID%>’ 
             AND T_ID = ‘<%=T_ID%>’  
             AND U_ID =’<%=userID%>’)
             AND D_ID <> ‘<%=D_ID%>’ 
             order by D_ID asc;    
         </sql:query>
             <c:choose>
                    <c:when test="${rs2.rowCount == 0}">
                        <%
                          state = "done"; 
                        %>
                    </c:when>
            <c:when test="rs2.rowCount > 0">
                <c:forEach var="row1" items="${rs2.rows}">
                        <c:set var="index" value="${rs2.D_ID}"/> 
                </c:forEach>
            </c:when>
             </c:choose>
     </c:otherwise>
     </c:choose>
                </c:forEach>
                   
       <h1>
            <c:out value="${row.task.Task_Name}"/>
       </h1>
       <fieldset>
              <h2>

                 <c:out value="${D_Name}"/>
              </h2>
                  <iframe src="datasetArea.jsp?ID=${D_ID}"   >
        </iframe>
        <br>
         <br> <br>
                 <%
        if(state.equals("done"))
        {
        %>
        <label>
            تم إنهاء المقارنة بجميع النصوص الموجودة في قاعدة البيانات
             </label>
        
        <%
        }
        else
        {   %>
        <label>
           :الرجاء اختيار معيار المقارنة المناسب بين النصين
           <br>
           مع ملاحظة أن اتجاه المقارنة يكون من النص الأعلى للأسفل
        </label>
         <br>
            <input type="hidden" name="DP_ID" value="${D_ID}">
            <input type="hidden" name="ID" value="<%=T_ID%>">
            <input type="hidden" name="DS_ID" value="${index}">
             <select name="value" style="max-width: 250px">
                 <c:if test="rs1.rowCount > 0">
                 <c:forEach var="row" items="${rs1.rows}">           
          <option value='${row.comparison_mode.value}'>
                <c:out value="${comparison_mode.value}"/>
                </option>
                 </c:forEach>
                 </c:if>
             </select>
&nbsp; &nbsp; 
<iframe src="datasetArea.jsp?state=<%=state%>&ID='${index}'">
        </iframe>
        <%
        }
        %>
        <div id="buttons">
              <a style="text-decoration: none;" href ="javascript:history.back()" target="_top" ><button style="display: inline" type="button">خروج</button></a>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
              &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp;&nbsp;
              <%
        
              if(!(state.equals("done")||state.equals("empty")))
              {
              %>
             <a href="#" style="text-decoration: none;" onclick="document.form_list.submit();" ><button style="display: inline" type="button">النص التالي</button></a>
        <%
                  }
        %>    
        </div>
         <script>
           $('[name="form_list"]').change(function() {
  $(this).closest('form').submit();
});

</script>
    
     
</fieldset>
        </c:when>
        </c:choose>
             </form>     
    <div id="footer" style="bottom: 0px;">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
  </body>
</html>
