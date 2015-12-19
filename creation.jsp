<%-- 
    Document   : index
    Created on : 22/06/2015, 06:19:01 
    Author     : Aysha Al-Mahmoud
 this page adds a new record of manager/annotator into the database--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page import ="java.sql.*" %>
<%@page import="java.util.Date" %>  
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("user_name");    
    String pwd = request.getParameter("user_password");
    String email = "";
    email = request.getParameter("user_email");
    String age = "";
    age= request.getParameter("user_age");
        request.setCharacterEncoding("UTF-8");
    String language = "";
    language = request.getParameter("user_language");
    String Education_Level = "";
    Education_Level =request.getParameter("user_edu_level");
    String user_type = request.getParameter("user_type");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date date1 = new Date();
    String date = df.format(date1);
     String Institution= ""; 
     String Occupation="";
     
    if (user_type.equals("task_manager"))
    {
     Institution = request.getParameter("Institution");
     Occupation = request.getParameter("Occupation");
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MADAD?useUnicode=true&characterEncoding=UTF-8",
            "root", "");
    Statement st = con.createStatement();
    //ResultSet rs;
     int i=0;
    if (user_type.equals("task_manager")){
     i = st.executeUpdate("insert into manager(Name, Email, Education_Level, Age, Native_Language, Institution, Occupation, Password) values ('" + name + "','" + email + "','" + Education_Level + "','" + age + "','" + language + "','"+Institution + "','"+Occupation+"','"+pwd+"')");
    if (i >0 ){
        response.sendRedirect("mainAdmin.jsp");
    }
    }
    
    
    
    else if (user_type.equals("annotator")){
     i = st.executeUpdate("insert into annotator(Name, Email, Education_Level, Age, Native_Language, Date, Password) values ('" + name + "','" + email + "','" + Education_Level + "','" + age + "','" + language + "','"+date+"','"+pwd+"')");
    if (i > 0){
response.sendRedirect("mainAdmin.jsp");
    }
    }
    else {
        response.sendRedirect("index.jsp");
    }
%>