<%-- 
    
Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this page allows the admin to create new users whith only given name,password, and type--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
      session.setAttribute("type","admin");

   %>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>إنشاء مستخدم جديد</title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="css.css">
        <script type="text/javascript">
function showExtra(){
    if(document.getElementById("task_manager").checked){
    document.getElementById("extra").style.display = "block";}
    else{
    document.getElementById("extra").style.display = "none";  
    }
}
function other(){
   if (document.getElementByName("user_age").value == "greater"){
    document.getElementById("other").style.display = "block";}
   }
function loadXMLDoc()
{
var xmlhttp;
var k=document.getElementById("name").value;
var urls="checkusername.jsp?ver="+k;

if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
        document.getElementById("msg").innerHTML=xmlhttp.responseText;
     }
  }
xmlhttp.open("GET",urls,true);
xmlhttp.send();
}
</script>
    </head>
 
     <body>
       <div id="wrapper">
  <div id="header">
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
            <label style="font-size:20pt; ">(أداة مدد لتحشية المدونات العربية)</label>
    </header>
  </div>
      <form action="registration.jsp" method="post">
      
        <h1>التسجيل</h1>
          <fieldset>
          <legend>معلوماتك الأساسية  <span class="number">1</span></legend>
          <label for="name">الاسم</label>
          <input type="text" id="name" name="user_name" onkeyup="loadXMLDoc()" required>
          <span id="msg"> </span>

          
          <label for="mail">الإيميل</label>
          <input type="email" id="mail" name="user_email"  >
          
          <label for="password">كلمة المرور    </label>
          <input type="password" id="password" name="user_password" required>
          
         <label>العمر</label>
         <select  dir="rtl" id="age_range" name="user_age" >
        
            <option value="7-12" >7-12</option>
            <option value="13-15">13-15</option>
            <option value="16-18">16-18</option>
            <option value="19-22">19-22</option>
            <option value="23-30">23-30</option>
            <option value="31-40">31-40</option>
            <option value="41-50">41-50</option>
            <option id="greater" value="greater" onclick="other()" >أكبر من 50</option>
        </select>
         <input type="text" style="display:none;" id="other" name="user_age" >
        </fieldset>
        
        <fieldset>
          <legend>ملفك الشخصي<span class="number">2</span> </legend>
          <label for="language">اللغة الأم</label>
          <input type="text" id="language" name="user_language" >
          
        <label for="edu_level">المستوى التعليمي</label>
        <select dir="rtl" id="level" name="user_edu_level" >
            <option value="Phd">دكتوراه</option>
            <option value="Master">ماجستير</option>
            <option value="bachalar">جامعي</option>
            <option value="High_Scool">ثاناوي</option>
            <option value="Middle_School">متوسط</option>
        </select>

        
        
        <label>نوع المستخدم</label>
         <label for="annotator" class="light">Annotator</label> 
         <input type="radio" onclick="showExtra()" id="annotator" value="annotator" name="user_type"><br>
         <label for="task_manager" class="light">Task Manager</label> 
         <input type="radio" onclick="showExtra()" id="task_manager" value="task_manager" name="user_type">
        <br>
        <!--extra fields for task manager-->
        <div id="extra" style="display: none;">
        <label for="institution">الجهة</label>
        <input type="text" id="Institution" name="Institution">
          
        <label for="Occupation">المهنة</label>
        <input type="text" id="Occupation" name="Occupation">
        
        </div>
        
              </fieldset>
                  <button formnovalidate="formnovalidate" type="submit">إنشاء</button>

      </form>

        <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
     </div>
    </body>
</html>