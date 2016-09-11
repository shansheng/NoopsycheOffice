<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	FlowSkipModel flowSkip = new FlowSkipModel(request, response, basePath);
	flowSkip.init();
%>
<script type="text/javascript">

</script>
</head>
<body class="easyui-layout" leftmargin="0" topmargin="0">
	<form method="post" action="" class="am-form" id="form1">
		<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div>
			<fieldset>
				<legend>流程跳转</legend>
				  跳转到节点：<%=flowSkip.Pub.toString() %>
				 <br>跳转给(请输入人员编号)：
				 <input name="TB_SkipToEmp" type="text" id="TB_SkipToEmp" />
			     <br>跳转原因：
			     <br>
				 <textarea name="TB_Note" rows="5" cols="20" id="TB_Note" style="width:308px;"></textarea>
			          说明:只能输入一个人员编号.
				 &nbsp;<hr>
			     <input type="button" name="Btn_OK" value="确定跳转" id="Btn_OK" onclick="onSave();"/>
			     <input type="button" name="Btn_Cancel" value="取消" id="Btn_Cancel" onclick="onClose();"/>
			</fieldset>
		</div>
	</form>
</body>
<script type="text/javascript">
function onSave(){
	var param = window.location.search;
	$.ajax({
		url:'<%=basePath%>DES/FlowSkip.do'+param,
		type:'post', //数据发送方式
		dataType:'json', //接受数据格式
		data:$('#form1').serialize(),
		async: false ,
		error: function(data){},
		success: function(data){
			json = eval(data);
			if(json.success){
				alert(json.msg);
			}else{
				alert(json.msg);
			}
		}
	});
}
function onClose(){
	window.close();
}
</script>
</html>