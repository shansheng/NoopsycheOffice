<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="BP.DA.*"%>
<%@page import="BP.WF.*"%>
<%@page import="BP.Web.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base target="_self">
<title>发起列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<style>
.TTD {
	word-wrap: break-word;
	　　word-break: normal;
}
.Icon {
	width: 16px;
	height: 16px;
}
</style>
<link rel="stylesheet" type="text/css" href="<%=basePath %>WF/Comm/Style/Table0.css" />

<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Comm/JScript.js"></script>
<script type="text/javascript">
function NoSubmit(ev) {
    //if (window.event.srcElement.tagName == "TEXTAREA")return true;

    if (ev.keyCode == 13) {
        window.event.keyCode = 9;
        ev.keyCode = 9;
        return true;
    }
    return true;
}
</script>
</head>
<body topmargin="0" leftmargin="0" onkeypress="NoSubmit(event);" class="easyui-layout">
	<form method="post"	action="" id="form1">
		 <div id="mainPanel" region="center" border="true" border="false" class="mainPanel">
			 <table border=1px align=center width='100%'>
			 	<Caption >发起列表</Caption>
				<tr>
					<TH class='Title' nowrap="nowrap" width="5%">序</TH>
					<TH class='Title' nowrap="nowrap" width="30%">类别</TH>
					<TH class='Title' nowrap="nowrap" width="65%">流程</TH>
				</tr>
				<%
					DataTable dt = Dev2Interface.DB_GenerCanStartFlowsOfDataTable(WebUser.getNo());
							if(null != dt){
							   int i = 0;
							   for(DataRow dr : dt.Rows){
								   i++;
				%>
				<tr>
					<td class='Idx'><%=i%></td>
					<td><%=dr.getValue("FK_FlowSortText")%></td>
					<td class="TTD">
						<a href="javascript:WinOpen('<%=basePath %>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("No")%>
							&FK_Node=<%=Integer.parseInt(dr.getValue("No").toString())%>01&WorkID=0&FID=0&IsToobar=1')" >
							<img src='<%=basePath%>WF/Img/WFState/Runing.png' class='Icon' />
							<%=dr.getValue("Name")%>
						</a>
					</td>
				</tr>
	
				<%
					}}
				%>
			</table>
		 </div>
	</form>	 
</body>
</html>
