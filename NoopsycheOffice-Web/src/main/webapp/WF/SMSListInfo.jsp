<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="BP.Port.*"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
%>
<form class="am-form" method="post" id="form1">
	<!-- <table class="am-table am-table-striped am-table-hover table-main"> -->
		<thead>
			<tr>
				<TH class='table-title' nowrap="nowrap" width="5%">序</TH>
				<TH class='table-title' nowrap="nowrap">主题</TH>
				<!--<TH class='table-title' nowrap="nowrap">内容</TH>-->
				<TH class='table-title' nowrap="nowrap">发件人</TH>
				<TH class='table-title' nowrap="nowrap">发送时间</TH>
			</tr>
		</thead>
		<tbody>
			<%
				DataTable dt = Dev2Interface.DB_GenerPopAlert("unRead");
			
				if(null != dt){
					int i = 0;
					for(DataRow dr : dt.Rows){ 
						i++;
					
					//String workid = dr.getValue("WorkID")==null?"":dr.getValue("WorkID").toString();
					//	String fk_flow = dr.getValue("FK_Flow")==null?"":dr.getValue("FK_Flow").toString();
						
					//	String run = dr.getValue("Type")==null?"":dr.getValue("Type").toString();
			%>
			
			<%
					//DataTable dt = Dev2Interface.DB_GenerCanStartFlowsOfDataTable(WebUser.getNo());
							//if(null != dt){
							 //  int i = 0;
							  // for(DataRow dr : dt.Rows){
							//	   i++;
				%>
			<tr>
				<td nowrap="nowrap"><%=i%></td>
				<td nowrap="nowrap"><a
					href="#">
						<span class='am-icon-sign-out'>
						<%=dr.getValue("EmailTitle")%>
				</a></td>
				<!-- <td nowrap="nowrap"><%=dr.getValue("EmailDoc")%></td> -->
				<td nowrap="nowrap"><%=dr.getValue("Sender")%></td>
				<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
			</tr>
			<%
				}}
			%>
		
		<tbody>
	<!-- </table> -->
</form>
		