<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this is the home page for annotators. it contains their info and the functions they can do--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
     String type = (String)session.getAttribute("type");
   session.setAttribute("type",type);
   %>
<html> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="newcss.css">
 <style>   button[type="button"] {
	background-color: #33cc77;
	color: #fff;
	display: block;
	margin: 0 auto;
	padding: 4px 0;
	width: 150px;
        font-size: 16px;
        font-style: bold;
    }
        
        #login h2 {
	background-color: #33cc77;
	-webkit-border-radius: 20px 20px 0 0;
	-moz-border-radius: 20px 20px 0 0;
	border-radius: 20px 20px 0 0;
	color: #fff;
	font-size: 24px;
	padding: 16px 21px;
        margin-bottom: 0px;
}</style>
    </head>
 
     <body>
     <div id="wrapper">
  <div id="header"> 

<img src="madad.png" alt="logo" width="122" height="120" style="float:right; right:0px; top:0px;">
        <h1>
          <label style="font-size:30pt; font-weight: bold;">(Arabic annotation tool)</label><br><br>
          <label style="font-size:20pt; ">(أداة مدد لتحشية المدونات العربية) </label>
        </h1>
     <h1>&nbsp;</h1>

  </div>
         <div id="login">
             <label> <!-- the arabic label  means hi-->
 مرحباً
<%=userID%></label>
            <h2 style="text-align: right;"><span class="fontawesome-lock"></span>الرئيسية</h2>
<form method="post" action="#">
			<fieldset style="text-align: right; text-align: center;">
                            <a href="edit.jsp">تعديل الملف الشخصي</a><br><br> <!-- modify your profile-->
                            <a href="annotate.jsp">تحشية النصوص</a><br><br> <!-- annotate the text-->
                            <a href="contactWithManager.jsp">تواصل مع مدير المهمة</a><br><br> <!-- contact the task manager-->
                            <a href="viewAssignedTasks.jsp">المهام المسندة</a><br><br><!-- assigned task-->
                            <a href="viewAvailableTasks.jsp">المهام المتاحة</a><br> <!-- available tasks-->
			</fieldset>
		</form>
</div>

<div id="footer">
<small>Copyright by KSU &copy2015. All rights reserved.</small>
</div>
     </div>
    </body>
</html>
