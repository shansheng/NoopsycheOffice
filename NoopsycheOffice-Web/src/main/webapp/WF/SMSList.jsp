<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../WF/head/head2.jsp"%>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<!-- 内容 -->
	<!-- 表格数据 -->
	<table border=1px align=center width='100%'>
		<Caption ><div class='CaptionMsg' >系统消息</div></Caption>
		<!-- 数据 -->
		<div class="am-g">
			<div class="am-u-sm-12" id="listbox">
			<jsp:include page="SMSListInfo.jsp" />
			</div>
		</div>

	</table>
</body>

</html>