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
        <title>تقييم مقروئية النص (مطلق)</title>
        <link rel="stylesheet" href="css.css">
        <style>
             #buttons{
            display: block;
           // top: 150px;
             max-width: auto;
             min-width: auto;
             margin: 90px auto auto auto;
             padding: 10px 20px;
             border-radius: 8px;
             position: relative;
             max-height: auto;
           }
           #textareas h1 
           {
         background-color: #33cc77;
	-webkit-border-radius: 20px 20px 0 0;
	-moz-border-radius: 20px 20px 0 0;
	border-radius: 20px 20px 0 0;
	color: #fff;
	font-size: 28px;
	/*padding: 20px 26px;*/  
           }
            iframe{
         padding: 10px 20px;
         background: #f4f7f8;
         border-radius: 8px;
         position: relative;

           }
            button {
        background-color: #33cc77;
	color: #fff;
	display: block;
	margin: 0 auto;
	padding: 4px 0;
	width: 100px;
        
}
      .slider-width100
{
    width: 180px !important;
}
           </style>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">

                          <ul class="nav"> <!-- this Arabic word means logout -->
                                  <li>
                                          <a href="logout.jsp">تسجيل الخروج</a>
                                  </li>
                                  <li> <!-- this Arabic word means main page -->
                                          <a href="index.jsp">الرئيسية</a>
                                  </li>
                          </ul>
             <header style="margin-top: 10px;">
                    <label style="font-size:30pt; font-weight: bold;">Arabic annotation tool</label><br><br>
                      <label style="font-size:20pt; ">(تحشية المدونات العربية)</label>
              </header>
            </div>
            <form method="post" action="taskList.jsp" name="form_list" id="form_list">

                            <h1>
                    اتفاق الحواشي أمور
                            </h1>
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
            double[] sum=new double[kappaList.size()];
            
         %>
         <div id="kappa">
             <table border="1">
                 <tr>
                     <td></td>
                     <%
                         for(int i=0;i<kappaList.size();i++)
                         {
                             out.println("<td>"+kappaList.get(i).getAnnotator() +"</td>");
                         }
                     %>
                     <td>Multiplied</td>
                 </tr>
                 
                 <%
                         for(int i=0;i<schemaList.size();i++)
                         {
                             int schemaID=schemaList.get(i).getId();
                             String value=schemaList.get(i).getValue();
                             out.println("<tr>");
                             out.println("<td>"+value+"</td>");
                             double multi=1;
                             for(int j=0;j<kappaList.size();j++)
                             {
                                 int userID=kappaList.get(j).getAnnotatorID();
                                 int count=annotator.getAssignedCount(schemaID, userID, fileID);
                                 out.println("<td>"+count+"</td>");
                                 multi=multi*(count/schemaList.size());
                             }
                             out.println("<td>"+multi+"</td>");
                             sum[i]=multi;
                             out.println("</tr>");
                         }
                         double total=0;
                         for(int i=0;i<sum.length;i++)
                         {
                             total=total+sum[i];
                         }
                         int span=schemaList.size()-2;
                         out.println("<tr><td>Total</td><td align=\"right\" colspan=\""+span+"\">"+total+"</td></tr>");
                 %>
             </table>
         </div>
             <div id="buttons">
                 <button style="width:100%" type="submit">قائمة المهام</button>
             </div>
  </form>
             <br>
             <br>
             <br>
             <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
    </body> 
</html>
