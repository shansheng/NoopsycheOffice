<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  FrmReturnValTBFullCtrlModel frmModel = new FrmReturnValTBFullCtrlModel(request, response);
	frmModel.loadModel();
%>
<%@ include file="/WF/head/head1.jsp"%>
<script type="text/javascript" language="javascript">
function btn_Search_Click(tb){
	var key = $("#TB_Key").val();
	var url = ("FrmReturnValTBFullCtrl.jsp?FK_MapExt=" + tb + "&CtrlVal=" + key);
	window.location.href=url;
}
function btn_Click(){
	$("#TB_CaoZuoYuan",window.opener.document).val($("table tr:eq(2) td:eq(1)").text());
	$("#TB_MingCheng",window.opener.document).val($("table tr:eq(2) td:eq(2)").text());
	$("#DDL_FK_Dept",window.opener.document).val($("table tr:eq(2) td:eq(3)").text());
	window.close();
}
</script>
<body >
     	<%=frmModel.Pub.toString() %>
</body>
</html>