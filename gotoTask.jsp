<%-- 
    Document   : gotoTask
    Created on : Jan 9, 2016, 8:29:45 AM
    Author     : Giri
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           String schema=null;
            int taskID=Integer.parseInt(request.getParameter("taskID").toString());
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:comp/env");
                DataSource ds = (DataSource) envContext.lookup("jdbc/madad");
                //DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/madad");
                Connection con = ds.getConnection();
                String sql =  "SELECT * from annotation_style WHERE ta_ID="+taskID;
                Statement myStatement = con.createStatement();
                ResultSet rs=myStatement.executeQuery(sql);
                
                while(rs.next())
                {
                    schema=rs.getString("Annotation_Scheme");
                }
              
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
            
            if(schema.equals("schema"))
            {
                String redirectURL = "annotateText.jsp?taskID="+taskID;
                response.sendRedirect(redirectURL);

            }
            else
           {
                String redirectURL = "directAssigning.jsp?taskID="+taskID;
                response.sendRedirect(redirectURL);
            }
                
         %>
        
    </body>
</html>
