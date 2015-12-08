<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : directAssigning
    Author     : Deema Alnuhait
    this page enables the annotator to do the readability mode annotation (direct assigning part). 
    Email: deemaazizn@outlook.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
       <!-- this Arabic word means readability assesment using direct value -->
        <title>تقييم مقروئية النص (مطلق)</title>
        <link rel="stylesheet" href="css.css">
        <style>
             #buttons{
            display: block;
           // top: 150px;
             max-width: auto;
             min-width: auto;
             margin: 90px auto auto auto;
             padding: 10px 20px;
             border-radius: 8px;
             position: relative;
             max-height: auto;
           }
           #textareas h1 
           {
         background-color: #33cc77;
	-webkit-border-radius: 20px 20px 0 0;
	-moz-border-radius: 20px 20px 0 0;
	border-radius: 20px 20px 0 0;
	color: #fff;
	font-size: 28px;
	/*padding: 20px 26px;*/  
           }
            iframe{
         padding: 10px 20px;
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
      .slider-width100
{
    width: 180px !important;
}
           </style>
    </head>
    <body>
         <div id="wrapper">
  <div id="header">
      <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">

  		<ul class="nav"> <!-- this Arabic word means logout -->
  				<a href="logout.jsp">تسجيل الخروج</a>
  			</li>
                        <li> <!-- this Arabic word means main page -->
  				<a href="index.jsp">الرئيسية</a>
  			</li>
  		</ul>
   <header style="margin-top: 10px;">
          <label style="font-size:30pt; font-weight: bold;">Arabic annotation tool</label><br><br>
            <label style="font-size:20pt; ">(تحشية المدونات العربية)</label>
    </header>
  </div>
   <% 
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
    request.setCharacterEncoding("UTF8");
    String T_ID = request.getParameter("ID");
     String state = request.getParameter("state");
if(state != null && state.equals("done"))
{%>
<script> // this alert means "has been assigned"
     alert("تم الإسناد");
     </script>
     <%
     response.setHeader("Refresh", "0; URL=index.jsp");
}
else 
{ 
      %>
      <!-- retrieving all the related direct assigning task info. -->
      <sql:query var="rs" dataSource="jdbc/madad">
          SELECT directAssigningFrom,directAssigningTo,Task_Name, dataset.name as dname, dataset.D_ID
          FROM task,dataset,annotation_style 
          WHERE task.T_ID='<%=T_ID%>' 
          AND annotation_style.T_ID='<%=T_ID%>' 
          AND annotation_style.D_ID = dataset.D_ID;
      </sql:query>  
          
           <c:choose>    
                    <c:when test="${rs.rowCount == 0}">   <!--  this print mean "nothing" -->
                        <%
                        
                           out.print("لا يوجد");     
                        %>
                    </c:when>
            <c:when test="${rs.rowCount > 0}">
                <c:forEach var="row" items="${rs.rows}">                   
                 <c:set var="from" value = "${row.directAssigningFrom}" />
                 <c:set var="to" value = "${row.directAssigningTo}" />
                 <c:set var="D_Name" value = "${row.name}" />
                 <c:set var="D_ID" value = "${row.D_ID}" />
                 <c:set var="tname" value = "${row.Task_Name}" />
                </c:forEach>
            </c:when>
                </c:choose>

      <form method="post" action="directAssigningDB.jsp" name="form_list">
           <input type="hidden" name="TT_ID" value="<%=T_ID%>">
           <input type="hidden" name="D_ID" value="${D_ID}">
          
       <h1>
            <c:out value='${tname}'/>
       </h1>
              <h2>
                   <c:out value='${D_Name}'/> 
              </h2>
              
                  <iframe src="datasetArea.jsp?ID=${D_ID}" >
        </iframe>
          <br>  <br>  <br>
          
        <label> 
            <!--  this label mean " please choose the assigned value for the given text." -->
         الرجاء اختيار القيمة المطلقة المناسبة لهذه النص
        </label>
                 <script>
                     var input = document.getElementById("slider-1");
                     input.min = "${from}"; 
                     input.max = "${to}"; 
                 </script>
                 <input class ="slider-width100" name="slider-1" id="slider-1" value="50" type="range" onchange="printValue('slider-1','rangeValue3');">
  <br> 

  <span>
      <c:out value='${from}'/>
      </span>
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <span>
     <c:set var="mid" value="${(from+to)/2}" />
     <fmt:formatNumber type="number" 
            maxFractionDigits="0" value="${mid}" />
     </span>
  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
  <span>
    
      <c:out value="${to}" />
      </span>
  <br>
  <span>
      صعب
      </span>
  &nbsp; &nbsp; &nbsp; 
  <span>
      متوسط
      </span>
  &nbsp; &nbsp; &nbsp; &nbsp; 
  <span>
      سهل
      </span>
  <br>  <br>  <br> <br> 
<label>لقد اخترت</label>
  <input id="rangeValue3" type="text" size="5" style="display: inline" readonly/>
  <script>
// this script to handle the displayed value for the user & calculate the average. 
    function printValue(sliderID, textbox) {
        var input = document.getElementById("slider-1");
                     input.min = "${from}"; 
                     input.max = "${to}"; 
                    var x = document.getElementById(textbox);
                    var y = document.getElementById(sliderID);
                    x.value = y.value;
                }
                </script>
        <div id="buttons">
<!--             the button means  "quit" -->
     <a style="text-decoration: none;" href ="javascript:history.back()" target="_top" ><button style="display: inline" type="button">خروج</button></a>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
              &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp;&nbsp;
              <!--             the button means  "quit" -->
             <a href="#" style="text-decoration: none;" onclick="document.form_list.submit();" ><button style="display: inline" type="button">إسناد</button></a>
               &nbsp;  &nbsp; &nbsp;
             <!--<a href="#" onclick="//document.formName.submit();">-->
             </div>
       
<script>
           $('[name="form_list"]').change(function() {
  $(this).closest('form').submit();
});
</script>
</form>
                <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
    </body>
</html>
<%}%>

 
        
   
           