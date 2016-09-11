
<%@page import="BP.WF.Glo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.Sys.SystemConfig"%>
<%@page import="BP.WF.Dev2Interface"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<br>
	<div style="float: left; vertical-align: middle; margin-left: 20px">
		<h3>
			<%=SystemConfig.getSysName()%>
		</h3>
	</div>

	<h4>
		<div style="float: right; vertical-align: middle; margin-right: 20px">
			<%
				if (WebUser.getNo() == null) {
			%>
			[<a href="Login.jsp" target="_top">登录</a>] - [<a
				href='<%=Glo.getCCFlowAppPath() %>WF/Admin/CCBPMDesigner/Login.jsp' target="_top">进入流程设计器</a>]
			<%
				} else {
			%>
			[您好:<%=WebUser.getNo()%>,<%=WebUser.getName()%>] - [<a
				href="Login.jsp" target="_top">重登录</a>] -[<a
				href="Login.jsp?DoType=Out" target="_top">退出</a>]- [<a
				href='<%=Glo.getCCFlowAppPath() %>WF/Admin/CCBPMDesigner/Login.jsp' target="_top">进入流程设计器</a>]
			<%
				}
			%>
		</div>
	</h4>

</body>
</html>