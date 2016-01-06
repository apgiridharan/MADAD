<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="org.iwan.madad.utils.*"%>
<%-- 
    Document   : listOfDatasets
    Created on : Jan 4, 2016, 12:07:47 PM
    Author     : Giri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
           <script>
               function exportCorpus(){
			var xmlhttp;
                        var datasetID=getRadioVal(document.getElementById('form_list'),'datasetID');
			document.getElementById("exportMessage").innerHTML = "";
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("exportMessage").innerHTML = xmlhttp.responseText;
			}
			}
			xmlhttp.open("GET", "exportCorpus.jsp?datasetID="+datasetID, true);
			xmlhttp.send();
                    }
                    
              function getRadioVal(form, name) {
                            var val;
                            // get list of radio buttons with specified name
                            var radios = form.elements[name];

                            // loop through list of radio buttons
                            for (var i=0, len=radios.length; i<len; i++) {
                                if ( radios[i].checked ) { // radio checked?
                                    val = radios[i].value; // if so, hold its value in val
                                    break; // and break out of for loop
                                }
                            }
                            return val; // return value of checked radio or undefined if none checked
                        }
           </script>
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
   <% 
    String userID = (String)session.getAttribute("userid");
    session.setAttribute("userid",userID);
    request.setCharacterEncoding("UTF8");
    String T_ID = request.getParameter("ID");
    String state = request.getParameter("state");
    %>
      <form method="post" action="relatedTasks.jsp" name="form_list" id="form_list">
          
       <h1>
           قائمة مجموعات البيانات
       </h1>
         
          <%
                 Dataset dataset=new Dataset();
                 ArrayList<Dataset> list=new ArrayList<Dataset>();
                 list=dataset.getDatasetList();
          %>
          <div id="exportMessage">
              
          </div>
          
          <div align="center">
              <table align="center">
              <%
                    for(int i=0;i<list.size();i++)
                    {
                       Dataset dataset1=new Dataset();
                       dataset1=list.get(i);
                     
              %>   
                    <tr><td>
                      <input type="radio" align="centre" id="datasetID" name="datasetID" value="<%=dataset1.getId()%>"><%=dataset1.getName() %><br>
                        </td></tr>
                      <%
                    }
              %>
              </table>
          </div>
          
        <div id="buttons">
            
    <table width="100%">
        <tr>
            <td>
                <button style="width:100%" type="submit">عرض المهام ذات الصلة</button>
            </td>
            <td> 
                <button style="width:100%" onclick="exportCorpus();" type="button">تصدير المشروح الإحضار</button>
            </td>
       </tr>
             
    </table>
             </div>
       

</form>
                <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
    </body> 
</html>
