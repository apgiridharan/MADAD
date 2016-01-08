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
            String fileID=request.getParameter("fileID");
            String requestFor=(String)request.getParameter("requestFor");
            Dataset dataset=(Dataset)session.getAttribute("dataset");
            int annotatorID=Integer.parseInt(session.getAttribute("userID").toString());
            Annotator annotator=new Annotator();
            if(requestFor.equals("currentFile"))
            {
            
                out.println("<label dir=\"rtl\">");
                File file=new File();
                int nFileID=Integer.parseInt(fileID);
                String fileContent=file.getContent(nFileID);
                out.print(annotator.getAnnotatedText(fileContent,annotatorID));
                out.println("</label>");
             }
             else if(requestFor.equals("nextFile")){
                 out.println("<label dir=\"rtl\">");
                 String content=dataset.getNextFileContent(annotatorID);
                 out.print(annotator.getAnnotatedText(content,annotatorID));
                 out.println("</label>");
             }
             else if(requestFor.equals("previousFile"))
             {
                out.println("<label dir=\"rtl\">");
                String content=dataset.getPreviousFileContent(annotatorID);
                out.print(annotator.getAnnotatedText(content,annotatorID));
                out.println("</label>");
             }
              
%>

    <br>
              <h2>
                  نسبة النص المشروح
              </h2>
              <div class="progress" style="width:50%;" align="right">
                    <div id="time" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"
                    aria-valuemin="0" aria-valuemax="100" style="width:<%=dataset.getProgress()%>%">
                      <%=dataset.getProgress() %>%
                    </div>
                </div>
    </div>