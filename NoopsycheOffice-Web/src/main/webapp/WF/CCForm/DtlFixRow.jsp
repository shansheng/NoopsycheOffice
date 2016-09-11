<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	// 明细表
	String ensName = request.getParameter("EnsName");
	// workId
	String refPKVal = request.getParameter("RefPKVal");
	// 是否可读
	boolean isReadonly = request.getParameter("IsReadonly").equals("0") ? true : false;
	String fId = request.getParameter("FID");
	String fkNode = request.getParameter("FK_Node");
	
%>
	
Hello DtlFixRow !
<hr>
EnsName = <%=ensName%>
<hr>
RefPKVal = <%=refPKVal%>
<hr>
IsReadonly = <%=isReadonly%>
<hr>
FID = <%=fId%>
<hr>
FK_Node = <%=fkNode%>
<hr>