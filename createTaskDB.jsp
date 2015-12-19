<%-- 
    Document   : createTaskDB
    Author     : Deema Alnuhait
    this page enables the Task Manager to create a new annotation task.(connnection with database) 
    Email: deemaazizn@outlook.com --%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.Date" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%
   String userID = (String)session.getAttribute("userid");
   session.setAttribute("userid",userID);
//   userID = "1";
   %>
    <body>
<%     
    request.setCharacterEncoding("UTF8");
  
    String task_name = request.getParameter("task_name");
    String task_des = request.getParameter("task_des");
    String corpus_text = request.getParameter("corpus_text");//!
    String anno_level = request.getParameter("anno_level");
    int anno_numint = Integer.parseInt(request.getParameter("qty"));
    String read_type = request.getParameter("read_type");
    String guides = request.getParameter("guides");
    String query = "";
     String res= null;
     
    try{
//insert the input that the user has provided in the createTask page.        
    DataSource ds = (DataSource) new InitialContext().lookup("jdbc/madad");
    Connection con = ds.getConnection(); 
    Statement myStatement = con.createStatement();
    String str = "INSERT INTO task (`Task_Name`,`Description`,`Max_Num_Of_Annotators`,`Guidelines`,`U_ID`) VALUES (N'"+task_name+"',N'"+task_des+"',"+anno_numint+",N'"+guides+"',"+userID+")";
    myStatement.executeUpdate(str);
    String ssql  = "select LAST_INSERT_ID() from task";
    ResultSet  rss = myStatement.executeQuery(ssql);
    if(rss.next())
       res =  rss.getString("LAST_INSERT_ID()");
    if(read_type.equals("compare"))
    {
             out.print("two");
   str = "INSERT INTO annotation_style (`Level_Of_Annoation`,`D_ID`,`T_ID`) VALUES (N'"+anno_level+"',"+corpus_text+","+res+")";
   myStatement.executeUpdate(str);
    String nofield = request.getParameter("nofield");
    int nofieldn = Integer.parseInt(nofield);
         ssql  = "select LAST_INSERT_ID() from annotation_style";
    ResultSet  rsss = myStatement.executeQuery(ssql);
    String   ress  ="";
    if(rsss.next())
       ress =  rsss.getString("LAST_INSERT_ID()");
    while (nofieldn>0)
    {
    query = "INSERT INTO comparison_mode (`A_ID`,`value`) VALUES ("+ress+",N'"+request.getParameter(nofieldn+"")+"')";
   nofieldn--;
    myStatement.executeUpdate(query);
    }
    }
    else 
        if(read_type.equals("direct_assigning"))
        {
                 out.print("third");
            String from = request.getParameter("range_from");
            String to = request.getParameter("range_to");
            str = "INSERT INTO annotation_style (`Level_Of_Annoation`,`D_ID`,`T_ID`,`directAssigningFrom`,`directAssigningTo`) VALUES (N'"+anno_level+"',"+corpus_text+","+res+","+from+","+to+")";
   myStatement.executeUpdate(str);
        }     out.print("jhhjhj");

//            String A_L=request.getParameter("A_L"); 
//            A_L = "sentence";
//            String lang =request.getParameter("lang"); 
//            lang = "Ar";
//            out.print(corpus_text);
//             out.print("      "+res);
//             
             String D_ID =corpus_text;
             String T_ID =res;
             String T_N =task_name;
             out.print(T_N);
             String A_L =anno_level;
 
    response.sendRedirect("processCorpus.jsp?D_ID="+D_ID+"&T_ID="+T_ID+"&A_L="+A_L);
}
catch (Exception e){
    response.sendRedirect("createTask.jsp?state=error");

e.printStackTrace();}


%>
    </body>
</html>
