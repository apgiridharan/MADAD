<%@page import="org.iwan.madad.utils.Dataset"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Blob"%>
<%-- 
    Document   : Annotate Text
    Author     : Giridharan Planisamy
    this page enables the annotator to do the schema oriented annotation. 
    Email: apgiridharan@gmail.com --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
     <!-- this Arabic word means readability assesment using direct value -->
        <title>تقييم مقروئية النص (مطلق)</title>
        <link rel="stylesheet" href="css.css">
        <style>
             #buttons{
            display: block;
         //  top: 150px;
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
 </style>
                
	<script>
            var selectedText;
            var value;
            
                     //It will load the next or previous dataset in the textArea div
                     function loadNextText(requestFor){
			var xmlhttp;
                        var userID=document.getElementById("userID").value;
                        var datasetID=document.getElementById("datasetID").value;
                        var fileID=document.getElementById("currentFileID").value;
			document.getElementById("textAreaDiv").innerHTML = "";
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("textAreaDiv").innerHTML = xmlhttp.responseText;
			}
			}
			xmlhttp.open("GET", "fileContentDiv.jsp?fileID="+fileID+"&ID="+datasetID+"&requestFor="+requestFor, true);
			xmlhttp.send();
                    }
                    
                     function hasWhiteSpace(s) {
                             return s.indexOf(' ') >= 0;
                     }
                     
                     function moreSentance(s){
                         return s.indexOf('.')==s.length-1;
                     } 

                    //Mouseup function
                    $(function() {
                    $('div.one').mouseup( function() {
                        var mytext = selectHTML();
                        var selectedText=mytext.toString();
                        selectedText=selectedText.replace("<span>","");
                        selectedText=selectedText.replace("</span>","");
                        selectedText=selectedText.trim();
                        document.getElementById('textBox').value=selectedText;
                        var annotationLevel=document.getElementById("annotationLevel").value.toString();
                        if(selectedText.length>1)
                        {
                            //Word level annotation
                            if(annotationLevel==new String("word"))
                            {
                                if(hasWhiteSpace(selectedText)==false)
                                {
                                    $('#myModal').modal('show');
                                }
                                else
                                   alert("Sorry! Please select a single word."); 
                            }//Sentance level annotation
                            else if(annotationLevel==new String("sentence"))
                            {
                                if(moreSentance(selectedText)==true)
                                {
                                    $('#myModal').modal('show');

                                }
                                else
                                   alert("Sorry! Please select a full sentence");
                            }  
                            else
                                alert("Sorry! Its document level annotation");
                           
                        }//document level annotation
                        else if(annotationLevel==new String("document"))
                        {
                            alert("this is document level anotation");
                        }
                    });
                });
                
                //Get the selected text
                function selectHTML() {
                    try {
                        if (window.ActiveXObject) {
                            var c = document.selection.createRange();
                            return c.htmlText;
                        }

                        var nNd = document.createElement("span");
                        var w = getSelection().getRangeAt(0);
                        w.surroundContents(nNd);
                        return nNd.innerHTML;
                    } catch (e) {
                        if (window.ActiveXObject) {
                            return document.selection.createRange();
                        } else {
                            return getSelection();
                        }
                    }
                }

                //Annotate Text function It will store the annotation value and color the token 
                function annotate(){
                    var selectedText=$("textarea#textBox").val();
                    var value=$("select#annotationValue").val();
                    var userID=$("#userID").val();
                    var datasetID=$("#datasetID").val();
                    var colorID="color"+value;
                    var color=$('#'+colorID).val();
                    
                    $('#myModal').modal('hide');
                    $.ajax({
                        url: "storeAnnotationValue.jsp",
                        type: "POST",
                        cache: false,
                        data: { selectedText: selectedText, 
                                value: value,
                                userID: userID,
                                datasetID: datasetID },
                        success: function(data) {
                            var selection = getSelectedText();
                            var selection_text = selection.toString();

                            // How do I add a span around the selected text?

                            var span = document.createElement('SPAN');
                            span.textContent = selection_text;
                            span.className=color;
                            span.style.color=color;
                            var range = selection.getRangeAt(0);
                            range.deleteContents();
                            range.insertNode(span);
                        },
                        error: function(data) {
                           alert("annotation failed");
                        }
                    })
                   
                }
                
                function getSelectedText() {
                t = (document.all) ? document.selection.createRange().text : document.getSelection();
                return t;
              }
               
        </script>
    </head>
    <body>
       
         <div id="wrapper">
  <div id="header">
      <img src="madad.png" alt="logo" width="122" height="100" style="float:right; right:0px; top:0px;">
   <header style="margin-top: 10px;">
          <label style="font-size:30pt; font-weight: bold;">Arabic annotation tool</label><br><br>
            <label style="font-size:20pt; ">(تعليم النص)</label>
    </header>
  </div>
             
    <!-- Modal For Annotate  -->
    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">
                        قيمة الشرح
                    </h4>
                </div>
                <div class="modal-body">
                    <lable>النص المحدد</lable>
                    <textarea id="textBox" rows="100" style="min-height:100px;" readonly>
                    </textarea>
                    <br>
                    <sql:query var="rs" dataSource="jdbc/madad">
                        SELECT * FROM annotation_value;
                    </sql:query> 
                    <lable>ميزات</lable>
                    <select id="annotationValue">
                        <option value="">Select value</option>
                            <c:if test="${rs.rowCount > 0}">
                                <c:forEach var="row" items="${rs.rows}">                   
                                 <option value="${row.AV_ID}">${row.Value}</option>
                                </c:forEach>
                            </c:if>
                    </select>
                    <sql:query var="rs1" dataSource="jdbc/madad">
                        SELECT * FROM annotation_value;
                    </sql:query> 
                    <c:forEach var="row1" items="${rs1.rows}">                   
                           <jsp:element name="input">
                                <jsp:attribute name="type">hidden</jsp:attribute>
                                <jsp:attribute name="id">color${row1.AV_ID}</jsp:attribute>
                                <jsp:attribute name="value">${row1.tag_color}</jsp:attribute>
                           </jsp:element>
                    </c:forEach>
                           
                </div>
                <div class="modal-footer">
                     <button type="button" onclick="annotate();" class="btn-success"> علق</button>
                </div>
            </div>
        </div>
    </div>
             
   <% 
    String userID = (String)session.getAttribute("userid");
    
    request.setCharacterEncoding("UTF8");
    String taskID = request.getParameter("ID");
    String state = request.getParameter("state");
    userID="18";
    taskID="1";
    Dataset dataset=new Dataset();
    session.setAttribute("userID",userID);
  
