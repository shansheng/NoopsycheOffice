<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cn.jflow.model.wf.admin.ccbpm.FlowsModel" %>
<%@ page import="BP.Web.WebUser" %>
<%@taglib uri='http://java.sun.com/jstl/core_rt' prefix='c'%>
<%@taglib uri='http://java.sun.com/jstl/fmt_rt' prefix='fmt'%>
<%@taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn'%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	FlowsModel fm=new FlowsModel(request,response);
    fm.page_load();
	int i=0;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript">
        function OpenRpt(flowNo) {
            window.parent.closeTab('设计报表');
            window.parent.addTab('OpenRpt', '设计报表', '../../Rpt/OneFlow.jsp?FK_MapData=ND' + flowNo + 'Rpt&FK_Flow=' + flowNo, '');
            //WinOpen('../../Rpt/OneFlow.jsp?FK_MapData=ND' + flowNo + 'Rpt&FK_Flow=' + flowNo, 'csd');
        }
        function FlowAttr(flowNo) {
            window.parent.closeTab('流程属性');
            window.parent.addTab('FlowAttr', '流程属性', '../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, '');
            //WinOpen('../../Comm/RefFunc/UIEn.jsp?EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, 'csd');
        }
        function NodesAttr(flowNo) {
            window.parent.closeTab('节点设置');
            window.parent.addTab('NodesAttr', '节点设置', '../AttrFlow/NodeAttrs.jsp?FK_Flow=' + flowNo, '');
        }
        function OpenDel(flowNo) {
            window.parent.closeTab('删除');
            window.parent.addTab('OpenDel', '删除', '../../Comm/RefMethod.jsp?Index=4&EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, '');
            //window.open('../../Comm/RefMethod.jsp?Index=4&EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, 'cc', 'height=100,width=400,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
        }
        function OpenRollback(flowNo) {
            window.parent.closeTab('回滚');
            window.parent.addTab('OpenRollback', '回滚', '../../Comm/RefMethod.jsp?Index=12&EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, '');
            //window.open('../../Comm/RefMethod.jsp?Index=12&EnsName=BP.WF.Template.FlowSheets&No=' + flowNo, 'cc', 'height=100,width=400,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
        }
        //设计流程
        function openFlow(flowDType, flowName, flowNo, webUserNo, webUserSID) {
            if (flowDType == 2) {//BPMN模式
                window.parent.closeTab(flowName);
                window.parent.addTab('flow', flowName, "../CCBPMDesigner/Designer.jsp?FK_Flow=" +
                        flowNo + "&UserNo=" + webUserNo + "&SID=" + webUserSID + "&Flow_V=2", '');
            } else if (flowDType == 1) {//CCBPM
                window.parent.closeTab(flowName);
                window.parent.addTab('flow', flowName, '../CCBPMDesigner/Designer.jsp?FK_Flow=' +
                  flowNo + "&UserNo=" + webUserNo + "&SID=" + webUserSID + "&Flow_V=1", '');
            } else {
                if (confirm("此流程版本为V1.0,是否执行升级为V2.0 ?")) {
                    window.parent.closeTab(flowName);
                    window.parent.addTab('flow', flowName, "../CCBPMDesigner/Designer.jsp?FK_Flow=" +
                  flowNo + "&UserNo=" + webUserNo + "&SID=" + webUserSID + "&Flow_V=0", '');
                } else {
                    window.parent.closeTab(flowName);
                    window.parent.addTab('flow', flowName, "../CCBPMDesigner/DesignerSL.jsp?FK_Flow=" +
                  flowNo + "&UserNo=" + webUserNo + "&SID=" + webUserSID + "&Flow_V=0", '');
                }
            }
        }
    </script>

<link href="../../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
<link href="../../Comm/Style/Tabs.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../Comm/JScript.js" type="text/javascript"></script>

<script type="text/javascript">
        function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
        function WinOpen(url,name) {
            window.open(url, name, 'height=600, width=800, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
            //window.open(url, 'xx');
        }
        function TROver(ctrl) {
            ctrl.style.backgroundColor = 'LightSteelBlue';
        }

        function TROut(ctrl) {
            ctrl.style.backgroundColor = 'white';
        }
        /*隐藏与显示.*/
        function ShowHidden(ctrlID) {

            var ctrl = document.getElementById(ctrlID);
            if (ctrl.style.display == "block") {
                ctrl.style.display = 'none';
            } else {
                ctrl.style.display = 'block';
            }
        }
        </script>
<style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
        }
        th
        {
            text-align: center;
            border: 1px dotted #CCCCCC;
        }
        .flowSort
        {
            padding-left: 2px;
        }
        .flowName
        {
             padding-left: 30px; 
        }
        .con
        {
            border: 1px dotted #CCCCCC;
            text-align: center;
        }
    </style>
</head>
<body onkeypress="Esc();" topmargin="0" leftmargin="0" style="font-size: smaller">
	<form method="post" action="./Flows.jsp" id="form1">
		<div>
			<table style="width: 100%; min-width: 800px;">
				<caption>流程控制面板</caption>
				<tr>
					<th rowspan="2">流&nbsp;程</th>
					<th colspan="4">流程实例(状态)统计</th>
					<th colspan="4">耗时分析(单位:分钟)</th>
					<th colspan="5">考核状态分布（单位:个）</th>
					<th rowspan="2">设计报表</th>
					<th rowspan="2">设计流程</th>
					<th rowspan="2">考核分析</th>
					<th rowspan="2">流程属性</th>
					<th rowspan="2">节点设置</th>
					<th colspan="2">流程实例操作</th>
				</tr>
				<tr>
					<th>运行中</th>
					<th>已经完成</th>
					<th>其他</th>
					<th>逾期</th>
					<th>最长</th>
					<th>最短</th>
					<th>平均</th>
					<th>系数</th>
					<th>及时</th>
					<th>按期</th>
					<th>逾期</th>
					<th>超期</th>
					<th>按期办结率</th>
					<th>删除</th>
					<th>回滚</th>
				</tr>
				<!-- 外循环流程分组开始 -->
				<c:forEach items="<%=fm.getFlowSorts() %>" var="fsort">
					<%i=1; %>
					<tr class="GroupField">
						<td colspan="21">${fsort.name }</td>
					</tr>
					<!-- 内循环流程开始 -->
					<c:forEach items="<%=fm.getFlows() %>" var="flow" >
						<c:if test="${fsort.no==flow.FK_FlowSort }">
							<tr>
								<td class="flowName">&nbsp;&nbsp;&nbsp;&nbsp;<font style="color: Blue;"> <%=i++ %></font>、${flow.name }</td>
								<!-- 第二个td开始 -->
								<c:if test="${flow.sta0==0 }">
									<td class="con">0</td>
								</c:if>
								<c:if test="${flow.sta0!=0 }">
									<td class="con">
										<a href="javascript:window.parent.closeTab('运行中');window.parent.addTab('running', '运行中', '../../Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&WFSta=0&FK_NY=all&FK_Flow=${ flow.no}&', '');">${flow.sta0}</a>
									</td>
								</c:if>
								<!-- 第二个td结束 -->
								
								<!-- 第三个td开始 -->
								<c:if test="${flow.sta1==0 }">
									<td class="con">0</td>
								</c:if>
								<c:if test="${flow.sta1!=0 }">
									<td class="con">
										<a href="javascript:window.parent.closeTab('已完成');window.parent.addTab('complete', '已完成', '../../Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&WFSta=1&FK_NY=all&FK_Flow=${ flow.no}&', '');">${flow.sta1}</a>
									</td>
								</c:if>
								<!-- 第三个td结束 -->
								
								<!-- 第四个td开始 -->
								<c:if test="${flow.sta2==0 }">
									<td class="con">0</td>
								</c:if>
								<c:if test="${flow.sta2!=0 }">
									<td class="con">
										<a href="javascript:window.parent.closeTab('其他');window.parent.addTab('other', '其他', '../../Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&WFSta=2&FK_NY=all&FK_Flow=${ flow.no}&', '');">${flow.sta2}</a>
									</td>
								</c:if>
								<!-- 第四个td结束 -->
								<td class="con"><font color="red"><b>0</b></font></td>
								<td class="HS con">0</td>
								<td class="HS con">0</td>
								<td class="HS con">0</td>
								<td class="HS con">0</td>
								<td class="con">0</td>
								<td class="con">0</td>
								<td class="con">0</td>
								<td class="con">0</td>
								<td class="con">0</td>
								<td class="con"><a href="javascript:OpenRpt('${ flow.no}');">设计报表</a></td>
								<td class="con"><a href="javascript:openFlow('${ flow.DType}','${ flow.name}','${ flow.no}','<%=BP.Web.WebUser.getNo() %>','<%=BP.Web.WebUser.getSID() %>');">设计流程</a></td>
								<td class="con"><a href="javascript:window.parent.closeTab('考核分析');window.parent.addTab('KHFX', '考核分析', '../../CH/OneFlow.jsp?FK_Flow=${ flow.no}&', '');">考核分析</a></td>
								<td class="con"><a href="javascript:FlowAttr('${ flow.no}');">流程属性</a></td>
								<td class="con"><a href="javascript:NodesAttr('${ flow.no}');">节点设置</a></td>
								<td class="con"><a href="javascript:OpenDel('${ flow.no}');">删除</a></td>
								<td class="con"><a href="javascript:OpenRollback('${ flow.no}');">回滚</a></td>
							</tr>	
						</c:if>
					</c:forEach>
				<!-- 内循环流程结束 -->
				</c:forEach>
			<!-- 外循环流程分组结束 -->
			</table>
		</div>
	</form>
</body>
</html>