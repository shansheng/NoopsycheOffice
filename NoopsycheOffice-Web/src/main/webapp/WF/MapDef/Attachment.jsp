<%@page import="cn.jflow.model.wf.mapdef.AttachmentModel"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	AttachmentModel att = new AttachmentModel(request, response);
	att.Page_Load();
%>
<script language=javascript>
function load() {
	var success = document.getElementById("success").value;
	if (success == "" || success == null) {
		return;
	} else {
		alert(success);
	}

}
	/* ESC Key Down */
	function Esc() {
		if (event.keyCode == 27)
			window.close();
		return true;
	}
	function NoSubmit() {

	}
	function btn_Save()
	{
		var btnId="Btn_Save";
		var FK_Node='<%=att.getFK_Node()%>';
		var FK_MapData='<%=att.getFK_MapData()%>';
		var Ath='<%=att.getAth()%>';
		var UploadType='<%=att.getUploadType()%>';
		if ($("#CB_FastKeyIsEnable").get(0).checked) {
			var TB_FastKeyGenerRole=$("#TB_FastKeyGenerRole").val();
		    if(TB_FastKeyGenerRole.contains('*OID')==false)
		    	{
		    		alert('@快捷键生成规则必须包含*OID,否则会导致文件名重复.');
		    		return;
		    	}
		}
		var url="<%=basePath%>mapdef/condByPara_btn_Click.do?btnId="+btnId+"&FK_Node="+FK_Node+"&FK_MapData="+FK_MapData+"&Ath="+Ath+"&UploadType="+UploadType;
		$("#form1").attr("action",url);
		$("#form1").submit();
	}
	function btn_Del()
	{
		var btnId="Btn_Delete";
		var FK_Node='<%=att.getFK_Node()%>';
		var FK_MapData='<%=att.getFK_MapData()%>';
		var Ath='<%=att.getAth()%>';
		var UploadType='<%=att.getUploadType()%>';
		var url="<%=basePath%>mapdef/condByPara_btn_Click.do?btnId="+btnId+"&FK_Node="+FK_Node+"&FK_MapData="+FK_MapData+"&Ath="+Ath+"&UploadType="+UploadType;
		$("#form1").attr("action",url);
		$("#form1").submit();
	}
</script>
</head>
<body onLoad="load()">
<input type="hidden" value="${success }" id="success"/>
<form action="" method="post" id="form1">
<div id="mainPanel"  region="center" border="true" border="false" class="mainPanel">
<center>

	<%=att.Pub1.ListToString()%>
	</center>
	</div>
	</form>
</body>
</html>