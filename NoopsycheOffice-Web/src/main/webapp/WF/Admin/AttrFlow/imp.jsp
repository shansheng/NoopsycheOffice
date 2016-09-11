<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="BP.WF.Flow"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
String FK_Flow=request.getParameter("FK_Flow"); 
String y=request.getParameter("y"); 
Flow fl = new Flow();
    if (FK_Flow != null)
       fl= new Flow(FK_Flow);
  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>流程导入</title>
<link href="../../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
<link href="../../Comm/Style/Tabs.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../Scripts/easyUI/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="../../Comm/JScript.js"></script>
</head>
<body>
	<form method="post" action="<%=basePath %>WF/AttrFlow/imp/import_file.do?FK_Flow=<%=FK_Flow %>&Lang=CH"
		id="form1" enctype="multipart/form-data">
		<input type="hidden" id="success" name="success" value="${success }"/>
		<input type="hidden" id="type" name="type">
		<div>
			<table style="width: 100%">
				<caption>流程<%=fl.getName() %>模版导入</caption>
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
							<legend> 从本机导入 </legend>
							<ul>
								<li>从本机导入：请您选择本机的一个xml格式文件 点击导入按钮完成导入。</li>
								<li>请选择文件: <input type="file" 	name="file" id="file"/>
								</li>
								<li>导入的方式: <br /> <input id="Import_1"
									type="radio" name="Import_mode"
									value="Import_1" checked="checked" /><label
									for="Import_1">作为新流程导入(由ccbpm自动生成新的流程编号)</label>
									<br /> <input id="Import_2" type="radio"
									name="Import_mode" value="Import_2" /><label
									for="Import_2">作为新流程导入(使用流程模版里面的流程编号，如果该编号已经存在系统则会提示错误)</label>
									<br /> <input id="Import_3" type="radio"
									name="Import_mode" value="Import_3" /><label
									for="Import_3">作为新流程导入(使用流程模版里面的流程编号，如果该编号已经存在系统则会覆盖此流程)</label>
									<br /> <input id="Import_4" type="radio"
									name="Import_mode" value="Import_4" /><label
									for="Import_4">按指定流程编号导入</label> 指定的流程编号:<input
									name="SpecifiedNumber" type="text"
									id="SpecifiedNumber" /> <br />
								</li>
							</ul>
							<div style="text-align: center; padding: 5px;">
								<input type="button" name="Button1" onclick="formSubmit()" value="执行导入" id="Button1" />
							</div>
						</fieldset>
						<fieldset>
							<legend> 从云服务器导入 </legend>
							<ul>
								<li><a href="/WF/Admin/Clound/PriFlow.jsp?FK_Flow=001"><img
										src="../CCBPMDesigner/Img/FlowPrivate.png" />从私有云导入</a></li>
								<li><a href="/WF/Admin/Clound/PubFlow.jsp?FK_Flow=001"><img
										src="../CCBPMDesigner/Img/FlowPublic.png" />从共有云导入</a></li>
							</ul>
						</fieldset>
					</td>
				</tr>
			</table>
		</div>
	</form>
<script type="text/javascript">

//初始化加载，解决一些兼容问题
$(document).ready(function(){
	//var success =$("#success").val();
	var success ='<%=y%>';
	if (success == "" || success == null || success == "null") {
		return;
	} else if(success=='t'){
		alert("导入成功！");
	}else if(success=='f'){
		alert("导入失败！");
	}
});
	function formSubmit(){
		var filename=document.getElementById("file").value;
		if(filename==""){
	        alert("你没有选择文件！");
	        return false;
	    }
		var mime = filename.toLowerCase().substr(filename.lastIndexOf(".")); 
		if(mime!='.xml'){
			 alert("请选择xml文件格式的文件！");
		     return false;
		}
		var Import_mode = $("input[name='Import_mode']:checked").val();
		$("#type").val(Import_mode); 
		if(Import_mode=='Import_4'){
			var SpecifiedNumber=$("#SpecifiedNumber").val();
			if(SpecifiedNumber==''){
				 alert("请输入指定的流程编号！");
			        return false;
			}
		}
		$("#form1").submit();
	}
</script>
</body>
</html>