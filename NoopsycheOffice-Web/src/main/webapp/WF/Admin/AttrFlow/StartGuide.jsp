
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="BP.WF.Template.FrmNodes"%>
<%@page import="java.util.*"%>
<%@page import="BP.WF.Template.StartGuideWay"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	String FK_Flow=request.getParameter("FK_Flow");
    FrmNodes fns=new FrmNodes(Integer.parseInt(FK_Flow +"01"));

    Flow en = new Flow(FK_Flow);
	en.setNo(FK_Flow);
	en.RetrieveFromDBSources();
	String RB_None = "";
	String RB_ByHistoryUrl = "";
	String RB_SelfUrl = "";
	String RB_BySQLOne = "";
	String RB_FrmList = "";
	
	String TB_ByHistoryUrl="";
	String TB_SelfURL="";
	String TB_BySQLOne1="";
	String TB_BySQLOne2="";
	switch (en.getStartGuideWay())
	{
		case None: //无
			RB_None = "checked";
			break;
		case ByHistoryUrl: //从开始节点Copy数据
			RB_ByHistoryUrl = "checked";
			TB_ByHistoryUrl=en.getStartGuidePara1();
			break;
		case BySelfUrl: //按自定义的Url
			RB_SelfUrl = "checked";
			TB_SelfURL=en.getStartGuidePara1();
			break;
		//case BySystemUrlOne://BySQLOne: //按照参数.
		//	RB_BySQLOne = "checked";
		//	TB_BySQLOne1=en.getStartGuidePara1();
		//	TB_BySQLOne2=en.getStartGuidePara2();
		//	break;
		//case ByParas://ByFrms:
		//	RB_FrmList = "checked";
		//	break;
		default:
			break;
	}
%>
<head>
<style type="text/css">
input[type=text] {
	height: 20px;
	width: 95%;
}
</style>
</head>
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
        function ShowHidden(ctrlID) {

            var ctrl = document.getElementById(ctrlID);
            if (ctrl.style.display == "block") {
                ctrl.style.display = 'none';
            } else {
                ctrl.style.display = 'block';
            }
        }
        
      //ajax 提交
    	function onSave(){
    		var keys = "";
    		var xz=$("input[name=xzgz]:checked").attr("id");
    		var TB_ByHistoryUrl=$("#TB_ByHistoryUrl").val();;
    		var TB_SelfURL=$("#TB_SelfURL").val();;
    		var TB_BySQLOne1=$("#TB_BySQLOne1").val();;
    		var TB_BySQLOne2=$("#TB_BySQLOne2").val();;
    		$.ajax({
    			url:'<%=basePath%>WF/StartGuideAd/BtnSaveClick.do',
    			type:'post', //数据发送方式
    			dataType:'json', //接受数据格式
    			data:{TB_ByHistoryUrl:TB_ByHistoryUrl,xz:xz,TB_SelfURL:TB_SelfURL,TB_BySQLOne1:TB_BySQLOne1,TB_BySQLOne2:TB_BySQLOne2,FK_Flow:'<%=FK_Flow%>'},
    			async: false ,
    			error: function(data){},
    			success: function(data){
    				var json = eval("("+data+")");
    				if(json.success){
    					keys = json.msg;
    				}else{
    				}
    			}
    		});
    		if (window.opener != undefined) {
    	        window.top.returnValue = keys;
    	    } else {
    	        window.returnValue = keys;
    	    }
    		window.close();
    	}
