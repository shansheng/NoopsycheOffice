<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
%>
<form class="am-form" method="post" id="form1">
	<table class="am-table am-table-striped am-table-hover table-main">
			<tr>
				<TH class='table-title' nowrap="nowrap" width="5%">序</TH>
				<TH class='table-title' nowrap="nowrap">标题</TH>
				<TH class='table-title' nowrap="nowrap">流程</TH>
				<TH class='table-title' nowrap="nowrap">发起时间</TH>
				<TH class='table-title' nowrap="nowrap">发起人</TH>
				<TH class='table-title' nowrap="nowrap">停留节点</TH>
				<TH class='table-title' nowrap="nowrap">操作</TH>
			</tr>
			<%
				DataTable dt = Dev2Interface.DB_FlowComplete();
				if(null != dt){
					int i = 0;
					for(DataRow dr : dt.Rows){ 
						i++;
						String workid = dr.getValue("WorkID")==null?"":dr.getValue("WorkID").toString();
						String fk_flow = dr.getValue("FK_Flow")==null?"":dr.getValue("FK_Flow").toString();
						
						String run = dr.getValue("Type")==null?"":dr.getValue("Type").toString();
			%>
			<tr>
				<td nowrap="nowrap"><%=i%></td>
				<%
					if("RUNNING".equals(run)){
				%>
				<td nowrap="nowrap"><a
					href="javascript:WinOpen('<%=basePath%>WF/WFRpt.jsp?FK_Flow=<%=fk_flow%>&WorkID=<%=workid%>')">
						<span class='am-icon-sign-out'>
						<%=dr.getValue("Title")%>
				</a></td>
				<%
					}else{
				%>
				<td nowrap="nowrap"><a
					href='javascript:WinOpenCC("<%=dr.getValue("MyPk")%>","<%=fk_flow%>","<%=dr.getValue("FK_Node")%>","<%=workid%>","<%=dr.getValue("FID")%>","<%=dr.getValue("Sta")%>")'>
						<span class='am-icon-sign-out'>
						<%=dr.getValue("Title")%></a></td>
				<%
					}
				%>
				<td nowrap="nowrap"><%=dr.getValue("FlowName")%></td>
				<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
				<td nowrap="nowrap"><%=dr.getValue("StarterName")%></td>
				<td nowrap="nowrap"><%=dr.getValue("NodeName")%></td>
				<%
					if("RUNNING".equals(run)){
				%>
				<td nowrap="nowrap"><a
					href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=fk_flow%>&CopyFormWorkID=<%=workid%>&CopyFormNode=<%=dr.getValue("FK_Node")%>')">
						<span class='am-icon-sign-out'>
						Copy发起流程
				</a></td>
				<%
					}else{
				%>
				<td>&nbsp;</td>
				<%
					}
				%>
			</tr>
			<%
				}
				}
			%>
	</table>
</form>
<!-- <ul class="am-pagination am-pagination-right">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul>		 -->