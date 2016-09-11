<%@page import="BP.WF.Glo"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.DA.DataTable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>抄送</h2>
	<%
		String ShowType = request.getParameter("ShowType");
		if (ShowType == null)
			ShowType = "0";

		//获取抄送工作。
		DataTable dt = null;
		if (ShowType.equals("0")) {
			/*未读的抄送*/
			dt = Dev2Interface.DB_CCList_UnRead(WebUser.getNo());
		}
		if (ShowType.equals("1")) {
			/*已读的抄送*/
			dt = Dev2Interface.DB_CCList_Read(WebUser.getNo());
		}
		if (ShowType.equals("2")) {
			/*删除的抄送*/
			dt = Dev2Interface.DB_CCList_Delete(WebUser.getNo());
		}

		// 输出结果
	%>
	(
	<a href='CC.jsp?ShowType=0'>未读</a>)(
	<a href='CC.jsp?ShowType=1'>已读</a>)(
	<a href='CC.jsp?ShowType=2'>删除</a>)
	<hr>
	<table border=1 widht='90%'>
		<tr>
			<th>抄送人</th>
			<th>标题</th>
			<th>流程</th>
			<th>发起时间</th>
			<th>详细信息</th>
		</tr>

		<%
			String basePath = Glo.getCCFlowAppPath();
			int size = dt.Rows.size();
			for (int i = 0; i < size; i++) {
				DataRow dr = dt.Rows.get(i);
				String workid = dr.getValue("WorkID").toString();
				String fid = dr.getValue("FID").toString();
				String fk_flow = dr.getValue("FK_Flow").toString();
				String fk_node = dr.getValue("FK_Node").toString();

				String url = basePath+"WF/WFRpt.jsp?FK_Flow=" + fk_flow + "&FK_Node="
						+ fk_node + "&WorkID=" + workid + "&FID=" + fid;
		%>
		<tr>
			<td><%=dr.getValue("Rec")%></td>
			<td><%=dr.getValue("FlowName")%></td>
			<td><%=dr.getValue("RDT")%></td>
			<td><%=dr.getValue("NodeName")%></td>
			<td><a href='<%=url%>' target="_blank">详细</a></td>
		</tr>

		<tr>
			<td colspan=5>标题：<%=dr.getValue("Title")%>
				<hr /> 抄送内容:
				<hr> <%=dr.get("Doc")%>

			</td>

		</tr>

		<%
			}
		%>
	</table>

</body>
</html>