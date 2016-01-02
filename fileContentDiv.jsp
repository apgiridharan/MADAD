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
        <%   request.setCharacterEncoding("UTF-8");
            String datasetID=request.getParameter("ID");
            String userID=request.getParameter("userID");
            String fileID=request.getParameter("fileID");
            String state = request.getParameter("state");
            if(state != null && (state.equals("empty")))
              {
                  //          means there is no other text to compare with 
                      out.print("لا توجد نصوص أخرى لمقارنتها");
                  
              }
              else {
        
                out.println("<label dir=\"rtl\">");
                File file=new File();
                int nFileID=Integer.parseInt(fileID);
                out.print(file.getContent(nFileID));
                out.println("</label>");

 
            }      
%>
    </div>