<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<script type="text/javascript">
		function Editsave()
		{
			$("#form1").attr("action","<%=basePath%>mapdef/S1EditSave.do?FK_MapData=${FK_MapData }&FK_Flow=${FK_Flow }&RptNo=${RptNo}");
			$("#form1").submit();
		}
		function load() {
			var success = document.getElementById("success").value;
			if (success == "" || success == null) {
				return;
			} else {
				alert(success);
			}

		}
		function Btn_SaveAndNext1()
		{
			$("#form1").attr("action","<%=basePath%>mapdef/S1EditSaveAndNext1.do?FK_MapData=${FK_MapData }&FK_Flow=${FK_Flow }&RptNo=${RptNo}");
			$("#form1").submit();
		}
</script>
</head>
<body class="easyui-layout" onload="load()">
<input type="hidden" value="${success }" id="success" />
	<form method="post"
		action=""
		id="form1">
		<div class="aspNetHidden">
			<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
			<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT"
				value="" /> <input type="hidden" name="__VIEWSTATE"
				id="__VIEWSTATE"
				value="/wEPDwUKMTgzMjE3OTMyMg9kFgJmD2QWAgIDD2QWAmYPZBYCAgEPDxYEHgRUZXh0BQhORDdNeVJwdB4HRW5hYmxlZGhkZGRHnWYWQqkSvmDQmSlJIH7xY3slgUzcrQrSZDc4Nd27wQ==" />
		</div>

		<script type="text/javascript">
			//<![CDATA[
			var theForm = document.forms['form1'];
			if (!theForm) {
				theForm = document.form1;
			}
			function __doPostBack(eventTarget, eventArgument) {
				if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
					theForm.__EVENTTARGET.value = eventTarget;
					theForm.__EVENTARGUMENT.value = eventArgument;
					theForm.submit();
				}
			}
			//]]>
		</script>

		<div class="aspNetHidden">

			<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
				value="/wEdAAfZ8mdpe6/VBeH8pijlsTCFEAc1dcveJS23cjyZqnBy1tggmtYHm6jtETOmuWA51O6z0BrBuYIPIw+Ylq2ENwAhXh1X5FKR93XyaIqmQ29bi/snElifUr8SrVLIMptiNUff/xjPD0LyLV2s7L0JHC/WEnG+LKGhsf9T8UC3PptZhqxENa4C473w3udUnLwGTtY=" />
		</div>
		<div data-options="region:'center',title:'1. 基本信息',border:false"
			style="padding: 5px; height: auto">

			<table class='Table' cellpadding='0' cellspacing='0'
				style='width: 100%;'>
				<tr>
					<td class="GroupTitle">编号:</td>
					<td><input name="TB_No" type="text"
						value="${TB_No }" id="TB_No"
						disabled="${disabled }" class="aspNetDisabled" /></td>
				</tr>
				<tr>
					<td class="GroupTitle">名称:</td>
					<td><input name="TB_Name"
						type="text" value="${TB_Name }"
						id="TB_Name" /></td>
				</tr>
				<tr>
					<td class="GroupTitle">备注:</td>
					<td><input name="TB_Note"
						type="text" value="${TB_Note }" id="TB_Note" /></td>
				</tr>
			</table>
			<br /> <br /> <a id="Btn_Save1"
				class="easyui-linkbutton" data-options="iconCls:&#39;icon-save&#39;"
				href="javascript:Editsave()">保存</a>
			<a id="Btn_SaveAndNext1"
				class="easyui-linkbutton" data-options="iconCls:&#39;icon-save&#39;"
				href="javascript:Btn_SaveAndNext1()">保存并继续</a>
			<a id="Btn_Cancel1" class="easyui-linkbutton"
				data-options="iconCls:&#39;icon-undo&#39;"
				href=")">取消</a>

		</div>
	</form>
</body>
</html>
