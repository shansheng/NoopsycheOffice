<%@page import="cn.jflow.common.model.RefMethodModel"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	RefMethodModel methodModel = new RefMethodModel(request, response);
	methodModel.loadPage();
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<base target="_self" />
<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"></script>
 <script language="JavaScript" src="JScript.js"></script>
    <script language="JavaScript" src="Menu.js"></script>
    <base target="_self" />
    <link href="./Style/Table.css" type="text/css" rel="stylesheet">
    <link href="./Style/Table0.css" type="text/css" rel="stylesheet">

</head>
<body onkeypress="javascript:Esc();" leftmargin="0" topmargin="0">
    <form id="form_id" method="post" action="<%=basePath %>WF/Comm/doRefClick.do">
    <input type="hidden" name="EnsName" value="<%=request.getParameter("EnsName")%>">
    <input type="hidden" name="Index" value="<%=request.getParameter("Index")%>">
    <input type="hidden" name="No" value="<%=request.getParameter("No")%>">
    <input type="hidden" name="WorkID" value="<%=request.getParameter("WorkID")%>">
    <table id="Table1" cellspacing="1" cellpadding="1" width="100%" border="1" class="Table"
        border="0">
       <caption class=ToolBar >
       		<%=methodModel.Label1 %>
          </caption>
        <tr>
            <td class="TD">
            <input type="submit" id="btnSave" value="执行"/>
            <input type="button" id="btnClose" value="关闭" onclick="window.close();"/>
            </td>
        </tr>
        <tr>
            <td class="TD">
                <%=methodModel.uc_en %>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>