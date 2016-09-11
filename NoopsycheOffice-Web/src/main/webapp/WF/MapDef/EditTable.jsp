<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WF/head/head1.jsp"%>
    <base target=_self  />
<%
	EditTableModel editT = new EditTableModel(request, response);
	editT.init();
 %>
    <script language=javascript>
    /* ESC Key Down  */
    function Esc()
    {
        if (event.keyCode == 27)    
            window.close();
       return true;
   }
   function RSize() {

       if (document.body.scrollWidth > (window.screen.availWidth - 100)) {
           window.dialogWidth = (window.screen.availWidth - 100).toString() + "px"
       } else {
           window.dialogWidth = (document.body.scrollWidth + 50).toString() + "px"
       }

       if (document.body.scrollHeight > (window.screen.availHeight - 70)) {
           window.dialogHeight = (window.screen.availHeight - 50).toString() + "px"
       } else {
           window.dialogHeight = (document.body.scrollHeight + 115).toString() + "px"
       }
       window.dialogLeft = ((window.screen.availWidth - document.body.clientWidth) / 2).toString() + "px"
       window.dialogTop = ((window.screen.availHeight - document.body.clientHeight) / 2).toString() + "px"
   }
   function btn_Save_Click(btnName){
	   $("#FormHtml").val($("#form1").html());
	   if(btnName=='Btn_Del'){
	    	if (window.confirm('您确认吗?') == false)
	            return;
	    	}
       var url = "<%=basePath%>WF/MapDef/btn_Save_Click1.do?SFKey=<%= request.getParameter("SFKey")%>&DoType=<%=editT.getDoType() %>&MyPK=<%=editT.getMyPK()%>&RefNo=<%=editT.getRefNo()%>&GroupField=<%=editT.getGroupField()%>&btnName="+btnName;
       $("#form1").attr("action",url);
		$("#form1").submit();
   }
    </script>
</head>
<body    topmargin="0" leftmargin="0" onkeypress="Esc()" onload="RSize()"  >
    <form id="form1" method="post" >
    <input type="hidden" id="FormHtml" name="FormHtml" value="">
    <div align=center width='90%'>
    <%=editT.Pub1.ListToString()%>
    </div>
    </form>
</body>
</html>