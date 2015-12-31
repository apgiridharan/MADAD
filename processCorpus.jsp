<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--
    Document   : processCorpus
    Author     : Deema Alnuhait
    this page does the processing part (dividing the corpus into tokens). 
    Email: deemaazizn@outlook.com. -->

<!DOCTYPE html>
<html>
    <head>
       
        <title>معالجة المدونة</title>
        <link rel="stylesheet" href="css.css">
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     
        <style>
    #bottom_margin
    {
        margin-bottom: 20px;
    }
    #top_margin
    {
        margin-top:  20px;
    }
      form
      {
           min-width: 1000px;
      }
</style>
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
        <% //   request.setCharacterEncoding("UTF-8");
            String D_ID=request.getParameter("D_ID"); 
//            D_ID = "36";
            String T_ID=request.getParameter("T_ID"); 
//            T_ID = "1";
//            String T_N = request.getParameter("T_N");
//            T_N = "النص الأدبي";
            String A_L=request.getParameter("A_L"); 
//            A_L = "sentence";
            DataSource ds = (DataSource) new InitialContext().lookup("jdbc/madad");
            Connection con = ds.getConnection(); 
            String task_sql = "SELECT * FROM task WHERE T_ID ="+T_ID;
            Statement myStatement = con.createStatement();
            ResultSet rstask=myStatement.executeQuery(task_sql);
            rstask.next();
            String T_N = rstask.getString("Task_Name"); 
        %>
<form id="bottom_margin">

         
<sql:query var="rs" dataSource="jdbc/madad">
 select * from dataset where D_ID = '<%=D_ID%>';
</sql:query> 
 <c:choose>
        <c:when test="${rs.rowCount > 0}">
            <c:forEach var="row" items="${rs.rows}">
                <%
                 String[] tokenW = null;
                  try {
                     
               Blob file = null;
               byte[ ] fileData = null ;
               ds = (DataSource) new InitialContext().lookup("jdbc/madad");
               con = ds.getConnection(); 
               String sql =  "select * from dataset where D_ID = "+D_ID;
               myStatement = con.createStatement();
               ResultSet rs=myStatement.executeQuery(sql);
               rs.next();
               file = rs.getBlob("content");
               String lang = rs.getString("Language");
               InputStream is = file.getBinaryStream();
               fileData = file.getBytes(1,(int)file.length());
               response.setContentLength(fileData.length);
               String ff = new String (fileData,StandardCharsets.UTF_8);
//if word/phrase-level tokenization 
               if(A_L.contains("word") || A_L.contains("phrase"))
                {
           tokenW =    ff.split("\\s+");
           myStatement = con.createStatement();

             for(int i=0; i< tokenW.length; i++)
             { 
sql = "insert into tokenized_words ( D_ID,token_ID,T_ID,value,Annotation_Level) values ("+D_ID+","+(i+1)+","+T_ID+",N'"+tokenW[i]+"','"+A_L+"')";
myStatement.executeUpdate(sql);
              }
                } 
              else 
//if sentence-level tokenization 
                    if(A_L.contains("sentence"))
                    {
                        if(lang.equals("Ar"))
                        {
                     tokenW = ff.split("،|\\.");
                        }
                        else 
                        if(lang.equals("En"))
                        {
                    tokenW =    ff.split("\\.");
                        }
             con = ds.getConnection();
             myStatement = con.createStatement();
              for(int i=0; i< tokenW.length; i++)
             { 
    sql =  "insert into tokenized_sentences values ("+D_ID+","+(i+1)+","+T_ID+",N'"+tokenW[i]+"','"+A_L+"')";
     myStatement.executeUpdate(sql);
              }
                    }
                     myStatement.close();
                                con.close();
                  }
                  catch(SQLException e)
                  {}
                  
                %>
            </c:forEach>
        </c:when>
            <c:when test='${rs.rowCount == 0}'>
                <%
                out.println("لا يوجد نص للعرض");
                %>
            </c:when>
          </c:choose>
  </form>
 <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>

</div>
</div>
    </body>
</html>