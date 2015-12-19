<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this page allows the users to edit their information--%>
<% 
    String name = (String)session.getAttribute("userid");
    String type = (String)session.getAttribute("type");
%>

<sql:query var="result" dataSource="jdbc/madad">
select  Name , Email,Education_Level, Age, Native_Language from annotator where Name= ? 
<sql:param value="<%=name%>"/>
    </sql:query>


<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
              "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
    
    <c:when test="${type eq 'annotator'}" >
        <c:if test="${result.rowCount != 0}">
 <c:set var="Email" scope="session" value="${result.rows[0].Email}" />
 <c:set var="Education_Level" scope="session" value="${result.rows[0].Education_Level}" />
 <c:set var="Age" scope="session" value="${result.rows[0].Age}" />
 <c:set var="Native_Language" scope="session" value="${result.rows[0].Native_Language}" />

               
<%    
type = "annotator";
session.setAttribute("userid", name);
session.setAttribute("type", type);%>
</c:if>
    </c:when>
 
    <c:otherwise>
       <c:if test="${type eq 'manager'}">
              <sql:query var="result2" dataSource="jdbc/madad">
select * from manager where Name=?
<sql:param value="<%=name%>"/>
    </sql:query>


<c:if test="${result2.rowCount != 0}">
 <c:set var="Email" scope="session" value="${result2.rows[0].Email}"/>
 <c:set var="Education_Level" scope="session" value="${result2.rows[0].Education_Level}"/>
 <c:set var="Age" scope="session" value="${result2.rows[0].Age}"/>
 <c:set var="Native_Language" scope="session" value="${result2.rows[0].Native_Language}"/>
 
 </c:if>
<%type = "manager";
session.setAttribute("userid", name);
session.setAttribute("type", "manager");%>
    </c:if>  
         
    </c:otherwise>
</c:choose>

<html> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="css.css">

    </head>
 
     <body>


     <div id="wrapper">
   <div id="header">
<img src="madad.png" alt="logo" width="122" height="120" style="float:right; right:0px; top:0px;">
        <h1>
            <label style="font-size:30pt; font-weight: bold;">(Arabic annotation tool)</label><br>
          <label style="font-size:20pt;"> (أداة مدد لتحشية المدونات العربية)</label>
        </h1>
     <h1>&nbsp;</h1>
   </div>
         <div id="login" style="margin-top: 190px; ">
      <form style="margin-top: 100px;" action="update.jsp" method="post">
      
        <h1>تعديل الملف الشخصي</h1>
        
        <fieldset>
          <legend>معلوماتك الأساسية  <span class="number">1</span></legend>
          <label for="name">الاسم</label>
          <input type="text" id="name" name="user_name" value="<%=name%>" readonly>
          
          <label for="mail">الإيميل</label> 
          <input  type="email" id="mail" name="user_email" value="${Email}" >   
          
          <label for="password">كلمة المرور</label>
          <input type="password" id="password" name="user_password">
          
           <label>العمر</label>
         <select  dir="rtl" id="age_range" name="user_age" >
             <option value="7-12" >7-12</option>
            <option value="13-15">13-15</option>
            <option value="16-18">16-18</option>
            <option value="19-22">19-22</option>
            <option value="23-30">23-30</option>
            <option value="31-40">31-40</option>
            <option value="41-50">41-50</option>
            <option id="greater" value="greater">أكبر من 50</option>
        </select>
        </fieldset>
        
        <fieldset>
          <legend>ملفك الشخصي <span class="number">2</span></legend>

          <label for="language">اللغة الأم</label>
          <input type="text" id="language" name="user_language" value="${Native_Language}">
                  <label for="edu_level">المستوى التعليمي</label>

        <select id="level" name="user_edu_level">
        
              <option value="Phd">دكتوراه</option>
              <option value="Master">ماجستير</option>
            <option value="bachalar">جامعي</option>
            <option value="High_Scool">ثاناوي</option>
            <option value="Middle_School">متوسط</option>
          
        </select>

              </fieldset>
                  <button type="submit">تعديل</button>

      </form>
        </div >
        <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
     </div>
    </body>
</html>
