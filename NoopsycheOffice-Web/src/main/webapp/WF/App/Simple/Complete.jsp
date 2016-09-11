<%@page import="BP.DA.DataRow"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.Sys.SystemConfig"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	String basePath = Glo.getCCFlowAppPath();
	%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>已完成</title>
<script type="text/javascript">
	function WinOpenCC(ccid, fk_flow, fk_node, workid, fid, sta) {
		var url = '';
		if (sta == '0') {
			url = '<%=basePath %>WF/Do.jsp?DoType=DoOpenCC&FK_Flow=' + fk_flow + '&FK_Node='
					+ fk_node + '&WorkID=' + workid + '&FID=' + fid + '&Sta='
					+ sta + '&MyPK=' + ccid + "&T=" + dateNow;
		} else {
			url = '<%=basePath %>WF/WorkOpt/OneWork/Track.jsp?FK_Flow=' + fk_flow
					+ '&FK_Node=' + fk_node + '&WorkID=' + workid + '&FID='
					+ fid + '&Sta=' + sta + '&MyPK=' + ccid + "&T=" + dateNow;
		}
		//window.parent.f_addTab("cc" + fk_flow + workid, "抄送" + fk_flow + workid, url);
		var newWindow = window.open(url, 'z');
		newWindow.focus();
	}
</script>
</head>
<body>

	<h2>
		已完成 (<%=Dev2Interface.getTodolist_Complete()%>)
	</h2>
	<%
		//获取已完成工作。
		DataTable dt = null;
		try {
			if (SystemConfig.getAppSettings().get("IsAddCC").equals("1"))
				dt = Dev2Interface.DB_FlowComplete();
			else
				dt = Dev2Interface.DB_FlowCompleteAndCC();

		} catch (Exception ex) {
			dt = Dev2Interface.DB_FlowComplete();

		}
		String path = Glo.getCCFlowAppPath();

		// 输出结果
	%>
	<table border="1" widht='90%'>
		<tr>
			<th>标题</th>
			<th>流程</th>
			<th>发起时间</th>
			<th>发起人</th>
			<th>停留节点</th>
			<th>操作</th>
		</tr>
		<%
			int size = dt.Rows.size();
			for (int i = 0; i < size; i++) {
				DataRow dr = dt.Rows.get(i);
				String workid = dr.getValue("WorkID") == null ? "0" : dr.getValue("WorkID").toString();
				String fk_flow = dr.getValue("FK_Flow") == null ? "" : dr.getValue("FK_Flow").toString();
		%>
		<tr>
			<td>
				<%
					
					if (null != dr.getValue("Type") && dr.getValue("Type").toString().equals("RUNNING")) {
				%> <a
				href="<%=basePath %>WF/WFRpt.jsp?FK_Flow=<%=fk_flow%>&WorkID=<%=workid%>"
				target="_blank"> <%=dr.getValue("Title")%>
			</a> <%
 				} else {
 			%> <a href='javascript:WinOpenCC("<%=dr.getValue("MyPk")%> "," <%=fk_flow%>  ","<%=dr.getValue("FK_Node")%> "," <%=dr.getValue("WorkID")%> ","<%=dr.getValue("FID")%>","<%=dr.getValue("Sta")%>")'>
					<%=dr.getValue("Title")%></a> <%
 				}
 			%>
			</td>
			<td><%=dr.getValue("FlowName")%></td>
			<td><%=dr.getValue("RDT")%></td>
			<td><%=dr.getValue("StarterName")%></td>
			<td><%=dr.getValue("NodeName")%></td>
			<%
				if (null != dr.getValue("Type") && dr.getValue("Type").toString().equals("RUNNING")) {
			%>
			<td><a
				href="<%=basePath %>WF/MyFlow.jsp?FK_Flow=<%=fk_flow%>&CopyFormWorkID=<%=workid%>&CopyFormNode=<%=dr.getValue("FK_Node")%>"
				target="_blank">Copy发起流程</a></td>
			<%
				} else {
			%>
			<td></td>
			<%
				}
			%>
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>