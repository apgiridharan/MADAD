
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%-- 
    Document   : createTask
    Author     : Deema Alnuhait
    this page enables the Task Manager to create a new annotation task. 
    Email: deemaazizn@outlook.com --%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>إنشاء مهمة جديدة</title>
        <link rel="stylesheet" href="css.css">
        <style>
            a {text-decoration: none}
        form button[type="button"] {
	background-color: #33cc77;
	color: #fff;
	display: inline;
	margin: 0 auto;
	padding: 4px 0;
	width: 100px;
        }
       form button[type="submit"] 
{
	background-color: #33cc77;
	color: #fff;
	display: inline;
	margin: 0 auto;
	padding: 4px 0;
	width: 100px;
}        
#qty {
    background: rgba(255,255,255,0.1);
  border: none;
  font-size: 16px;
  height: 10px;
  margin: 0;
  outline: 0;
  padding: 15px;
  width: 80%;
  background-color: #e8eeef;
  color: #8a97a0;
  box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
  margin-bottom: 20px;
}
    .textareaverrical
    {
        resize: vertical;
    }
    </style>
    <script>
// this script to show text fields after the user specifies how many they are. 
function showdata()
{
var val= document.getElementById("nofield").value;
document.getElementById("extranum").innerHTML="";
for(i=1;i<=val;i++)
{
   var btn = document.createElement("input");
   btn.id = i;
   btn.name = i+"";
   btn.required =true
   var str = "معيار مقارنة "+i;
   document.getElementById("extranum").appendChild(btn);
   document.getElementById("extranum").innerHTML+="   :"+str;
   document.getElementById("extranum").innerHTML+="<br>";
}	
}
// the following script to handle the appearing and disappearing of annotation options.
function myFunction1() {
    document.getElementById("upload").required = true;
    document.getElementById("compare").required = false;   
        document.getElementById("written_schema_name").required = false;
        document.getElementById("textCode").required = false;
        document.getElementById("file_uploaded").required = false;
        document.getElementById("nofield").required = false;
        document.getElementById("range_from").required = false;
        document.getElementById("range_to").required = false;     
    document.getElementById("extra2").style.display= "none";
        document.getElementById("extra3").style.display= "none";
            document.getElementById("extra4").style.display= "none";
    document.getElementById("extra1").style.display = "block";
         document.getElementById("extra5").style.display= "none";
    document.getElementById("extra6").style.display= "none";
document.f1.action = ""; }

