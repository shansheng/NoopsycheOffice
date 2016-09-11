<%@page import="BP.WF.DoWhatList"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<%
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
<frameset rows="51,92%" border="0">
	<frame src="Top.jsp" name="top" scrolling="no"></frame>
	<frameset cols="150px,800px" border="0">
		<frame src="Left.jsp" name="left" scrolling="auto"></frame>
		<frame src="Welcome.jsp" name="right" scrolling="auto"></frame>
	</frameset>
</frameset>
</html>
