<%@page import="cn.jflow.model.wf.rpt.S6_PowerModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	S6_PowerModel s = new S6_PowerModel(request, response);
%>
<script type="text/javascript">
	function OpenUrl(wintitle, rpt, rptNo ,num) {
		var dlg = $('#win').dialog({
			title : wintitle,
			onClose : function() {
				$('#winFrame').attr('src', '');
			}
		});
		dlg.dialog('open');
		$('#winFrame').attr('src',"<%=basePath%>WF/Comm/RefFunc/Dot2DotSingle.jsp?EnsName=BP.WF.Template.Rpt.MapRpts&EnName=BP.WF.Template.Rpt.MapRpt&AttrKey=BP.WF.Template.Rpt."+ rpt + "&No=" + rptNo+"&num="+num);
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',title:'5. 设置报表权限',border:false"
		style="padding: 5px; height: auto">
		<fieldset>
			<legend>查看权限控制</legend>
			[ ]任何人都可以查看，流程数据。 [ ]具有如下 {岗位/部门} 的可以查看。 岗位 部门. [
			]如下指定的人可以查看,请配置一个sql.
		</fieldset>

		---- 部门数据权限 ------------ 【】可查看所有部门数据。 【】可查看本部门数据。 【】 可查看本部门，本部门子级部门数据。
		【】仅可以查看我参与的流程数据。 【】可以查看指定部门的流程数据。
		<ul class="navlist">
			<li>
				<div>
					<a
						href="javascript:OpenUrl('1. 岗位权限', 'RptStations','<%=s.getRptNo()%>','1')"><span
						class="nav"> 1. 岗位权限</span></a>
				</div>
			</li>
			<li>
				<div>
					<a
						href="javascript:OpenUrl('2. 部门权限', 'RptDepts','<%=s.getRptNo()%>','2')"><span
						class="nav"> 2. 部门权限</span></a>
				</div>
			</li>
			<li>
				<div>
					<a
						href="javascript:OpenUrl('3. 人员权限', 'RptEmps','<%=s.getRptNo()%>','3')"><span
						class="nav"> 3. 人员权限</span></a>
				</div>
			</li>
		</ul>
		<br /> <br /> <a id="Btn_Cancel1" class="easyui-linkbutton"
			data-options="iconCls:&#39;icon-undo&#39;"
			href="javascript:window.close();">取消</a>

		<div id="win" class="easyui-dialog"
			data-options="resizable:true,modal:true,closed:true" title=""
			style="width: 520px; height: 321px">
			<iframe id="winFrame" frameborder="0" scrolling="auto" src=""
				style="width: 100%; height: 100%"></iframe>
		</div>
	</div>
</body>
</html>

