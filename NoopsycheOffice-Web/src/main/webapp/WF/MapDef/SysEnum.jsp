<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	SysEnumModel sysE = new SysEnumModel(request, response);
	sysE.init();
%>
<script language=javascript>
    /* ESC Key Down  */
     function Esc() {
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
    function btn_Add_Click(btnName){
    	var param = window.location.search;
 	   $("#FormHtml").val($("#form1").html());
    	if (window.confirm('您确认吗?') == false)
            return;
        var url = "<%=basePath%>WF/MapDef/btn_Add_Click1.do"+param+"&btnName="+btnName;
        $("#form1").attr("action",url);
 		$("#form1").submit();
    }
    function btn_Save_Click(btnName){
    	var param = window.location.search;
  	   $("#FormHtml").val($("#form1").html());
         var url = "<%=basePath%>WF/MapDef/btn_Save_Click2.do"+param+"&btnName="+btnName;
         $("#form1").attr("action",url);
  		$("#form1").submit();
     }
    function btn_Del_Click(btnName){
    	var param = window.location.search;
  	   $("#FormHtml").val($("#form1").html());
     	if (window.confirm('您确认吗?') == false)
             return;
         var url = "<%=basePath%>WF/MapDef/btn_Del_Click1.do"+param+"&btnName="+btnName;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
</script>
</head>
<body>
	<form id="form1" method="post" action="">
		<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div align=center width='90%'>
			<%=sysE.Pub1.ListToString()%>
		</div>
	</form>
</body>
</html>