<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cn.jflow.model.wf.admin.ccbpm.WelcomeModel"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	WelcomeModel w=new WelcomeModel(request, response);
	w.init();
	DecimalFormat df = new DecimalFormat("#.00");  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>CCBPM2.0</title>
</title>
<script src="<%=basePath%>WF/Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/jquery/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/jquery/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Comm/Charts/js/FusionCharts.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/CommonUnite.js" type="text/javascript"></script>
<link href='<%=basePath%>WF/Comm/Style/Table0.css' rel='stylesheet' type='text/css' />
<link href='<%=basePath%>WF/Comm/Style/Tabs.css' rel='stylesheet' type='text/css' />
<style type="text/css">
.red {
	font-color: red;
}
</style>
<script type="text/javascript">
        function OpenTab(id, name, url, icon) {
            if (window.parent != null && window.parent.closeTab != null) {
                window.parent.closeTab(name);
                window.parent.addTab(id, name, url, icon);
            }
        }
        function OpenNewFlowPanel() {
            if (window.parent && window.parent.newFlow) {
                window.parent.newFlow();
            }
        }
    </script>
</head>
<body>
	<form method="post" action="./Welcome.jsp" id="form1">
		<h3>欢迎: 系统管理员</h3>
		<table style="width: 100%">
			<tr>
				<td valign="top">
					<fieldset>
						<legend>流程引擎常用功能</legend>
						<ul style="list-style: none">
							<li><a href="javascript:OpenNewFlowPanel()"> <img
									src="./Img/NewFlow.png" border="0" />&nbsp;新建流程
							</a></li>
							<li><a
								href="javascript:OpenTab('TempleteFlowSearch','关键字查询流程模版','../CCBPMDesigner/SearchFlow.jsp','icon-search');">
									<img src="./Img/SearchKey.png" alt="" border="0" />&nbsp;关键字查询流程模版
							</a></li>

							<li><a
								href="javascript:OpenTab('TempleteFlowList','流程列表','../CCBPMDesigner/Flows.jsp','icon-flows');">
									<img src="./Img/flows.png" border="0" />&nbsp;流程列表
							</a></li>
							<li><a
								href="javascript:OpenTab('TempleteFlowControl','流程监控','../CCBPMDesigner/App/Welcome.jsp','icon-Monitor');">
									<img src="./Img/Monitor.png" border="0" />&nbsp;流程监控
							</a></li>
							<li><a
								href="javascript:OpenTab('TempleteFlowGloKeys','全文检索运行流程实例','<%=basePath%>WF/KeySearch.jsp','icon-SearchKey');">
									<img src="./Img/SearchKey.png" border="0" />&nbsp;全文检索运行流程实例
							</a></li>
							<li><a
								href="javascript:OpenTab('TempleteGeneralSearch','综合查询','../../Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews','icon-Search');">
									<img src="./Img/Group.png" border="0" />&nbsp;综合查询
							</a> -<a
								href="javascript:OpenTab('TempleteGeneralAnal','综合分析','../../Comm/Group.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews','icon-Group');">分析</a>
							</li>
						</ul>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>表单引擎常用功能</legend>
						<ul style="list-style: none">
							<li><a href=""> <img src="./Img/NewFlow.png" />新建表单
							</a></li>
							<li><a href="../CCBPMDesigner/SearchFlow.jsp"> <img
									src="./Img/NewFlow.png" border="0" />关键字查询表单模版
							</a></li>
							<li><a href=""> <img src="./Img/NewFlow.png" />新建数据源
							</a></li>
							<li><a href=""> <img src="./Img/NewFlow.png" />管理数据源
							</a></li>
							<li><a href="../../Comm/Sys/EnumList.jsp?t=0.6900089763006457"> <img src="./Img/NewFlow.png" />枚举列表
							</a></li>
							<li><a href=""> <img src="./Img/NewFlow.png" />字典表列表
							</a></li>
						</ul>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>更多资源</legend>
						<ul style="list-style: none">
							<li><a
								href="http://bbs.ccflow.org/posttopic.jsp?forumid=7&forumpage=1"
								target="_blank"> 提问</a>-<a
								href="http://bbs.ccflow.org/posttopic.jsp?forumid=11&forumpage=1"
								target="_blank">Bug,建议</a>-<a
								href="http://bbs.ccflow.org/posttopic.jsp?forumid=11&forumpage=1"
								target="_blank">有偿服务</a></li>
							<li><a href="http://online.ccflow.org" target="_blank">BPM工程师培训认证网</a></li>
							<li><a href="http://jflow.cn" target="_blank">JFlow官方网站</a></li>
							<li><a href="http://ccflow.org" target="_blank">ccflow官方网站</a></li>
							<li><a href="http://ccbpm.mydoc.io" target="_blank">ccbpm在线手册</a></li>
							<li><a href="http://ccform.mydoc.io" target="_blank">ccform在线手册</a></li>

						</ul>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div style="width: 100%;">

						<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
}

