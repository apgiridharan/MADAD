<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%@page import="org.iwan.madad.utils.Annotator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
 Document   : textArea
 Author     : Giridharan
 this page displays the corpus to be used in schema oriented annotation pages.  
 Email: apgiridharan@gmail.com.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <div id="textAreaDiv" class="one">
        <%   request.setCharacterEncoding("UTF-8");
            String datasetID=request.getParameter("ID");
            String userID=request.getParameter("userID");
            String state = request.getParameter("state");
            if(state != null && (state.equals("empty")))
              {
                  //          means there is no other text to compare with 
                      out.print("لا توجد نصوص أخرى لمقارنتها");
                  
              }
              else {
        %>

                <label dir="rtl">
                                <%
                                    int d_ID=Integer.parseInt(datasetID);
                                    int u_ID=Integer.parseInt(request.getParameter("userID"));
                                    Annotator anno=new Annotator(d_ID);
                                    
                                    //If the corpus is already annotated by the current annotator
                                    if(anno.isAnnotatedByUser(u_ID)){
                                      out.print(anno.getAnnotatedText()); 
                                    }
                                    else{//If the corpus is not annotated by the current user
                                        out.print(anno.getCorpus());
                                    }
                                %>
                </label>
                <%}%>
    </div>