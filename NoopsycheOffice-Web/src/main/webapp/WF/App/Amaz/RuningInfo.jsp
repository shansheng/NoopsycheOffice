<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.jflow.common.model.RuningModel"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String PageID = request.getParameter("PageID") == null ? ""
			: request.getParameter("PageID");
	String PageSmall = request.getParameter("PageSmall") == null ? ""
			: request.getParameter("PageSmall");
	String FK_Flow = request.getParameter("FK_Flow") == null ? ""
			: request.getParameter("FK_Flow");
	String GroupBy = request.getParameter("GroupBy") == null ? ""
			: request.getParameter("GroupBy");

	if ("".equals(PageID)) {
		PageID = request.getAttribute("PageID") == null ? "" : request
				.getAttribute("PageID").toString();
	}
	if ("".equals(PageSmall)) {
		PageSmall = request.getAttribute("PageSmall") == null ? ""
				: request.getAttribute("PageSmall").toString();
	}
	if ("".equals(FK_Flow)) {
		FK_Flow = request.getAttribute("FK_Flow") == null ? ""
				: request.getAttribute("FK_Flow").toString();
	}
	if ("".equals(GroupBy)) {
		GroupBy = request.getAttribute("GroupBy") == null ? ""
				: request.getAttribute("GroupBy").toString();
	}

	RuningModel model = new RuningModel(basePath, FK_Flow, GroupBy,
			PageID, PageSmall);
	model.init();
%>
<form method="post" action="" class="am-form" id="form1">
	<%=model.Pub1%>
	<!-- <ul class="am-pagination am-pagination-right">
		<li class="am-disabled"><a href="#">&laquo;</a></li>
		<li class="am-active"><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>
		<li><a href="#">5</a></li>
		<li><a href="#">&raquo;</a></li>
	</ul> -->
</form>
