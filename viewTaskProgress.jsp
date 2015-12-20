<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : viewTaskProgress
    Author     : Deema Alnuhait
    this page enables the Task manager to view the progress of the task, monthly.
    Email: deemaazizn@outlook.com. --%>

<%@page import="java.util.Date" %>  
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>معاينة التقدم لمهمة مسندة </title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="css.css">
        <script src="Chart.js"></script>
          <link rel="stylesheet" href="normalize.css" >
          
        	<link rel="stylesheet" href="component.css">
<script>
           $('[name="form_list"]').change(function() {
  $(this).closest('form').submit();
});
</script>
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
     
            <form action="viewTaskProgress.jsp" name="form_list" id="form_list"  method="post" >
              <label for="tasks_list">اسم المهمة</label>  
              <sql:query var="rs" dataSource="jdbc/madad">
                  SELECT * FROM task;
              </sql:query>
 <!-- displaying the list of tasks that the user should choose one of them.-->
<select id="tasks_list" onchange="this.form.submit()" name="tasks_list">
    <c:choose>
        
          <c:when test="${rs.rowCount == 0}">                  
                                      
    <option value=" <%="empty"%>" disabled="disabled"> <%out.print("لا توجد مهام مسندة"); %></option> 
          </c:when>
          <c:when test="${rs.rowCount > 0}" >
       <option value=" <%="NoThing"%>"> <%out.print("------"); %></option> 
        <c:forEach var="rss" items="${rs.rows}">
             <option value="${rss.T_ID}">
 <c:out value="${rss.Task_Name}"/>
     </option>
        </c:forEach>
    </c:when>   
    </c:choose>
                            </select>  
            </form>
         <%
String content = request.getParameter("tasks_list");
if (content == null || content.length() == 0 || content.equals("NoThing"))
{
// myText is null when the page is first requested, 
// so do nothing
} else 
{ %>
<form  name="statistics" id="statistics"  >
    
<!-- retrieving the selected task info. -->
    <sql:query var="tasks" dataSource="jdbc/madad">
        SELECT *
        FROM task 
        WHERE T_ID= '<%=content%>';
    </sql:query> 
    <c:choose>
         <c:when test="${tasks.rowCount > 0}" >
        <c:forEach var="rtasks" items="${tasks.rows}">
     <h1>إحصائيات المهمة 
         <c:out value="${rtasks.Task_Name}"/>
     </c:forEach>
     </c:when>
         </c:choose>
         </h1>
<!-- retrieving the annotators' info who assigned to the selected task. -->
         <sql:query var="rsrs" dataSource="jdbc/madad">
             SELECT * 
             FROM assigned_to,annotator,task 
             WHERE annotator.U_ID = assigned_to.U_ID 
             AND assigned_to.T_ID = '<%=content%>' 
             AND task.T_ID='<%=content%>' ;
         </sql:query>
		<span>
                    <a href="viewAssignedAnnotators.jsp?T_ID=<%=content%>">   عدد المرمزين الذين تم إسنادهم
     </a>               </span>
     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
     <c:if test="rsrs.roeCount > 0 ">
         <c:forEach var="rsrsr" items="${rsrs.rows}">
     <c:out value="${rsrsr.status}"/>
     </c:forEach>
     </c:if>
     <c:set var="noaig" value="rsrs.rowCount"/>
     <c:out value="${noaig}"/>
     
     <br><br>
     <span>
                    <a href="viewAssignedAnnotators.jsp?T_ID=<%=content%>">عدد المرمزين الحاليين</a>               </span>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

     <br><br>
     <span>
          نسبة النص المرمز للنص الغير مرمز 
         </span>
     <br><br>
      <span>
          تاريخ بدء العمل
         </span>
     <br><br>
       <span>
           تاريخ انتهاء العمل 
         </span>
     
     
      <br><br> <br><br>
     
    
    <span style="float: right">
	أعمار المرمزين 
        </span>
    <br>
            <span id="canvas-holder">
			<canvas id="chart-area" width="170" height="170"/>
			</span>
    <br>
    <br>
    
    <span style="float: right">
	مستوى المرمزين التعليمي
        </span>
    <br>
    <span id="canvas-holder1">
			<canvas id="chart-area1" width="170" height="170"/>
			</span>
    <br>
    <br>
    
    <span style="float: right">
	لغة المرمزين الأم
        </span>
    <br>
    <span id="canvas-holder2" >
			<canvas id="chart-area2" width="170" height="170"/>
			</span>
    
    
     <% 
     String age1 = "7-12";
    int age1c =0;
    String age2 = "13-15";
    int age2c =0;
    String age3 = "16-18";
    int age3c =0;
    String age4 = "19-22";
    int age4c =0;
    String age5 = "23-30";
    int age5c =0;
    String age6 = "31-40";
    int age6c =0;
    String age7 = "41-50";
    int age7c =0;
    int age8c = 0;
    String edu1 = "elementary";
    int edu1c =0;
    String edu2 = "intermediate";
    int edu2c =0;
    String edu3 = "secondary";
    int edu3c =0;
    String edu4 = "bachelor ";
    int edu4c =0;
    int edu5c =0;
    String lang1 = "Arabic";
    int lang1c =0;
    String lang2 = "English";
    int lang2c =0;
    int lang3c =0; 
    String str4; 
    String lang="";%>
    <sql:query var="rssr" dataSource="jdbc/madad">
        SELECT * 
        FROM task,assigned_to,annotator 
        WHERE task.T_ID = '<%=content%>'  
        AND assigned_to.U_ID = annotator.U_ID 
        AND assigned_to.T_ID = '<%=content%>'  ;
    </sql:query>  
<c:if test="${rssr.rowCount > 0}" >
  <c:forEach var="rssrr" items="${rssr.rows}">
      <c:set var="age" value="${rssrr.Age}" />
  </c:forEach>
</c:if>
<%
                                if(age.equals(age1))
                                {age1c++;}
                                else  if(age.equals(age2))
                                {age2c++;}
                                else  if(age.equals(age3))
                                {age3c++;
                                }
                                else  if(age.equals(age4))
                                {
                                    age4c++;
                                }
                                else  if(age.equals(age5))
                                {
                                    age5c++;
                                }
                                else  if(age.equals(age6))
                                {
                                    age6c++;
                                }
                                else  if(age.equals(age7))
                                {
                                    age7c++;
                                }
                                else
                                {
                                age8c++;
                                }
                                String edu = rs3.getString("Education_Level");
                                
                               //out.print(edu);
                                
                                if(edu.equals(edu1))
                                {
                                    edu1c++;
                                }
                                else 
                                   if(edu.equals(edu2))
                                            { 
                                                edu2c++;
                                            }
                                   else 
                                       if(edu.equals(edu3))
                                       { 
                                           edu3c++;
                                       }
                                else 
                                      if(edu.equals(edu4))
                                {
                                    //out.print("دخل");
                                    edu4c++;
                                }
                                else {
                                               if(edu.equals("bachelor"))
                                                   edu4c++;
                                               else
                                    edu5c++ ;
                                   // out.print(edu5c);
                                }
                                 lang = rs3.getString("Native_Language");
                              // out.print(lang);
                                if(lang.equals(lang1))
                                {
                                    lang1c++;
                                }
                                else 
                                    if(lang.equals(lang2))
                                    {
                                        lang2c++;
                                    }
                                else{
                                        lang3c++;
                                }
                                }
                               rs3.close();
                                myStatement3.close();
                                con3.close();
								
								
        
     
     
</form>  
            
}
%>            
            
        <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
        </div>
    </body>
</html>
