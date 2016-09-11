<%@page import="cn.jflow.system.ui.core.ToolBar"%>
<%@page import="BP.WF.Entity.ReturnWorkAttr"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
</head>
<body>
	<div class="am-g">
		<div class="am-u-sm-12">
			<form class="am-form">
				<table class="am-table am-table-striped am-table-hover table-main">
					<thead>
						<tr>
							<TH class='table-title'>来自节点</TH>
							<TH class='table-title'>退回人/时间</TH>
						</tr>
					</thead>
					<tbody>
						<%
							String FK_Node = request.getParameter("FK_Node");
							String WorkID = request.getParameter("WorkID");
							String FK_Flow = request.getParameter("FK_Flow");
							ReturnWorks rws = new ReturnWorks();
							rws.Retrieve(ReturnWorkAttr.ReturnToNode, FK_Node,
									ReturnWorkAttr.WorkID, WorkID, ReturnWorkAttr.RDT);
							if (rws.size() != 0) {
								String msgInfo = "";
								for (ReturnWork rw : ReturnWorks.convertReturnWorks(rws)) {
						%>
						<tr>
							<td><%=rw.getReturnNodeName()%></td>
							<td><%=rw.getReturnerName() + "/" + rw.getRDT()%></td>
						</tr>
						<tr><td colspan="2"><%=rw.getNoteHtml() %></td></tr>
						<%
							//System.out.print("fasdfasdfasdf" + rw.getNoteHtml());
								}
							}
						%>
					
					<tbody>
				</table>
			</form>
		</div>
	</div>
</body>
</html>