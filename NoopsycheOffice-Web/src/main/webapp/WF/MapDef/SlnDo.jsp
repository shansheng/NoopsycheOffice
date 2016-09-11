<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	String FK_MapData = request.getParameter("FK_MapData");
	String FK_Node = request.getParameter("FK_Node");
	String FK_Flow = request.getParameter("FK_Flow");
	String KeyOfEn = request.getParameter("KeyOfEn");
	SlnDoModel slnDo = new SlnDoModel(request, response, KeyOfEn,FK_Node);
	slnDo.init();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0 auto;
	/*color: #000;
            line-height: 20px;
            font-family: 宋体;
            text-align: center;
            width: 90%;*/
}
</style>
<script type="text/javascript">
	function Esc() {
		if (event.keyCode == 27)
			window.close();
		return true;
	}
	function btn_Click(){
		/* var str=null;
		if($("#CB_IsSigan").length>0){
			alert("控件存在");
			str=1;
		}else{
			alert("控件不存在");
			str=0
		} */
		var url = "<%=basePath%>WF/MapDef/btn_Click.do?FK_Node=<%=FK_Node%>&FK_Flow=<%=FK_Flow%>&FK_MapData=<%=FK_MapData%>&KeyOfEn=<%=KeyOfEn%>";
		$("#form1").attr("action",url);
		$("#form1").submit();
		Window.close();
	}
</script>
</head>
<body onkeypress="Esc();" class="easyui-layout">
	<form method="post"
		action="SlnDo.jsp?DoType=Copy&amp;FK_MapData=<%=FK_MapData %>&amp;FK_Flow=<%=FK_Flow %>&amp;FK_Node=<%=FK_Node %>"
		id="form1">
		<div data-options="region:'center',title:''" style="padding: 5px;">
			<%=slnDo.Pub1.toString()%>
		</div>
	</form>
</body>
</html>