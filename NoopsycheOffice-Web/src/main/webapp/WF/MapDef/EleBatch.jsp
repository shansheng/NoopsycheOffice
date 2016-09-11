<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	EleBatchModel ele = new EleBatchModel(request, response);
	ele.init();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target=_self  />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function btn_Click(){
	   $("#FormHtml").val($("#form1").html());
    var url = "<%=basePath%>WF/MapDef/btn_Click4.do?KeyOfEn=<%=ele.getKeyOfEn()%>&FK_MapData=<%=ele.getFK_MapData()%>&EleType=<%=ele.getEleType()%>&FK_Flow=<%=ele.getFK_Flow()%>&DoType=<%=ele.getDoType()%>";
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
</script>
</head>
<body>
	<form method="post" action="" id="form1">
		<div data-options="region:'center',title:'把当前表单元素Copy到其他的表单上去'"
			style="padding: 5px;">
			<input type="hidden" id="FormHtml" name="FormHtml" value="">
			<table width="80%">
				<tr>
					<td width="30%" valign=top>
						<fieldset>
							<legend>处理内容</legend>
							<%=ele.Left.toString()%>
						</fieldset>
					</td>
					<td><%=ele.Pub1.toString()%>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>