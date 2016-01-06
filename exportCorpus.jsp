<%-- 
    Document   : exportCorpus
    Created on : Jan 5, 2016, 2:51:05 PM
    Author     : Giri
--%>

<%@page import="org.iwan.madad.utils.Dataset"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="exportMessage" align="center">
    <%
        int id=Integer.parseInt(request.getParameter("datasetID").toString());
        Dataset dataset=new Dataset(id);
        dataset.setFiles();
        System.out.print("The size of files are"+dataset.getFileList().size());
        if(dataset.exportCorpus())
        {
            out.println("<h2>Exported Successfully</h2>");
        }
        else
        {
            out.println("<h2>Export failed</h2>");     
        }
            
    %>
    
</div>
