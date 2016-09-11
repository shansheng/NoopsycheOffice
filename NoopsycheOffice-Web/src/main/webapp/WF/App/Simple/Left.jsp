<%@page import="BP.WF.Glo"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String basePath = Glo.getCCFlowAppPath();
    %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="../../Comm/Style/Table.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding-top: 40px">
    <form id="form1">
    <fieldset>
    <legend>流程基础功能</legend>
    <%
        if (WebUser.getNo().equals("Guest"))
            Dev2Interface.Port_SigOut();
           %>
  
  <ul>
  <li><a href="Start.jsp" target="main">发起</a></li>
  <li><a href="ToDoList.jsp" target="main">待办(<%=Dev2Interface.getTodolist_EmpWorks()%>)</a></li>
  <li><a href="Runing.jsp" target="main">在途(<%=Dev2Interface.getTodolist_Runing()%>)</a></li>
  <li><a href="Complete.jsp" target="main">已完成(<%=Dev2Interface.getTodolist_Complete() %>)</a></li>
  </ul>
    </fieldset>
 
   <fieldset>
    <legend>流程高级功能</legend>
    <ul>
  <li><a href="<%=basePath %>WF/TaskPoolSharing.jsp" target="main">共享任务(<%=Dev2Interface.getTodolist_Sharing()%>)</a></li>
    <li><a href="CC.jsp" target="main">抄送(<%=Dev2Interface.getTodolist_CCWorks()%>)</a></li>
    <li><a href="<%=basePath %>WF/Batch.jsp" target="main">批处理</a></li>
    <li><a href="<%=basePath %>WF/GetTask.jsp" target="main">取回审批</a></li>
 <!-- 
  <li><a href="/WF/Search.htm" target="main">高级查询</a></li>
  -->
 

    </ul>
    </fieldset>
 <!-- 
    <fieldset>
    <legend>组织结构</legend>
    <ul>
    <li><a href="/WF/Comm/Search.jsp?EnsName=BP.Port.Depts" target="main">部门维护</a></li>
    <li><a href="/WF/Comm/Search.jsp?EnsName=BP.Port.Stations"target="main">岗位维护</a></li>
    <li><a href="/WF/Comm/Search.jsp?EnsName=BP.Port.Emps"target="main">人员维护</a></li>
    </ul>
    </fieldset>
 -->

    <fieldset>
    <legend>系统维护</legend>
    <ul>
    <li><a href="<%=basePath %>WF/Comm/Search.jsp?EnsName=BP.Port.Depts" target="main">部门维护</a></li>
    <li><a href="<%=basePath %>WF/Comm/Search.jsp?EnsName=BP.Port.Stations" target="main">岗位维护</a></li>
    <li><a href="<%=basePath %>WF/Comm/Search.jsp?EnsName=BP.Port.Emps" target="main">人员维护</a></li>
    </ul>
    </fieldset>

    </form>
</body>
</html>
