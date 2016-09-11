<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	FeatureSetUIModel feture = new FeatureSetUIModel(request, response, basePath);
	feture.init();
%>
</head>
<body class="easyui-layout" leftmargin="0" topmargin="0" style="font-size:smaller">
	<form method="post" action="" class="am-form" id="form1">
		<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div>
			<table border="0" width="100%" >
				<tr>
					<td valign=top align=left width='30%'>
						<%=feture.pub1.ListToString() %>
					</td>
					<td valign=top align=left width='70%'>
						<%=feture.pub2.ListToString() %>
				    </td>
				</tr>
			</table>
		</div>
	</form>
</body>
<script type="text/javascript">
function onSave(){
	/* var size = $("input[name^='CB_']:checked").size();
	if(size == 0){
		alert("请选择要撤销的节点！");
		return;
	}	 */
	
	var param = window.location.search;
	$("#FormHtml").val($("#form1").html());
	var url = "<%=basePath%>DES/FeatureSetUISave.do"+param;
	$("#form1").attr("action", url);
	$("#form1").submit();
}
</script>
</html>