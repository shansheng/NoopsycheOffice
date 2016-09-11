<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="BP.WF.Flow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
String FK_Flow=request.getParameter("FK_Flow"); 
Flow fl = new Flow();
    if (FK_Flow != null)
       fl= new Flow(FK_Flow);
  %>
<head>

<head>
<title>导出</title>
<link href="../../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
<link href="../../Comm/Style/Tabs.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"></script>
<script language="JavaScript" src="../../Comm/JScript.js" type="text/javascript"></script>
<base target="_self" />
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
</head>
<body onkeypress="Esc();" topmargin="0" leftmargin="0"
	style="font-size: smaller">
	<form method="post" action="./Exp.jsp?FK_Flow=120&amp;Lang=CH" id="form1">
		<div>
			<table style="width: 100%">
				<caption>流程[<%=fl.getName() %>]模版导出</caption>
				<tr>
					<td valign="top" style="width: 30%;">
						<fieldset>
							<legend>
								<img src="../../Img/Btn/Help.gif" />关于流程模版
							</legend>
							<ol>
								<li>ccbpm生成的流程模版是一个特定格式的xml文件。</li>
								<li>它是流程引擎模版与表单引擎模版的完整的组合体。</li>
								<li>ccbpm的jflow与ccflow的流程引擎导出的流程模版通用。</li>
								<li>流程模版用于流程设计者的作品交换。</li>
								<li>在实施的过程中，我们可以把一个系统上的流程模版导入到另外一个系统中去。</li>
							</ol>
						</fieldset>
						<fieldset>
							<legend>
								<img src="../../Img/Btn/Help.gif" />关于流程模版云
							</legend>
							<ol>
								<li>ccbpm团队为各位爱好者提供了云储存</li>
								<li>它是流程引擎模版与表单引擎模版的完整的组合体。</li>
								<li>ccbpm的jflow与ccflow的流程引擎导出的流程模版通用。</li>
								<li>流程模版用于流程设计者的作品交换。</li>
								<li>在实施的过程中，我们可以把一个系统上的流程模版导入到另外一个系统中去。</li>
							</ol>
						</fieldset>
					</td>
					<td valign="top">
						<fieldset>
							<legend>下载到本机 </legend>
							<ul>
								<li>我们已经为您生成了流程模版文件，<a
									href="javascript:WinOpen('../../Admin/xap/DoPort.jsp?DoType=ExpFlowTemplete&FK_Flow=<%=FK_Flow %>&Lang=CH');">请点击这里下载到本机</a>。
								</li>
								<li>该xml格式的流程模版文件可以通过，软盘交换到其它ccbpm系统中去。</li>
							</ul>
						</fieldset>
						<fieldset>
							<legend>
								<img src="../CCBPMDesigner/Img/FlowPublic.png" />共享到共有云服务器
							</legend>

							<div style='color: red; margin-top: 10px; margin-bottom: 10px'>
								请先注册ccbpm私有云账号<a
									href='javascript: window.parent.closeTab("用户注册");window.parent.addTab("RegUser", "用户注册", "../../../WF/Admin/Clound/RegUser.jsp","");'>注册</a>
								<div />
								<input type="submit" name="BtnPub"
									value="保存至共有云" id="ContentPlaceHolder1_BtnPub"
									disabled="disabled" class="aspNetDisabled" />
						</fieldset>
						<fieldset>
							<legend>
								<img src="../CCBPMDesigner/Img/FlowPrivate.png" />上传到私云服务器
							</legend>

							<div style='color: red; margin-top: 10px; margin-bottom: 10px'>
								请先注册ccbpm私有云账号<a
									href='javascript: window.parent.closeTab("用户注册");window.parent.addTab("RegUser", "用户注册", "../../../WF/Admin/Clound/RegUser.jsp","");'>注册</a>
								<div />
								<input type="submit" name="BtnPri"
									value="保存至私有云" id="ContentPlaceHolder1_BtnPri"
									disabled="disabled" class="aspNetDisabled" />
						</fieldset>
					</td>
			</table>
		</div>
	</form>
</body>
</html>
