<%@page import="BP.Web.WebUser"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.WF.Dev2Interface"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; 
%>
<ul class="am-list admin-sidebar-list">
	<li class="admin-parent"><a href="Home.jsp" class="am-cf"
				target="right"><img src='<%=basePath%>WF/Img/Start.png' /> 工作台</a></a>
	<li class="admin-parent"><a class="am-cf"
		data-am-collapse="{target: '#collapse-nav'}"> <span
			class="am-icon-reorder"></span> 基本功能<span
			class="am-icon-angle-right am-fr am-margin-right"></span></a>
		<ul class="am-list am-collapse admin-sidebar-sub am-in"
			id="collapse-nav">
			<li><a href="Start.jsp" target="right"><span 
				class="am-icon-th"></span> 发起</a></li>
			<li><a href="Todolist.jsp" target="right"><span
					class="am-icon-recycle"></span> 待办(<%=Dev2Interface.getTodolist_EmpWorks()%>)</a></li>
			<li><a href="Runing.jsp" target="right"><span
					class="am-icon-pencil-square-o"></span> 在途(<%=Dev2Interface.getTodolist_Runing()%>)</a></li>
			<li><a href="<%=basePath%>WF/CC.jsp" target="right"><span
					class="am-icon-puzzle-piece"></span> 抄送(<%=Dev2Interface.getTodolist_CCWorks()%>)</a></li>

			<%
				if (Glo.getIsEnableTaskPool()) {
			%>
			<li><a href="<%=basePath%>WF/TaskPoolSharing.jsp" target="right"><span
					class="am-icon-bookmark"></span> 共享任务</a></li>
			<%-- d.add(106, 100, "共享任务", "TaskPoolSharing.jsp"); --%>
			<%
				}
			%>

			<li><a href="<%=basePath%>WF/FlowSearch.jsp" target="right"><span
					class="am-icon-search"></span> 查询</a></li>

			<%-- <li><a href="Complete.jsp" target="right"><span
					class="am-icon-angellist"></span> 已完成(<%=Dev2Interface.getTodolist_Complete()%>)</a></li> --%>
			<li><a href="<%=basePath %>WF/Tools.jsp" target="right"><span
					class="am-icon-cog"></span> 设置</a></li>
		</ul></li>


	<li class="admin-parent"><a class="am-cf"
		data-am-collapse="{target: '#qita'}"> <img src='<%=basePath%>WF/Img/Sun.png'   width="24px" />&nbsp;高级功能<span
			class="am-icon-angle-right am-fr am-margin-right"></span></a>
		<ul class="am-list am-collapse admin-sidebar-sub  am-in" id="qita">
			<li><a href="<%=basePath%>WF/HungUpList.jsp" target="right"><span
					class="am-icon-check-square-o"></span> 挂起(<%=Dev2Interface.getTodolist_HungUpNum()%>)</a></li>
			<li><a href="<%=basePath%>WF/Batch.jsp" target="right"><span
					class="am-icon-th"></span> 批处理</a></li>
			<li><a href="<%=basePath%>WF/GetTask.jsp" target="right"><span
					class="am-icon-check"></span> 取回审批</a></li>
			<li><a href="<%=basePath%>WF/Emps.jsp" target="right"><span
					class="am-icon-user"></span> 成员</a></li>
			<%-- <li><a href="#" target="right"><span
					class="am-icon-envelope"></span> 系统信息</a></li>
			<li><a href="<%=basePath%>WF/Tools.jsp" target="right"><span
					class="am-icon-cog"></span> 设置</a></li> --%>
		</ul></li>
	<%
		if (WebUser.getNo().equals("admin")) {
	%>
	<li class="admin-parent"><a class="am-cf"
		data-am-collapse="{target: '#organizational_management'}">
                            <img src='<%=basePath%>WF/Img/Org.png' width="24px" />&nbsp;组织结构管理<span
			class="am-icon-angle-right am-fr am-margin-right"></span></a>
		<ul class="am-list am-collapse admin-sidebar-sub  am-in"
			id="organizational_management">
			<li><a
				href="<%=basePath%>WF/Comm/Search.jsp?EnsName=BP.Port.Depts"
				target="right"><i class="am-icon-mail-forward"></i> 部门维护</span></a></li>
			<li><a
				href="<%=basePath%>WF/Comm/Search.jsp?EnsName=BP.Port.Stations"
				target="right"><i class="am-icon-random"></i> 岗位维护</span></a></li>
			<li><a
				href="<%=basePath%>WF/Comm/Search.jsp?EnsName=BP.Port.Emps"
				target="right"><span class="am-icon-user"> 人员维护</span></a></li>
		</ul></li>
	<%
		}
	%>
</ul>

