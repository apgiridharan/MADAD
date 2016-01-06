<%-- 
    Document   : mainManager
    Author     : ِAysha Almahmood, Deema Alnuhait
    this page is the home page of the Task Manager.  
    Email: Ayshaalmahmood@gmail.com, deemaazizn@outlook.com --%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>الصفحة الرئيسية (مدير مهام)</title>
	<link rel="stylesheet" href="css.css">
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
         
         <form>          
             <%
    InitialContext ctx = new InitialContext();
    DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/madad");
    Connection conn = null;
    Statement stmt = null;
    conn = ds.getConnection();
    stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from manager where Name='"+userID+"'");
  String name = null;
  String age = null;
  String e_l =  null;
  String N_L = null;
  String instit = null;
  if(rs.next())
  {
  name = rs.getString("Name");
  age = rs.getString("Age");
  e_l =  rs.getString("Education_Level");
  N_L = rs.getString("Native_language");
  instit = rs.getString("Institution"); 
  }
             %>
             
 <label>
 مرحباً
<%=userID%></label>

<fieldset>
   <legend> معلوماتي</legend>
   <label>
الاسم:
 &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;   &nbsp;  &nbsp;   &nbsp;
     
<%=name%>
   </label>
     <label>
       العمر:
         &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;   &nbsp;  &nbsp;   &nbsp;
       <%=age%>
     </label>
     <label>
    المستوى التعليمي:
         &nbsp;  &nbsp;  
   <%=e_l%>
   </label>
    <label>
اللغة الأم:
        &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;   &nbsp;  

          <%=N_L%>
   </label>
     <label>
        الجهة:
         &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;   &nbsp;  &nbsp;   &nbsp;
  <%=instit%>
   </label>
</fieldset>

<fieldset>
   <legend> إدارة الحساب<span class="number">1</span></legend>
    <a href="#"  >تعديل الملف الشخصي</a><br>
    <a href="#"  >صندوق الوارد</a><br>


</fieldset>
<fieldset>
     <legend> إدارة مدونة<span class="number">2</span></legend>
    <a href="#"  >إنشاء مدونة جديدة</a><br>
    <a href="#"  >تصدير مدونة مرمزة</a><br>
</fieldset>
<fieldset>
     <legend> إدارة المهام<span class="number">3</span></legend>
    <a href="#"  >إنشاء مهمة جديدة</a><br>
    <a href="manageTask.jsp"  >المهام المدارة</a><br>
    <a href="assignAnnotationTask.jsp"  >تعيين مرمزين لمهمة تحشية</a><br>
    <a href="taskList.jsp">معاينة التقدم لمهمة</a><br>
    <a href="generateReport.jsp">التقرير الشهري</a><br>
    <a href="listOfDatasets.jsp">تصدير المشروح كوربوس</a><br>
</fieldset>

</form>

<div id="footer">
<small>Copyright by KSU &copy2015. All rights reserved.</small>
</div>
     </div>
    </body>
</html>
