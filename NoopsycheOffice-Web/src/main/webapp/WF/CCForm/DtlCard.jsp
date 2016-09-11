<%@page import="cn.jflow.common.model.DtlCardModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	DtlCardModel dcm = new DtlCardModel(request,response);
	dcm.Page_Load();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="<%=basePath%>WF/Style/Frm/Tab.css' rel='stylesheet' type='text/css"/>
<link href="<%=basePath%>WF/Style/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>WF/Style/themes/icon.css" rel="stylesheet" type="text/css" />

<script src="<%=basePath%>WF/Style/Frm/jquery.idTabs.min.js" type="text/javascript"  ></script>
<script src="<%=basePath%>WF/Style/Frm/jquery.min.js" type="text/javascript" ></script>
<script src="<%=basePath%>WF/Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/jquery.easyui.min.js" type="text/javascript"></script>
<script language="javascript">
	function SaveDtlData(iframeId) {
		var iframe = document.getElementById("IF" + iframeId);
		if (iframe) {
			iframe.contentWindow.SaveDtlData()
		}
	}
</script>
</head>
<body>
	<%=dcm.UCEn1 %>
</body>
</html>