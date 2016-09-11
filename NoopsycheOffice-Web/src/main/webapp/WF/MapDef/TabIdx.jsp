<%@page import="BP.WF.TabIdx"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	
	TabIdx ti =new TabIdx(request,response);
	ti.Page_Load(request,response);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置Tab键的顺序</title>
</head>
<body>
	<form id="form1" method="post">
		<table width='80%' align=center>
			<tr>
				<td valign=top><%=ti.Pub1 %></td>
			 </tr>
		</table>
	</form>
</body>
</html>