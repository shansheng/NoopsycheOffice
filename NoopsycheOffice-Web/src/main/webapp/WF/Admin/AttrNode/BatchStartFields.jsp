<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@page import="java.util.*"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	BatchStartFieldsModel bsfmodel = new BatchStartFieldsModel(request,response);
	bsfmodel.Page_Load();
%>
<script type="text/javascript">

function getAllCheck()
{
	var str="";
	$("input[type='checkbox']:checked").each(function() 
		{
			str += $(this).attr("value")+",";
  		})
	return str;
}
	

function btn_Save_Click() {
	var btnId="Btn_Save";
	var fk_flow = '<%=bsfmodel.getFK_Flow()%>';
	var fk_node='<%=bsfmodel.getFK_Node()%>';	
	var tBcount = document.getElementById("TB_Num").value;
	if(tBcount==null || tBcount== ""){
		alert("请输入批处理的行数");
		return ;
	}
	var BatchRole = $("#DDL_BRole").val();
	var sBatchParas=getAllCheck();
	location.href="<%=basePath%>batchStartFields/BatchStartFields_Btn_Save.do?FK_Flow="+ fk_flow+ "&FK_Node="+ fk_node+ "&BatchRole="+ BatchRole+ "&BatchListCount="+ tBcount+ "&BatchParas="+ sBatchParas+ "&btnId=" + btnId;
	}
	
function load() {
	var successStr = $("#success").val();
	if (successStr.length == 0) 
	{
		return;
	} else {
		alert(successStr);
	}
}
</script>
</head>
<body  onload="load();">
	<form method="post" action="" id="form1">
	<input type="hidden" id="success" value="${success }" />
		<div id="rightFrame" data-options="region:'center',noheader:true;scrolling:auto;">
			<div class="easyui-layout" data-options="fit:true;scrolling:auto;">
				<input type="hidden" name="txtRole" id="txtRole" value="<%=bsfmodel.srole %>" />
				<table style="width: 70%;">
					<caption>批量发起规则设置</caption>
					<tr>
						<td colspan="1">规则设置：</td>
						<td colspan="2">
							<select name="DDL_BRole" id="DDL_BRole">
							</select>
						</td>
						<td><a href="http://ccbpm.mydoc.io/?v=5404&t=17920" target="_blank">帮助</a></td>
					</tr>
					<tr>
						<td colspan="1">显示的行数：</td>

						<td colspan="2">
							<input name="TB_Num" type="text" value="<%=bsfmodel.tbNum %>" id="TB_Num" style="width: 56px;" />
						</td>
						<td>0表示显示所有</td>
					</tr>
					<tr>
						<td class="Sum" colspan="4">批量发起字段(需要填写的字段.)</td>
					</tr>


					<tr>
						<td colspan="4">

							<table style="width: 100%;">
								<tr>
									<th>序</th>
									<th>字段</th>
									<th>名称</th>
									<th>类型</th>
								<c:forEach items="<%=bsfmodel.getFiledList() %>" var="s" varStatus="i">
								 <tr>
									<td class="Idx">${i.count }</td>
									<td><input name="CB_Node" type="checkbox"  ${s.checked }
										value="${s.KeyOfEn }" />${s.KeyOfEn }</td>
									<td>${s.name }</td>
									<td>${s.LGTypeT }</td>
								</tr>
								</c:forEach>
								
							</table>

						</td>
					</tr>

					<tr>
						<td colspan="4">
							<!-- <input type="submit" name="Btn_Save" value="保存" id="Btn_Save" /> -->
							<a href="javascript:btn_Save_Click()" id="Btn_Save" name="Btn_Save" class="easyui-linkbutton l-btn" iconcls="icon-save"> 保存</a>
						</td>
					</tr>
				</table>

			</div>
		</div>
	</form>
</body>
</html>