.flow_info {
	padding-left: 15px;
}

.flow_font {
	color: Blue;
}

.flow_font_big {
	font-size: 14px;
	margin-left: 4px;
}

.font_red {
	color: Red;
}

.chart_div {
	width: 800px;
	height: 330px;
	margin: 0px auto;
}

.chart_div_con {
	width: 800px;
	height: 300px;
	float: left;
}

.chart_div_footer {
	width: 100%;
	height: 30px;
	text-align: center;
	line-height: 30px;
}

input {
	vertical-align: text-top;
	margin-top: 0;
}
</style>
						<script type="text/javascript">
    function loadFlowUSLChartType() {
        var str1 = $('input:radio[name=anaTime]:checked').val();
        var str2 = $('input:radio[name=flowSort]:checked').val();

        window.location.href = "Welcome.jsp?anaTime=" + str1 + "&flowSort=" + str2 + "&";
    }
    $(function () {
        $("#" + Application.common.getArgsFromHref("anaTime")).attr("checked", true);
        $("#" + Application.common.getArgsFromHref("flowSort")).attr("checked", true);
    });
</script>
						<table style="margin: 0 auto; width: 100%;">
							<tr>
								<td valign="top" colspan="3"
									style="padding-left: 10px; padding-right: 40px; border-bottom: 1px solid white;">
									流程图表分析: <input style="margin-left: 32px;" type="radio"
									id="slMouth" name="anaTime" onclick="loadFlowUSLChartType();"
									value="slMouth" checked="checked" /><label for="slMouth">按月（最近12月）</label>
									<input type="radio" id="slWeek" name="anaTime"
									onclick="loadFlowUSLChartType();" value="slWeek" /><label
									for="slWeek">按周（最近15周）</label> <input type="radio" id="slDay"
									name="anaTime" onclick="loadFlowUSLChartType();" value="slDay" /><label
									for="slDay">按日（最近10天）</label>&nbsp;&nbsp;&nbsp;分析维度： <input
									type="radio" id="slFlow" name="flowSort"
									onclick="loadFlowUSLChartType();" value="slFlow"
									checked="checked" /><label for="slFlow">流程实例分析</label> <input
									type="radio" id="cqUnDoFlow" name="flowSort"
									onclick="loadFlowUSLChartType();" value="cqUnDoFlow" /><label
									for="cqUnDoFlow">超期完成流程分布</label>

								</td>
							</tr>
							<tr>
								<td valign="top" colspan="3" style="height: 300px;">
									<div class="chart_div">

										<div class="chart_div_con" id="slChart">
											<!-- START Script Block for Chart Line_3D -->
											<div id='Line_3DDiv'>Chart.</div>
											<script type="text/javascript">
