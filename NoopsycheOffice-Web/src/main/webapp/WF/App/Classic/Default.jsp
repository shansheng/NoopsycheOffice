<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="cn.jflow.common.model.BaseModel"%>
<%@page import="BP.WF.DoWhatList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BP.Sys.Glo"%>
<%@page import="BP.Web.WebUser"%>
<html >
<head id="Head1">
    <title><%=BP.Sys.SystemConfig.getSysName() %></title>
     
<script type="text/javascript" language="javascript">
    function ReStartSmall(url) {
        var fra = document.getElementsByName("main");
    }
</script>

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
    // 最大化窗口
    if (window.screen) {
	    var self = window;
	    self.moveTo(0, 0);
	    self.resizeTo(screen.availWidth, screen.availHeight);
	    self.focus();
    }
</script>
</head>
<frameset rows="80,*,20" frameborder="NO" border="0" framespacing="0">

        <frame src="Top.jsp" noresize="noresize" frameborder="NO" name="topFrame" scrolling="no" marginwidth="0" marginheight="0" target="main">
        </frame>

        <frameset cols="180,*" name="mainFrame" frameborder="NO" border="0" framespacing="0">
            <frame src="Left.jsp" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" target="main" ></frame>
            <frame src="<%=BP.WF.Glo.getCCFlowAppPath() %>WF/App/Classic/Start.jsp" name="main" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" ></frame>
        </frameset>
    
    <frame src="Bottom.jsp" noresize="noresize" frameborder="NO" name="btmFrame" scrolling="no" marginwidth="0" marginheight="0" target="_self"> 
    </frame>

    </frameset>

</html>
