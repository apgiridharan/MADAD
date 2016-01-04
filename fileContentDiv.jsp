<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%@page import="org.iwan.madad.utils.*"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
 Document   : fileContentDiv
 Author     : Giridharan
 this page displays the corpus to be used in schema oriented annotation pages.  
 Email: apgiridharan@gmail.com.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <div id="textAreaDiv" class="one">
        <%  request.setCharacterEncoding("UTF-8");
            String datasetID=request.getParameter("ID");
            String fileID=request.getParameter("fileID");
            String state = request.getParameter("state");
            String requestFor=(String)request.getParameter("requestFor");
            Dataset dataset=(Dataset)session.getAttribute("dataset");
            if(requestFor.equals("currentFile"))
            {
            
                out.println("<label dir=\"rtl\">");
                File file=new File();
                int nFileID=Integer.parseInt(fileID);
                out.print(file.getContent(nFileID));
                out.println("</label>");
             }
             else if(requestFor.equals("nextFile")){
                 out.println("<label dir=\"rtl\">");
                 String content=dataset.getNextFileContent();
                 System.out.println(content);
                 out.print(content);
                 out.print("this is next file");
                 out.println("</label>");
             }
             else if(requestFor.equals("previousFile"))
             {
                out.println("<label dir=\"rtl\">");
                String content=dataset.getPreviousFileContent();
                out.print(content);
                 out.print("this is previous file");
                 out.println("</label>");
             }
                 
   
%>
    </div>