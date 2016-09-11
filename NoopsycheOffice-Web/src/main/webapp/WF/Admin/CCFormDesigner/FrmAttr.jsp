<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	//根据不同表单类型，转向不同的表单属性设置界面.
	String frmID = request.getParameter("FrmID");
	BP.Sys.Frm.MapData md = new BP.Sys.Frm.MapData(frmID);
	
	if (md.getHisFrmType() == BP.Sys.Frm.FrmType.FreeFrm || md.getHisFrmType() == BP.Sys.Frm.FrmType.Column4Frm)
	{
	    response.sendRedirect("../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.MapDataExts&PK=" + frmID);
	    return;
	}
	
	if (md.getHisFrmType() == BP.Sys.Frm.FrmType.Url)
	{
		response.sendRedirect("../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.MapDataURLs&PK=" + frmID);
	    return;
	}
	
	if (md.getHisFrmType() == BP.Sys.Frm.FrmType.WordFrm)
	{
		response.sendRedirect("../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.MapDataWords&PK=" + frmID);
	    return;
	}
	
	if (md.getHisFrmType() == BP.Sys.Frm.FrmType.ExcelFrm)
	{
		response.sendRedirect("../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.MapDataExcels&PK=" + frmID);
	    return;
	}
%>