function myFunction2() {
    document.getElementById("extra1").style.display= "none";
    document.getElementById("extra3").style.display= "none";
    document.getElementById("extra4").style.display= "none";
    document.getElementById("extra2").style.display = "block";
    document.getElementById("compare").required = true;
    document.getElementById("upload").required = false;
            document.getElementById("written_schema_name").required = false;
            document.getElementById("textCode").required = false;
        document.getElementById("file_uploaded").required = false;
        document.getElementById("nofield").required = false;
        document.getElementById("range_from").required = false;
        document.getElementById("range_to").required = false;
    document.getElementById("extra5").style.display= "none";
    document.getElementById("extra6").style.display= "none";
      document.f1.action = "createTaskDB.jsp"; 
}
function myFunction3() {
     document.getElementById("extra4").style.display= "block";
    document.getElementById("extra3").style.display= "none";
        document.getElementById("extra2").style.display= "block";
    document.getElementById("extra1").style.display= "none";
         document.getElementById("extra5").style.display= "none";
    document.getElementById("extra6").style.display= "none";
             document.getElementById("written_schema_name").required = false;
             document.getElementById("textCode").required = false;
        document.getElementById("file_uploaded").required = false;
        document.getElementById("nofield").required = false;
        document.getElementById("range_from").required = true;
        document.getElementById("range_to").required = true;
}
function myFunction4() {
    document.getElementById("extra3").style.display= "block";
    document.getElementById("extra4").style.display= "none";
    document.getElementById("extra2").style.display= "block";
    document.getElementById("extra1").style.display= "none";
        document.getElementById("extra5").style.display= "none";
    document.getElementById("extra6").style.display= "none";
             document.getElementById("written_schema_name").required = false;
             document.getElementById("textCode").required = false;
        document.getElementById("file_uploaded").required = false;
        document.getElementById("nofield").required = true;
        document.getElementById("range_from").required = false;
        document.getElementById("range_to").required = false;
}
function myFunction5() {
 
    document.getElementById("extra1").style.display= "block";
    document.getElementById("extra2").style.display= "none";
    document.getElementById("extra3").style.display= "none";
    document.getElementById("extra4").style.display= "none";
    document.getElementById("extra5").style.display= "block";
    document.getElementById("extra6").style.display= "none";
             document.getElementById("written_schema_name").required = false;
             document.getElementById("textCode").required = false;
        document.getElementById("file_uploaded").required = true;
        document.getElementById("nofield").required = false;
        document.getElementById("range_from").required = false;
        document.getElementById("range_to").required = false;
                   document.f1.action = "uploadSchema.jsp";  ///////////////   here the action for upload Schema
}
function myFunction6() {
    document.getElementById("extra1").style.display= "block";
    document.getElementById("extra2").style.display= "none";
    document.getElementById("extra3").style.display= "none";
    document.getElementById("extra4").style.display= "none";
    document.getElementById("extra5").style.display= "none";
    document.getElementById("extra6").style.display= "block";
             document.getElementById("written_schema_name").required = true;
             document.getElementById("textCode").required = true;
        document.getElementById("file_uploaded").required = false;
        document.getElementById("nofield").required = false;
        document.getElementById("range_from").required = false;
        document.getElementById("range_to").required = false;
        document.f1.action = "saveSchema.jsp"; ///////////////   here the action for save Schema
}
// to handle the number of annotators feild. 
function incrementButtons( upBtn, downBtn, qtyField )
{
var step = parseFloat( qtyField.value ) || 1,
currentValue = step;

downBtn.onclick = function()
{
currentValue = parseFloat( qtyField.value ) || step; 
qtyField.value = ( currentValue -= Math.min( step, currentValue - step ) );
}

upBtn.onclick = function()
{
currentValue = parseFloat( qtyField.value ) || step; 
qtyField.value = ( currentValue += step );
} 
}
</script>
    </head>
      <%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
   %>
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
    <% 
    if(request.getParameter("state")!=null)
    { 
        if(request.getParameter("state").equals("done")){
    %>
    <script>
        alert("تم الإنشاء");
        </script>
            <%
        }
        else if(request.getParameter("state").equals("error")){
    %>
    <script>
        alert("لم يتم إنشاء المهمة بشكل صحيح");
        </script>
            <%
        }
            
        }
    %> 
            <form name="f1" method="post" id="f1" action="" >
      
        <h1>إنشاء مهمة جديدة</h1>
        
        <fieldset>
          <label for="task_name">اسم المهمة</label>  
          <input type="text" id="Task_name" name="task_name" required>          
          <label for="task_des">وصف المهمة</label>
          <textarea rows="4" cols="50" id="task_des" name="task_des" class ="textareaverrical" required></textarea>
          <label for="corpus_text">المدونة</label>
            <%
            try{
// rerrieving the corpora from the database. 
         DataSource ds = (DataSource) new InitialContext().lookup("jdbc/madad");
             Connection con = ds.getConnection(); 
                                String sqlString = "SELECT D_ID,name FROM dataset";
                                Statement myStatement = con.createStatement();
                                ResultSet rs=myStatement.executeQuery(sqlString);
                                %>               
                                <select id="corpus_text" name="corpus_text" required>
                                    <%
                               if(!rs.isBeforeFirst())
                                {
                                    %>
                                      
                                        <option value=" <%="empty"%>" disabled="disabled"> <%out.print("لا توجد مدونات مدخلة"); %></option> 
                                       
                                    <%
                                }
                               
                                 while(rs.next())
                                {   
                            %>
                                    
                                        
                                        <option value=" <%out.print(rs.getString("D_ID"));%> ">
                                            <%out.print(rs.getString("name")); %> </option>
                                   
                            <%
                                }
                            %>
                            </select>
                                
       <% rs.close();
                                myStatement.close();
                                con.close();
                        }catch(Exception e){e.printStackTrace();} %>
                        
  <label>مستوى الترميز</label>
  <select id="anno_level" name="anno_level" required>
 <option value=" <%="word"%>"> <%out.print("كلمة"); %></option> 
  <option value=" <%="sentence"%>"> <%out.print("جملة"); %></option> 
    <option value=" <%="phrase"%>"> <%out.print("عبارة"); %></option> 
 <option value=" <%="document"%>"> <%out.print("مستند"); %></option> 
      </select>
      
      <label>عدد المرمزين</label>
