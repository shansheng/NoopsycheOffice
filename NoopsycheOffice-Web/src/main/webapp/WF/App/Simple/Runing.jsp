<%@page import="BP.WF.Glo"%>
<%@page import="BP.Sys.SystemConfig"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.DA.DataRow"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	String path = Glo.getCCFlowAppPath();
	%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在途</title>

<script type="text/javascript">
	// 撤销。
	function UnSend(appPath, fk_flow, workid) {
		if (window.confirm('您确定要撤销本次发送吗？') == false)
			return;
		var url = appPath + 'WF/Do.jsp?DoType=UnSend&WorkID=' + workid
				+ '&FK_Flow=' + fk_flow;
		window.location.href = url;
		return;
	}
	function Press(appPath, fk_flow, workid) {
		var url = appPath + 'WF/WorkOpt/Press.jsp?WorkID=' + workid
				+ '&FK_Flow=' + fk_flow;
		var v = window
				.showModalDialog(url, 'sd',
						'dialogHeight: 220px; dialogWidth: 430px;center: yes; help: no');
	}
	function CopyAndStart(appPath, fk_flow, CopyFormNode, CopyFormWorkID) {
		var url = appPath + 'WF/MyFlow.jsp?CopyFormWorkID=' + CopyFormWorkID
				+ '&CopyFormNode=' + CopyFormNode + '&FK_Flow=' + fk_flow;
		var v = window
				.open(url, 'sd',
						'dialogHeight: 220px; dialogWidth: 430px;center: yes; help: no');
	}

	function WinOpenCC(ccid, fk_flow, fk_node, workid, fid, sta) {
		var url = '';
		if (sta == '0') {
			url = '<%=path%>WF/Do.jsp?DoType=DoOpenCC&FK_Flow=' + fk_flow + '&FK_Node='
					+ fk_node + '&WorkID=' + workid + '&FID=' + fid + '&Sta='
					+ sta + '&MyPK=' + ccid + "&T=" + dateNow;
		} else {
			url = '<%=path%>WF/WorkOpt/OneWork/Track.jsp?FK_Flow=' + fk_flow
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
		在途 (<%=Dev2Interface.getTodolist_Runing()%>)
	</h2>
	<%
		//获取在途工作。
		DataTable dt = null;
		if (SystemConfig.getAppSettings().get("IsAddCC").equals("1"))
		    dt = Dev2Interface.DB_GenerRuning();
		else
		    dt = Dev2Interface.DB_GenerRuningAndCC();
		
		// 输出结果
	%>
	<table border="1" widht='90%'>
		<tr>
			<th>标题</th>
			<th>流程</th>
			<th>发起时间</th>
			<th>发起人</th>
			<th>停留节点</th>
			<th>当前处理人</th>
			<th>操作</th>
		</tr>
		<%
			int size = dt.Rows.size();
			for (int i = 0; i < size; i++) {
				DataRow dr = dt.Rows.get(i);
                String WorkID = dr.getValue("WorkID") == null ? "0" : dr.getValue("WorkID").toString();
                String FK_Flow = dr.getValue("FK_Flow") == null ? "" : dr.getValue("FK_Flow").toString();
                String FK_Node = dr.getValue("FK_Node") == null ? "" : dr.getValue("FK_Node").toString();
                String TodoEmps = dr.getValue("TodoEmps") == null ? "" : dr.getValue("TodoEmps").toString();
                String StarterName = dr.getValue("StarterName") == null? "" : dr.getValue("StarterName").toString();
                String RDT = dr.getValue("RDT") == null ? "" : dr.getValue("RDT").toString();
                String FlowName = dr.getValue("FlowName") == null ? "" : dr.getValue("FlowName").toString();
                String NodeName = dr.getValue("NodeName") == null ? "" : dr.getValue("NodeName").toString();
                String Title = dr.getValue("Title") == null ? "" : dr.getValue("Title").toString();
                String FID = dr.getValue("FID") == null ? "0" : dr.getValue("FID").toString();
		%>
		<tr>
			<td>
				<a href="<%=path%>WF/WFRpt.jsp?FK_Flow=<%=FK_Flow%>&WorkID=<%=WorkID%>" target="_blank"> <%=Title%></a>  
			</td>
			<td><%=FlowName%></td>
			<td><%=RDT%></td>
			<td><%=StarterName%></td>
			<td><%=NodeName%></td>
			<td><%=TodoEmps%></td>
			<td>
				<%
					if (FID.equals("0")) {
				%> [<a href="<%=path%>WF/DeleteWorkFlow.jsp?FK_Flow=<%=FK_Flow%>&WorkID=<%=WorkID%>" target=_blank>删除</a>] <%
					}else {
				%> [<a href="<%=path%>WF/WorkOpt/UnSend.jsp?FK_Flow=<%=FK_Flow%>&WorkID=<%=WorkID%>" target=_blank>撤销发送</a>] -[<a
				href="javascript:CopyAndStart('<%=path%>','<%=FK_Flow%>','<%=FK_Node%>','<%=WorkID%>')">Copy发起</a>]
				<%
					}
				%> -[<a href="javascript:Press('<%=path%>','<%=FK_Flow%>','<%=WorkID%>')">催办</a>]
			</td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>