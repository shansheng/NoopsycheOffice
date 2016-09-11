<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
</head>
<body>
	<header class="am-topbar admin-header">

		<div width="90px" class="am-topbar-brand">
			<img  src="<%=basePath%>DataUser/ICON/Smaller.png" style="height: 46px;
    			vertical-align: top;padding-top: 5px;" border="0" />
    			<strong><%=SystemConfig.getSysName()%></strong>
		</div>
		<div class="am-collapse am-topbar-collapse" id="topbar-collapse">
			<ul
				class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
				<li><a href="<%=basePath%>WF/Tools.jsp" target="right"> <img
						width="35px" id="imgIcon"
						src="<%=basePath%>DataUser/UserIcon/<%=WebUser.getNo()%>Smaller.png"
						onerror="src='<%=basePath%>DataUser/UserIcon/Default.png'"
						border="0" /> <%=WebUser.getName()%>
				</a></li>
				<!-- 必选加 am-dropdown，data-am-dropdown，超链接中必须加am-dropdown-toggle，data-am-dropdown-toggle-->
				<li><a href="<%=basePath%>WF/Logout.do" target="_parent"><span
						class="am-icon-power-off"></span> 退出</a></li>
			</ul>
		</div>

	</header>
</body>
<script type="text/javascript">
	
</script>
</html>