if(state != null && state.equals("done"))
{%>
<script> // this alert means "has been assigned"
     alert("تم الإسناد");
     </script>
     <%
     response.setHeader("Refresh", "0; URL=index.jsp");
}
else 
{ 
      %>
      <!-- retrieving all the related direct assigning task info. -->
      <sql:query var="rs" dataSource="jdbc/madad">
          SELECT Guidelines,directAssigningFrom,directAssigningTo,Task_Name,Level_Of_Annoation, dataset.name as dname, dataset.D_ID
          FROM task,dataset,annotation_style 
          WHERE task.ta_ID='<%=taskID%>' 
          AND annotation_style.ta_ID='<%=taskID%>' 
          AND annotation_style.D_ID = dataset.D_ID;
      </sql:query>  
          
           <c:choose>    
                    <c:when test="${rs.rowCount == 0}">   <!--  this print mean "nothing" -->
                        <%
                        
                           out.print("لا يوجد");     
                        %>
                    </c:when>
            <c:when test="${rs.rowCount > 0}">
                <c:forEach var="row" items="${rs.rows}">                   
                 <c:set var="from" value = "${row.directAssigningFrom}" />
                 <c:set var="to" value = "${row.directAssigningTo}" />
                 <c:set var="D_Name" value = "${row.name}" />
                 <c:set var="D_ID" value = "${row.D_ID}" />
                 <c:set var="tname" value = "${row.Task_Name}" />
                 <c:set var="levelOfAnnotation" value = "${row.Level_Of_Annoation}" />
                 <c:set var="guideLines" value="${row.Guidelines}" />
                </c:forEach>
            </c:when>
                </c:choose>

      <form method="post" action="" name="form_list">
           <input type="hidden" name="TT_ID" id="taskID" value="<%=taskID%>">
           <input type="hidden" name="D_ID" id="datasetID" value="${D_ID}">
           <input type="hidden" id="userID" value="<%=userID%>">
           <!-- Annotation level -->  
           <input type="hidden" value="${levelOfAnnotation}" id="annotationLevel">
          
                <h1>
                     <c:out value='${tname}'/>
                </h1>
              <h2>
                   <c:out value='${D_Name}'/> 
              </h2> 
               <%
                int datasetID=Integer.parseInt(pageContext.getAttribute("D_ID").toString());
                dataset.setId(datasetID);
                dataset.setFiles();
                int firstFileID=dataset.getFirstFileID();
                dataset.setCurrentFileID(firstFileID);
                int numberOfFiles=dataset.getNumberOfFiles();
                session.setAttribute("dataset", dataset);
               %> 
               <input type="hidden" id="currentFileID" value="<%=firstFileID%>" />
               <input type="hidden" id="numberOfFiles" value="<%=numberOfFiles%>" />
              <div id="textAreaDiv" class="one" >
                   <script type="text/javascript">
                        loadNextText("currentFile");
                    </script>
              </div>
              <h2>
                   توجيهات
              </h2>
              <textarea id="guideLines" rows="100" style="min-height:100px;" readonly>
              ${guideLines}
              </textarea>
              <br><br>
              <br>

        <div id="buttons">
<!--             the button means  "quit" -->
     <button style="display: inline" type="button" onclick="loadNextText('previousFile')">خروج </button>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;
              &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp; &nbsp;&nbsp;
              <!--             the button means  "quit" -->
             <button style="display: inline" type="button" onclick="loadNextText('nextFile')">إسناد</button>
               &nbsp;  &nbsp; &nbsp;
             <!--<a href="#" onclick="//document.formName.submit();">-->
             </div>
       
<script>
           $('[name="form_list"]').change(function() {
  $(this).closest('form').submit();
});
</script>
</form>
                <div id="footer">
<p><small>Copyright by KSU &copy2015. All rights reserved.</small></p>
</div>
            </div>
      
    </body>
</html>

<%}%>        
   
           