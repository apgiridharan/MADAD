<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this is the index(home) page where the user can either login / register to the system
Note: as for  Admin registeration I assumed the admin will add her/his info directly to the database and then log in as any other user.
--%>
<%@page import="java.util.Date" %>  
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MADAD</title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="newcss.css">
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
<img src="madad.png" alt="logo" width="122" height="120" style="float:right; right:0px; top:0px;">
        <h1>
          <label style="font-size:30pt; font-weight: bold;">(Arabic annotation tool)</label><br><br>
          <label style="font-size:20pt; "> (أداة مدد لتحشية المدونات العربية)</label>
        </h1>
     <h1>&nbsp;</h1>
   </div>
	<div id="login">

            <h2 style="text-align: right;"><span class="fontawesome-lock"></span>تسجيل الدخول</h2>


		<form method="post" action="login.jsp">

			<fieldset style="text-align: right;">

                            <p><label  for="uname">اسم المستخدم</label></p>
				<p><input  name="uname" type="text"  value="" 
                                          onBlur="if(this.value=='')this.value=''" 
                                          onFocus="if(this.value=='')this.value=''">
                                </p> <!-- JS because of IE support; better: placeholder="mail@address.com" -->
				<p><label for="password">كلمة المرور</label></p>
				<p><input name="pass" type="password" id="password" value="" 
                                          onBlur="if(this.value=='')this.value='password'" 
                                          onFocus="if(this.value=='password')this.value=''">
                                </p> <!-- JS because of IE support; better: placeholder="password" -->
                                 <a href="changePassordForm.jsp">نسيت كلمة المرور؟</a>
				<p><input type="submit" value="تسجيل الدخول"></p>
                                <a href="reg.jsp">التسجيل</a>

			</fieldset>

		</form>

	</div> <!-- end login -->
        <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
        </div>
    </body>
</html>