<input type='button' name='subtract' value='-' class="inlineElement" />
<input type='text' name='qty' id='qty' value='1' class="inlineElement" required/>
<input type='button' name='add' value='+' class="inlineElement"/>

<script type="text/javascript">
with( document.getElementById( 'f1' ) )
incrementButtons( add, subtract, qty );

</script>                     
         <label>نوع الترميز </label>
         <label for="readability" class="light" >ترميز مقروئي</label>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="radio" onclick="myFunction1()" id="other" name="ann_type" value="other_types" required>
         <label for="other_types" class="light">ترميز آخر</label>
         <input type="radio" onclick="myFunction2()" id="read"  name="ann_type" value="readability">
         

        <div id="extra2" style="display: none;">
        <label for="read_type">نوع تقييم مقروئية النص</label>
        <br>
         <label for="compare" class="light">تقييم بالمقارنة</label>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<input type="radio"  id="direct_assigning" onclick="myFunction3()" name="read_type" value="direct_assigning" >
                   
<label for="direct_assigning" class="light">تقييم بإسناد قيمة مباشرة</label>
<input type="radio" onclick="myFunction4()" id="compare"  name="read_type" value="compare">
          </div>
                  <div id="extra4" style="display: none;">
                           <label for="range_from" class="light">من</label>
                           <input type="text" name="range_from" id="range_from" />

                           <label for="range_to" class="light">إلى</label>
                           <input type="text" name="range_to" id="range_to" />
</div>
         
         <div id="extra3" style="display: none;">
              <label for="num_comp">عدد معايير المقارنة</label>
<input type="text" name="nofield" id="nofield" onchange="showdata()" />
<div id="extranum">
    
</div>
         </div>
         
        
         <div id="extra1" style="display: none;">
        <label for="schema">Schema</label> 
          <br>
         <label for="upload" class="light">تحميل</label>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<input type="radio"  id="write" onclick="myFunction6()" name="schema" value="write" >
                   
<label for="write" class="light">كتابة</label>

<input type="radio" onclick="myFunction5()" id="upload"  name="schema" value="upload">
          
         <div id="extra5" style="display: none;">
         <input type="file" id="file_uploaded" name="file_uploaded" />
         </div>
          
          
           <div id="extra6" style="display: none;">
                  <label for ="schema_title" > عنوان Schema </label>
                  <input type="text" id="written_schema_name" name="written_schema_name" >  
                  
        <textarea rows="14" cols="50" id="textCode"  name="write_schema" class ="textareaverrical"  spellcheck="false" ></textarea>     
             </div>
          
          
          </div>
          <label for="guides">توجيهات </label>
          <textarea rows="4" cols="50" id="task_des" name="guides" class ="textareaverrical" required></textarea>
 </fieldset>      
      &nbsp; &nbsp; &nbsp; 
<button type="button" >إلغاء</button> 
&nbsp; &nbsp; 
 <button type="submit" >تقدم</button>
&nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; 
      </form>
      </div>
      <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
    </body>
</html>


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 