var chart_Line_3D = new FusionCharts({"dataFormat" : "xml", "renderAt" : "Line_3DDiv", "debugMode" : "0", "swfUrl" : "../../Comm/Charts/Line.swf", "id" : "Line_3D", "wMode" : "opaque", "width" : "800", "height" : "300", "registerWithJS" : "1","dataSource" : "<chart exportEnabled='1' exportAtClient='0' exportAction='download'  exportHandler='/WF/Comm/Charts/FCExport.jsp'  exportDialogMessage='正在生成,请稍候...'   exportFormats='PNG=生成PNG图片|JPG=生成JPG图片|PDF=生成PDF文件' caption='2015-07至2016-06流程实例分析' lineThickness='1' showValues='1' formatNumberScale='0' anchorRadius='2'   divLineAlpha='20' divLineColor='CC3300' divLineIsDashed='1' showAlternateHGridColor='1'  alternateHGridColor='CC3300' shadowAlpha='40' labelStep='2' numvdivlines='5' chartRightMargin='35' bgColor='FFFFFF,CC3300' bgAngle='270' bgAlpha='10,10'  alternateHGridAlpha='5'  legendPosition ='RIGHT '><set label='2015-07' value='0' /><set label='2015-08' value='0' /><set label='2015-09' value='0' /><set label='2015-10' value='0' /><set label='2015-11' value='0' /><set label='2015-12' value='0' /><set label='2016-01' value='0' /><set label='2016-02' value='0' /><set label='2016-03' value='0' /><set label='2016-04' value='0' /><set label='2016-05' value='0' /><set label='2016-06' value='7' /><styles><definition><style name='CaptionFont' type='font' size='12'/></definition><application><apply toObject='CAPTION' styles='CaptionFont' /><apply toObject='SUBCAPTION' styles='CaptionFont' /></application></styles></chart>"}).render();</script>
											<!-- END Script Block for Chart Line_3D -->

										</div>

									</div>
								</td>
							</tr>
						</table>

					</div>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<fieldset>
						<legend>流程模版统计</legend>
 					<%
                        int flowNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM WF_Flow ");
                        int flowRunNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM WF_Flow WHERE IsCanStart=1  ");
                        int nodeNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(NodeID) FROM WF_Node ");
                        String avgNum = "";
                        if (flowNum == 0)
                            avgNum = "0";
                        else
                            avgNum = df.format(Double.valueOf(nodeNum) /Double.valueOf(flowNum)); 
                        
                    %>
						<table style="width: 100%;">
							<tr>
								<td>流程总数</td>
								<td><%=flowNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>启用的流程数</td>
								<td><%=flowRunNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>节点数</td>
								<td><%=nodeNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>平均流程节点数</td>
								<td><%= Integer.parseInt(new DecimalFormat("0").format(Double.valueOf(avgNum)))%></td>
								<td>个</td>
							</tr>
						</table>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>表单模版统计</legend>
					<%
                        int frmNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Sys_MapData WHERE No NOT LIKE 'ND%' ");
                        int fieldNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(MyPK) FROM Sys_MapAttr WHERE FK_MapData NOT LIKE 'ND%' ");
                        String avgFrmNum = "";  // fieldNum / frmNum;
                        if (frmNum == 0)
                            avgFrmNum = "0";
                        else
                            avgFrmNum =df.format(Double.valueOf(fieldNum) /Double.valueOf(frmNum)); 


                        int numOfRef = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(DISTINCT FK_Frm) FROM WF_FrmNode");
                    %>
						<table style="width: 100%;">
							<tr>
								<td>表单总数</td>
								<td><%=frmNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>字段总数</td>
								<td><%=fieldNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>平均表单字段数</td>
								<td><%=avgFrmNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>被流程引擎引用数</td>
								<td><%=numOfRef %></td>
								<td>个</td>
							</tr>
						</table>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>组织结构统计</legend>
					<%
                        int empNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Emp ");
                        int deptNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Dept ");
                        int stationNum = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Station ");

                        int noStationEmps = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Emp WHERE No Not IN (SELECT FK_Emp FROM Port_EmpStation ) ");

                        int noDeptEmps = 0;
                        if (BP.Sys.SystemConfig.getOSModel().getValue() == BP.Sys.OSModel.OneOne.getValue())
                          noDeptEmps = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Emp WHERE FK_Dept Not IN (SELECT No FROM Port_Dept) ");
                        else
                            noDeptEmps = BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(No) FROM Port_Emp WHERE FK_Dept Not IN (SELECT No FROM Port_Dept) ");
                    %>
						<table style="width: 100%;">
							<tr>
								<td>操作员数</td>
								<td><%=empNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>部门数</td>
								<td><%=deptNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td>岗位数</td>
								<td><%=stationNum %></td>
								<td>个</td>
							</tr>
							<tr>
								<td colspan="3">无岗位数（ <font color="Red"><b> <%=noStationEmps %></b></font>）
									无部门人员（<font color="Red"><b><%=noDeptEmps %></b></font>）
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<fieldset>
						<legend>
							流程实例分析(合计)- <a href="../CCBPMDesigner/App/Welcome.jsp">进入流程监控</a>
						</legend>
						<table style="width: 100%;">
							<tr>
								<td>流程总数</td>
								<td><%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow ")%></td>
								<td>个</td>
							</tr>
							<tr>
								<td>正在运行数</td>
								<td><%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow WHERE WFState!=" +  BP.WF.WFState.Complete.getValue())+"  "%></td>
								<td>个</td>
							</tr>
							<tr>
								<td>完成数</td>
								<td><%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow WHERE WFState=" + BP.WF.WFState.Complete.getValue()) + " "%></td>
								<td>个</td>
							</tr>
							<tr>
								<td>退回中数</td>
								<td> <%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow WHERE WFState=" + BP.WF.WFState.ReturnSta.getValue()) + " "%></td>
								<td>个</td>
							</tr>
							<tr>
								<td>删除数</td>
								<td><%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow WHERE WFState=" + BP.WF.WFState.Delete.getValue()) + " "%></td>
								<td>个</td>
							</tr>
							<tr>
								<td>其他运行数</td>
								<td><%=BP.DA.DBAccess.RunSQLReturnValInt("SELECT COUNT(WorkID) FROM WF_GenerWorkFlow WHERE WFSta=" + BP.WF.WFSta.Etc.getValue()) + "  "%></td>
								<td>个</td>
							</tr>
						</table>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>考核信息</legend>
						<table>
							<tr>
								<td class="flow_info"><font class="flow_font">1、</font>提前完成分钟数
								</td>
								<td><%=w.getBeforeOver()%></td>
								<td>分钟</td>
							</tr>
							<tr>
								<td class="flow_info"><font class="flow_font ">2、</font>逾期分钟数
								</td>
								<td class="font_red"><%=w.getAfterOver()%></td>
								<td>分钟</td>
							</tr>
							<tr>
								<td class="flow_info"><font class="flow_font">3、</font>按时完成
								</td>
								<td><%=w.getInTimeOverCount()%></td>
								<td>个</td>
							</tr>
							<tr>
								<td class="flow_info"><font class="flow_font">4、</font>超时完成
								</td>
								<td class="font_red"><%=w.getAfterOverCount()%></td>
								<td>个</td>
							</tr>
							<tr>
								<td class="flow_info"><font class="flow_font">5、</font>按时办结率
								</td>
								<td><%=w.getAsRate() %><font
									class="flow_font flow_font_big">%</font></td>
								<td></td>
							</tr>
							<tr>
								<td class="flow_info"><font class="flow_font">6、</font>在运行的逾期
								</td>
								<td><font class="font_red"> <%=w.getRunningFlowOverTime()%></font>
								</td>
								<td>个</td>
							</tr>
						</table>
					</fieldset>
				</td>
				<td valign="top">
					<fieldset>
						<legend>表单云 </legend>
						<table>
							<tr>
								<td>模版总数</td>
								<td>N</td>
								<td>个</td>
							</tr>
							<tr>
								<td>我贡献</td>
								<td>N</td>
								<td>个</td>
							</tr>
							<tr>
								<td>最新贡献数</td>
								<td>N</td>
								<td>个</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
		</table>
		<div></div>
	</form>

</body>

</html>