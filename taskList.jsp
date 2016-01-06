<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="org.iwan.madad.utils.*"%>
<%-- 
    Document   : relatedTasks
    Created on : Jan 4, 2016, 12:07:47 PM
    Author     : Giri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
           <script>
               function loadDescription(taskID)
               {
                   var descriptionID="task"+taskID;
                   var description=document.getElementById(descriptionID).value;
                   document.getElementById("description").value=description;
               }
               
               function deleteTask()
               {
                   var taskID=getRadioVal(document.getElementById('form_list'),'taskID');
                   if(confirm("Are you sure do you want to delete this task?"))
                   {
                  var xmlhttp;
			document.getElementById("deleteMessage").innerHTML = "";
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("deleteMessage").innerHTML = xmlhttp.responseText;
			}
			}
			xmlhttp.open("GET", "deleteTask.jsp?taskID="+taskID, true);
			xmlhttp.send();
                    }
               }
               
               function getRadioVal(form, name) {
                            var val;
                            // get list of radio buttons with specified name
                            var radios = form.elements[name];

                            // loop through list of radio buttons
                            for (var i=0, len=radios.length; i<len; i++) {
                                if ( radios[i].checked ) { // radio checked?
                                    val = radios[i].value; // if so, hold its value in val
                                    break; // and break out of for loop
                                }
                            }
                            return val; // return value of checked radio or undefined if none checked
                        }
           </script>
    </head>
    <body>
       <div id="wrapper">
  <div id="header">
      <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">

  		<ul class="nav"> <!-- this Arabic word means logout -->
                        <li>
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

      <form method="post" action="relatedTasks.jsp" name="form_list" id="form_list">
          
       <h1>
        قائمة المهام
       </h1>
        
          <div align="center">
              <div id="deleteMessage" >
                  
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
              <br>
              <h2 align="right">الوصف</h2>
              <div align="right">
                   <textarea id="description" style="min-height:100px;"></textarea>
              </div> 
          </div>
          <div id="buttons">
                <button style="width:100%" onclick="deleteTask();" type="button">تصدير المشروح الإحضار</button>
             </div>
</form>
                <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
    </body> 
</html>
