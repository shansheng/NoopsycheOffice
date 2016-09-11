<%@page import="BP.Sys.SystemConfig"%>
<%@page import="BP.Sys.Glo"%>
<%@page import="BP.WF.DoWhatList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.Web.WebUser"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String basePath = BP.WF.Glo.getCCFlowAppPath();
	if (WebUser.getNo() == null)
	{
		response.sendRedirect("Login.jsp");
		return;
	}

	ArrayList<String> paramKeys = BP.Sys.Glo.getQueryStringKeys();
	if(paramKeys.size() > 0){
     
        String paras = "";
        for(String str : paramKeys){
        	
            String val = request.getParameter(str);
            if (val.indexOf('@') != -1)
                throw new Exception("您没有能参数: [ " + str + " ," + val + " ] 给值 ，URL 将不能被执行。");
			if (str.equals(DoWhatList.DoNode) || str.equals(DoWhatList.Emps) || str.equals(DoWhatList.EmpWorks) || str.equals(DoWhatList.FlowSearch) || str.equals(DoWhatList.Login) || str.equals(DoWhatList.MyFlow) || str.equals(DoWhatList.MyWork) || str.equals(DoWhatList.Start) || str.equals(DoWhatList.Start5) || str.equals(DoWhatList.StartSmall) || str.equals(DoWhatList.FlowFX) || str.equals(DoWhatList.DealWork) || str.equals(DoWhatList.DealWorkInSmall) || str.equals("FK_Flow") || str.equals("WorkID") || str.equals("FK_Node") || str.equals("SID"))
			{}else {
				paras += "&" + str + "=" + val;
			}
        }
        String s = BP.WF.Glo.getCCFlowAppPath()+"WF/MyFlow.jsp?FK_Flow=" +request.getParameter("FK_Flow") + paras + "&FK_Node=" + request.getParameter("FK_Node") ;
        response.getWriter().write("<script type='text/javascript'> window.open('" + s + "', '_blank', 'resizable=1,scrollbars=yes');</script>");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ccflow的极速模式</title>
<script type="text/javascript">
	//最大化窗口
	if (window.screen) {
	    var self = window;
	    self.moveTo(0, 0);
	    self.resizeTo(screen.availWidth, screen.availHeight);
	    self.focus();
	}
</script>
</head>
<frameset rows="60,*" frameborder="no" border="0" framespacing="0">
	<frame src="<%=basePath %>WF/App/Simple/Top.jsp" noresize="noresize" frameborder="0" name="topFrame" target="main" marginwidth="0" marginheight="0" scrolling="no">
	<frameset rows="*" cols="195,*" id="frame">
		<frame src="<%=basePath %>WF/App/Simple/Left.jsp" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="1" scrolling="auto">
		<frame src="<%=basePath %>WF/App/Simple/ToDoList.jsp" name="main" marginwidth="0" marginheight="0" frameborder="1" scrolling="yes">
	</frameset>
</frameset>

</html>