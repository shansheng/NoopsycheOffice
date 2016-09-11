<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.jflow.model.wf.rpt.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	
	EasySearchMyFlowModel esmf=new EasySearchMyFlowModel(request,response);
	esmf.init();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>主页面高级查询</title>
<link href="<%=basePath%>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<style type="text/css">
a{ text-decoration: none;}
</style>
</head>
<body class="easyui-layout" onload="load()">
	<input type="hidden" id="success" value="${success }" />

	<table style="width: 100%;">
		<caption class=CaptionMsgLong>
			<a href="<%=basePath%>WF/App/Classic/Search.jsp"> <font color="#FFFFFF">按流程查询</font></a> - 高级查询</a>
		</caption>
		<tr>
			<td>
				<fieldset>
					<legend>流程查询方式</legend>
					<ul>
						<li><a href="../Comm/Search.jsp?EnsName=BP.WF.Data.MyFlows"
							target="mainS">我参与的流程</a></li>
						<li><a
							href="../Comm/Search.jsp?EnsName=BP.WF.Data.MyStartFlows"
							target="mainS">我发起的流程</a></li>
						<li><a
							href="../Comm/Search.jsp?EnsName=BP.WF.Data.MyDeptFlows"
							target="mainS">我部门发起的流程</a></li>
						<li><a
							href="../Comm/Search.jsp?EnsName=BP.WF.Data.MyDeptTodolists"
							target="mainS">我部门的待办</a></li>
						<li><a href="../KeySearch.jsp" target="mainS">关键字查询</a></li>
						<li><a href="../FlowSearch.jsp" target="mainS">按流程高级查询</a></li>
					</ul>
				</fieldset>
				<fieldset>
					<legend>流程统计方式</legend>
					<ul>
						<li><a href="../Comm/Group.jsp?EnsName=BP.WF.Data.MyFlows" style="cursor: pointer;"
							target="mainS">我参与的流程</a></li>
						<li><a
							href="../Comm/Group.jsp?EnsName=BP.WF.Data.MyStartFlows" style="cursor: pointer;"
							target="mainS">我发起的流程</a></li>
						<li><a
							href="../Comm/Group.jsp?EnsName=BP.WF.Data.MyDeptFlows" style="cursor: pointer;"
							target="mainS">我部门发起的流程</a></li>
						<li><a
							href="../Comm/Group.jsp?EnsName=BP.WF.Data.MyDeptTodolists" style="cursor: pointer;"
							target="mainS">我部门待办</a></li>
					</ul>
				</fieldset>
			</td>
			<td style="width: 80%; vertical-align: top">
				<div>
					<table style="border: 0px; width: 100%;">
						<tr>
							<td>
								<h3>我发起的流程</h3>
								<%=esmf.getMyFq()%>
							</td>
							<td>
								<h3>我的待办(待处理)</h3>
								<%=esmf.getMyDb()%>
							</td>
							<td>
								<h3>我的在途(未完成)</h3>
								<%=esmf.getMyZt()%>
							</td>
							<td>
								<h3>已归档(已完成)</h3>
								<%=esmf.getYgd()%>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</body>	
</html>