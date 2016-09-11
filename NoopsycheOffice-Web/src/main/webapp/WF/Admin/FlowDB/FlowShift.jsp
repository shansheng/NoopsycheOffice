<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	FlowShiftModel flowShif = new FlowShiftModel(request, response, basePath);
	flowShif.init();
%>
</head>
<body class="easyui-layout" leftmargin="0" topmargin="0">
	<form method="post" action="" class="am-form" id="form1">
		<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div>
		<fieldset>
  			<legend>工作请选择要把此工作移交的人员</legend>
  			请输入人员编号:<input name="TB_Emp" type="text" id="TB_Emp" style="width:159px;" />
 			<br>
  			原因:
  			<br>
  			<textarea name="TB_Note" rows="2" cols="20" id="TB_Note" style="height:91px;width:336px;"></textarea>
  			说明:只能输入一个人员编号.
			&nbsp;<hr>
      		<input type="button" name="Btn_OK" value="确定移交" id="Btn_OK" onclick="onSave();" />
      		<input type="button" name="Btn_Cancel" value="取消并关闭" id="Btn_Cancel" onclick="onClose();"/>
  		</fieldset>
		</div>
	</form>
</body>
<script type="text/javascript">
function onSave(){
	var param = window.location.search;
	$.ajax({
		url:'<%=basePath%>DES/FlowForward.do'+param,
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