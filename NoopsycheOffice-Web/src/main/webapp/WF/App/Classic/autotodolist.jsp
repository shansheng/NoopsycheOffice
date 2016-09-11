<%@page import="BP.Web.WebUser" %>
<%@page import="BP.DA.DataTable" %>
<%@page import="BP.DA.DataRow" %>
<%@ include file="/WF/head/head1.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">

    function LogAs(fk_emp) {
        if (window.confirm('您确定要以[' + fk_emp + ']授权方式登陆处理工作吗？') == false)
            return;

        var url = '<%=basePath%>WF/Do.jsp?DoType=LogAs&FK_Emp=' + fk_emp;
        WinShowModalDialog(url, '');
        alert('登陆成功，现在您可以以[' + fk_emp + ']处理工作。');
        window.location.href = '<%=basePath%>WF/App/Classic/Todolist.jsp';
    }


</script>
</head>
<body>
	<%
    if (WebUser.getIsAuthorize() == true)
    {
        %>
	<h2>当前已经是授权状态，您不能查看授权人的被授权数据。</h2>
	<%
        return;
    }

    BP.WF.Port.WFEmps ems = new BP.WF.Port.WFEmps();
    ems.Retrieve(BP.WF.Port.WFEmpAttr.Author, WebUser.getNo());
            
    if (ems.size() == 0)
    {
    	BP.WF.Glo.ToMsg("没有人授权给您，授权待办工作为空，<a href='"+basePath+ "/WF/App/Classic/Todolist.jsp'>点击这里返回我的待办</a>。",response);
          %>

	<h2></h2>
	<%
            return;
    }
%>
	<table style="width: 99%">
		<caption>
			<div class=CaptionMsg>授权待办</div>
		</caption>
		<tr>
			<th>序</th>
			<th>标题</th>
			<th>流程</th>
			<th>停留节点</th>
			<th>发送时间</th>
			<th>授权人</th>
		</tr>
		<%
    int idx = 0;
    for (BP.WF.Port.WFEmp em : ems.ToJavaList())
    {
        DataTable dt = BP.WF.Dev2Interface.DB_GenerEmpWorksOfDataTable(em.getNo(), null);
        for (DataRow dr : dt.Rows)
        {
%>
		<tr>
			<td class="Idx"><%=idx++ %></td>
			<td><a href="javascript:LogAs('<%=em.getNo() %>')"> <%=dr.getValue("Title") %>
			</a></td>
			<td><%=dr.getValue("FlowName")%></td>
			<td><%=dr.getValue("NodeName")%></td>
			<td><%=BP.DA.DataType.ParseSysDate2DateTimeFriendly(dr.getValue("ADT").toString())%></td>
			<td><%=em.getName()%></td>
		</tr>

		<%
        }
%>
		<%
    }
%>

	</table>
</body>
</html>