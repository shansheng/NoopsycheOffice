<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	AutoFullModel afm = new AutoFullModel(request, response);
	afm.init();
%>
<html>
<script type="text/javascript">
	function save_data(){
	/* 	var param = window.location.search;*/
	var s='<%=afm.getRefNo()%>';
	var b='<%=afm.getFK_MapData()%>';
	$("#formHtml").val($("#form1").html());
	$("#refNo").val(s);
	$("#fK_MapData").val(b);
		 $.ajax({
			  url:"<%=basePath%>/WF/MapDef/save_data.do",
			  type:'post',
			  dataType:'html',
			  data:$('#form1').serialize(),
			  async : false,
			  success : function(data) {
			   	alert(data);
			    window.location.reload();
			  }
			 });
	}
	function save_data_cancel(){
			/* 	var param = window.location.search;*/
			var s='<%=afm.getRefNo()%>';
			var b='<%=afm.getFK_MapData()%>';
			$("#formHtml").val($("#form1").html());
			$("#refNo").val(s);
			$("#fK_MapData").val(b);
			$.ajax({
				url:"<%=basePath%>/WF/MapDef/save_data.do",
				type : 'post',
				dataType : 'html',
				data : $('#form1').serialize(),
				async : false,
				success : function(data) {
					if(data=="保存成功"){
						window.close();
					}else{
						alert(data);
					}
					
				}
		});
	}
</script>
<body>
	<div class="easyui-layout" data-options="fit:true">
		<form action="" method="post" id="form1" name="form1">
			<input type="hidden" id="fK_MapData" name="fK_MapData"> 
			<input type="hidden" id="refNo" name="refNo">
		    <input type="hidden" id="formHtml" name="formHtml">
			<div data-options="region:'west',split:true,title:'功能列表'" style="width: 200px">
				<%=afm.Left.toString()%>
			</div>
			<div data-options="region:'center',title:'数据获取'" style="padding: 5px">
				<%=afm.Pub1.toString()%>
			</div>
		</form>
	</div>
</body>
</html>