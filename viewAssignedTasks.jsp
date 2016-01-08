<%-- 
    Document   : viewAssignedTasks
    Created on : 15/09/2015, 10:20:23 م
    Author     : Aysha Al-Mahmoud
this page show the tasks that the user is currently working on 
--%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int[] Task_ID = new int[10];
    String[] Task_Name = new String[10];
    String[] Description = new String[10];
    int i=0;
    String name = (String)session.getAttribute("userid");
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/madad");
                //DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/madad");
                Connection con = ds.getConnection();
                
                Statement st = con.createStatement();
                int annotator_Id =Integer.parseInt(session.getAttribute("annotatorID").toString());
                ResultSet  rs1 = st.executeQuery("select DISTINCT *  from assigned_to where A_ID=" + annotator_Id + " and status = 'accept'");
                
               while(rs1.next()){
                  Task_ID[i++]=rs1.getInt("ta_ID");

              } 

               int counter=0;
               ResultSet rs2 = null;
               while(Task_ID[counter] != 0){
                 rs2 = st.executeQuery("select  Task_Name, Description  from task where ta_ID=" +Task_ID[counter] + "");
                 while(rs2.next()){
               Task_Name[counter] = rs2.getString("Task_Name");
               Description[counter] = rs2.getString("Description");
               counter++;

                 }}

                        session.setAttribute("name", name);
                     }
                     catch(Exception ex)
                     {
                         ex.printStackTrace();
                     }

        
    %>
<html> 

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>المهام المسندة</title>
	<!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Varela+Round">-->
	<link rel="stylesheet" href="newcss.css">
 <style>  button[type="button"] {
	background-color: #33cc77;
	color: #fff;
	display: block;
	margin: 0 auto;
	padding: 4px 0;
	width: 150px;
        font-size: 16px;
      
          font-style: bold;}
     
#login {
	margin: 200px auto;
        margin-bottom: 150px;
	width: 600px;
        text-align: right;

}

#login h2 {
	background-color: #33cc77;
	-webkit-border-radius: 20px 20px 0 0;
	-moz-border-radius: 20px 20px 0 0;
	border-radius: 20px 20px 0 0;
	color: #fff;
	font-size: 28px;
	padding: 20px 26px;
        margin-bottom: 0px;
}

#login h2 span[class*="fontawesome-"] {
	margin-right: 12px;

}

#login fieldset {
	background-color: #fff;
	-webkit-border-radius: 0 0 20px 20px;
	-moz-border-radius: 0 0 20px 20px;
	border-radius: 0 0 20px 20px;
	padding: 20px 26px;

}
#login fieldset a {
	color: #777;
	margin-bottom: 14px;
text-align: center;
}
#login fieldset p {
	color: #777;
	margin-bottom: 14px;

}

#login fieldset p:last-child {
	margin-bottom: 0;

}

#login fieldset input {
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;

}

#login fieldset input[type="text"], #login fieldset input[type="password"] {
	background-color: #eee;
	color: #777;
	padding: 4px 10px;
	width: 328px;

}

#login fieldset input[type="submit"] {
	background-color: #33cc77;
	color: #fff;
	display: block;
	margin: 0 auto;
	padding: 4px 0;
	width: 100px;

}

#login fieldset input[type="submit"]:hover {
	background-color: #28ad63;
}
  </style>
    </head>
 
     <body>
     <div id="wrapper">
  <div id="header"> 

<img src="madad.png" alt="logo" width="122" height="120" style="float:right; right:0px; top:0px;">
        <h1>
          <label style="font-size:30pt; font-weight: bold;">(Arabic annotation tool)</label><br><br>
          <label style="font-size:20pt; ">(أداة مدد لتحشية المدونات العربية)</label>
        </h1>
     <h1>&nbsp;</h1>

  </div>
         <div id="login">
             <label>
 مرحباً
<%=name%></label>

            <h2 style="text-align: right;"><span class="fontawesome-lock"></span>المهام المسندة</h2>
            <form method="post" action="sendMessage.jsp">
            <fieldset  style="text-align: right;">
                <% for(int k=0; k<Task_ID.length; k++){
              if ((Task_Name[k] != null)&& (Description[k] != null)){%>
              <label style="text-align: right;" >(<%=k+1%></label><br>
              <label style="text-align: right;" >اسم المهمة:</label>
                 <label  style="text-align: right;"><%=Task_Name[k]%></label> <br>
                   <label style="text-align: right;" >وصف المهمة:</label> 
                      <label  style="text-align: right;"><%=Description[k]%></label>
                              <br><br><br>

                        <%}}
                 if (Task_ID[0] == 0)
                        {out.println("لا يوجد لديك مهام مسندة");}%>
        <br><br><br><br><br><br>

  </fieldset>
            </form>
</div>

<div id="footer">
<small>Copyright by KSU &copy2015. All rights reserved.</small>
</div>
     </div>
    </body>
</html>
