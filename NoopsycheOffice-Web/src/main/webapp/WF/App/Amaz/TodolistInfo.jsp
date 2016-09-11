<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.WF.WFState"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<form class="am-form">
	<table class="am-table am-table-striped am-table-hover table-main">
			<tr>
				<TH class='table-title'>序</TH>
				<TH class='table-title'>发起人</TH>
				<TH class='table-title'>发起时间</TH>
				<TH class='table-title'>标题</TH>
				<TH class='table-title'>接受日期</TH>
				<TH class='table-title'>应完成日期</TH>
				<TH class='table-title'>停留节点</TH>
				<TH class='table-title'>状态</TH>
				<TH class='table-title'>时效</TH>
			</tr>
			<%
				DataTable dt = Dev2Interface.DB_GenerEmpWorksOfDataTable();
				String t = DataType.dateToStr(new Date(), "MMddhhmmss");
				Date cdt = new Date();
				if (null != dt) {
					int i = 0;
						for (DataRow dr : dt.Rows) {
							i++;
							String paras = dr.getValue("AtPara") == null ? "" : dr
									.getValue("AtPara").toString();
							String isRead = dr.getValue("isRead") == null ? "" : dr
									.getValue("isRead").toString();
							int state = dr.getValue("WFState") == null ? 0 : Integer.parseInt(dr
									.getValue("WFState").toString());
							
							String str = "";
							String sxStr = "";
							WFState wfState = WFState.forValue(state);
							switch(wfState){
								case Blank:
									str = "空白";
									break;
								case Draft:
									str = "草稿";
									break;
								case Runing:
									str = "运行中";
									break;
								case Complete:
									str = "已完成";
									break;
								case HungUp:
									str = "挂起";
									break;
								case ReturnSta:
									str = "退回";
									break;
								case Shift:
									str = "移交";
									break;
								case Delete:
									str = "删除";
									break;
								case Askfor:
									str = "加签";
									break;
								case Fix:
									str = "冻结";
									break;
								case Batch:
									str = "批处理";
									break;
								case AskForReplay:
									str = "加签回复";
									break;
								default:
					                break;
							}
							
							Date mysdt = DataType.ParseSysDate2DateTime(dr.getValue("SDT").toString());
							
			                if (cdt.after(mysdt) || cdt.equals(mysdt)){
			                	if(DataType.dateToStr(cdt, "yyyyMMdd") == DataType.dateToStr(mysdt, "yyyyMMdd")){
			                		sxStr = "<font color=green>正常</font>";
			                	}
			                	else{
			                		sxStr = "<font color=red>逾期</font>";
			                	}
			                }
			                else{
			                	sxStr = "<font color=green>正常</font>";
			                }
			%>
			<tr>
				<td nowrap="nowrap"><%=i%></td>
				<td nowrap="nowrap"><%=dr.getValue("StarterName")%></td>
				<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
				<%
					if ("0".equals(isRead)) {
				%>
				<td nowrap="nowrap"><a
					href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
						<span class="am-badge am-badge-danger"><b>未阅</b></span><%=dr.getValue("Title")%>
				</a></td>
				<%
					} else {
				%>
				<td nowrap="nowrap"><a
					href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
						<span class="am-badge am-badge-success">已阅</span> <%=dr.getValue("Title")%>
				</a></td>
				<%
					}
				%>
				<td nowrap="nowrap"><%=dr.getValue("ADT") %></td>
				<td nowrap="nowrap"><%=dr.getValue("SDT") %></td>
				<td nowrap="nowrap"><%=dr.getValue("NodeName")%></td>
				<td nowrap="nowrap"><%=str%></td>
				<td nowrap="nowrap"><%=sxStr%></td>
			</tr>
				<%
						}
				}
				%>
	</table>
			<!-- 	<ul class="am-pagination am-pagination-right">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul> -->
</form>