</script>
<body>
	<table style="width: 98%">
		<caption>发起前置导航</caption>
		<tr>
			<td valign="top" style="width: 20%;">
				<fieldset>
					<legend>帮助</legend>

					<ul>
						<li>我们经常会遇到用户发起流程前，首先进入一个实体列表界面（比如项目列表，成员列表、供应商列表。），选择一个实体后把该实体的信息带入开始节点的表单字段里，我们把这个应用场景叫做发起前置导航方式。发起前置导航方式有如下几种应用场景，开发者根据需要进行配置。</li>
						<p />
						<li>比如：流程发起前，先列出所有纳税人列表，用户选中一条，会将纳税人信息直接填充到表单内。</li>

					</ul>
				</fieldset>
			</td>

			<td valign="top">
				<fieldset>
					<legend>
						<input type="radio" id="RB_None" name="xzgz" value="" <%if(!"".equals(RB_None)){%>checked="checked"<%}%>/>不限制（默认）
					</legend>
					<font color="gray">不设置任何前置导航，发起流程直接进入开始节点表单。</font>

				</fieldset> 

				<fieldset>
					<legend>
						<input type="radio" id="RB_ByHistoryUrl" name="xzgz" value="" <%if(!"".equals(RB_ByHistoryUrl)){%>checked="checked"<%}%>/>从开始节点Copy数据(查询历史记录)
					</legend>

					<a href="javascript:ShowHidden('ByHistoryUrl')">请设置SQL</a>:
					<div id="ByHistoryUrl" style="display: none; color: gray">
						<ul>
							<li>用户希望出现一个历史发起的流程列表，选择一条流程并把该流程的数据copy到新建的流程上。</li>
							<li>您需要在这里配置一个SQL, 并且该SQL必须有一个OID列。</li>
							<li>比如：SELECT Title ,OID FROM ND1001 WHERE No LIKE '%@key%'
								OR Name LIKE '%@key%'</li>
						</ul>
					</div>

					<input type="textArea" id="TB_ByHistoryUrl" runat="server"
						style="width: 98%; height: 24px" value="<%=TB_ByHistoryUrl%>"/>
					<br />
				</fieldset>


				<fieldset>
					<legend>
						<input type="radio" id="RB_SelfUrl" name="xzgz" value="" <%if(!"".equals(RB_SelfUrl)){%>checked="checked"<%}%>/>按自定义的Url
					</legend>

					<a href="javascript:ShowHidden('ByUrl')">请设置URL:</a>
					<div id="ByUrl" style="display: none; color: gray">

						<ul>
							<li>请设置URL在下面的文本框里。</li>
							<li>该URL是一个列表，在每一行的数据里有一个连接链接到工作处理器上（/WF/MyFlow.aspx）</li>
							<li>连接到工作处理器（
								WF/MyFlow.aspx）必须有2个参数FK_Flow=xxx&IsCheckGuide=1</li>
							<li>您可以打开Demo: /SDKFlowDemo/TestCase/StartGuideSelfUrl.aspx
								详细的说明了该功能如何开发。</li>
						</ul>

					</div>

					<input type="textArea" id="TB_SelfURL" runat="server"
						style="width: 98%; height: 24px" value="<%=TB_SelfURL %>"/>
					<br />
				</fieldset>

				<fieldset>
					<legend>
						<input type="radio" id="RB_BySQLOne" name="xzgz" <%if(!"".equals(RB_BySQLOne)){%>checked="checked"<%}%>/>按设置的SQL-单条模式
					</legend>

					<a href="javascript:ShowHidden('Paras1')">查询参数:</a>
					<div id="Paras1" style="display: none; color: gray">
						<ul>
							<li>比如:SELECT No, Name, No as EmpNo,Name as EmpName,Email
								FROM WF_Emp WHERE No LIKE '%@key%'</li>
							<li>初始化列表参数，该查询语句必须有No,Name两个列，注意显示数量限制。</li>
							<li>很多场合下需要用到父子流程，在启动子流程的时候需要选择一个父流程。</li>
							<li>实例:SELECT a.WorkID as No, a.Title as Name, a.Starter,
								a.WorkID As PWorkID, '011' as PFlowNo, a.FK_Node as PNodeID FROM
								WF_GenerWorkflow a, WF_GenerWorkerlist b WHERE A.WorkID=b.WorkID
								AND B.FK_Emp='@WebUser.No' AND B.IsPass=0 AND A.FK_Flow='011'
								AND a.Title Like '%@Key%'</li>
						</ul>
					</div>

					<input type="textArea" id="TB_BySQLOne1" rows="3" runat="server"
						style="width: 98%; height: 51px" value="<%=TB_BySQLOne1%>"/>
					<br /> <a href="javascript:ShowHidden('ByParas2')">初始化列表参数:</a>
					<div id="ByParas2" style="display: none; color: gray">
						<ul>
							<li>比如:SELECT top 15 No,Name ,No as EmpNo,Name as EmpName
								,Email FROM WF_Emp</li>
							<li>或者:SELECT No,Name ,No as EmpNo,Name as EmpName ,Email
								FROM WF_Emp WHERE ROWID < 15</li>
							<li>该数据源必须有No,Name两个列, 其他的列要与开始节点表单字段对应。</li>
							<li>注意查询的数量，避免太多影响效率。</li>
						</ul>
					</div>

					</font>
					<input type="textArea" id="TB_BySQLOne2" rows="3" runat="server"
						style="width: 98%; height: 51px" value="<%=TB_BySQLOne2 %>"/>
					<br />
				</fieldset> <%
                     if (fns.size() >=2 )
                     {
 %>
				<fieldset>
					<legend>
						<input type="radio" id="RB_FrmList" name="xzgz" value="" checked="<%=RB_FrmList%>"/>表单列表
					</legend>
					<font color="gray">
						<ul>
							<li>流程启动的时候，系统会把表单列表列出来让操作员选择。</li>
							<li>选择一个或者n个表单后，系统就会把参数 Frms 带入到工作处理器里，让工作处理器启用这个表单。</li>
							<li>这种工作方式适应的环境是一个流程可以挂接多个表单。</li>
						</ul>
					</font>
				</fieldset> <%
 	}
 %>


			</td>
		</tr>

		<tr>
			<td></td>
			<td><input type="button" class="easyui-linkbutton" id="Btn_Save"
				runat="server" value="保存" OnClick="onSave()" /><a
				href="../TestFlow.jsp?FK_Flow=<%=FK_Flow%>&Lang=CH"
				target=_blank>运行测试</a></td>

		</tr>
	</table>
</body>