<%-- 
    Document   : cohensKappa
    Created on : Jan 8, 2016, 3:32:56 PM
    Author     : Giri
--%>

<%@page import="org.iwan.madad.utils.Annotator"%>
<%@page import="org.iwan.madad.utils.Schema"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.iwan.madad.utils.CohensKappa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int taskID=Integer.parseInt(request.getParameter("taskID").toString());
            int fileID=Integer.parseInt(request.getParameter("taskID").toString());
            //int fileID=1;
            //int taskID=1;
            Annotator annotator=new Annotator();
            CohensKappa kappa=new CohensKappa(taskID);
            ArrayList<CohensKappa> kappaList=new ArrayList<CohensKappa>();
            kappaList=kappa.getResult(fileID);
            Schema schema=new Schema();
            ArrayList<Schema> schemaList=new ArrayList<Schema>();
            schemaList=schema.getSchemaList();
            
         %>
         <div id="kappa">
             <table border="1">
                 <tr>
                     <td></td>
                     <%
                            for(int i=0;i<schemaList.size();i++)
                            {
                                Schema schema1=new Schema();
                                schema1=schemaList.get(i);
                       %>
                       <td><%=schema1.getValue() %></td>
                     <%
                            }
                                
                     %>
                 </tr>
                 <%
                        
                        for(int i=0;i<kappaList.size();i++)
                        {
                            CohensKappa kappa1=new CohensKappa();
                            kappa1=kappaList.get(i);
                            ArrayList<Schema> schemaList1=kappa1.getSchemaList();
                            
                  %>
                            <tr>
                                <td><%=kappa1.getAnnotator()%></td>
                                <%
                                    for(int j=0;j<schemaList1.size();j++)
                                    {
                                 %>
                                 <td><%=schemaList1.get(j).getCount() %></td>
                                 <!--<td><%=annotator.getAssignedCount(schemaList1.get(j).getId(),kappa1.getAnnotatorID(),fileID)%></td>-->
                                <%
                                    }
                                %>
                            </tr>
                 <%
                            
                        }
                                                       
                 %>
             </table>
         </div>
       
    </body>
</html>
