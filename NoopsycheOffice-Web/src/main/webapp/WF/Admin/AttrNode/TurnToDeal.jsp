<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	TurnToDealModel ttd = new TurnToDealModel(request, response);
	ttd.Page_Load();
%>
<script type="text/javascript">
function load() {
	var successStr = $("#success").val();
	if (successStr.length == 0) {
		return;
	} else {
		alert(successStr);
	}
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
	//单选按钮点击触发事件
	function rb_onchange(v){
		/*待完善，改变当前选项，则文本框 不可用*/
		var type=v.value;
		if(type=='RB_CCFlowMsg'){
			$("#TB_SpecMsg").val('');
			$("#TB_SpecURL").val('');
		}else if(type=='RB_SpecMsg'){
			$("#TB_SpecURL").val('');
		}else if(type=='RB_SpecUrl'){
			$("#TB_SpecMsg").val('');
		}
	}
	
	// 保存按钮点击触发事件
	function btn_Save_Click(){
		var FK_Node = '<%=ttd.getFK_Node() %>';
		var TurnToDealType ="";
		var TurnToDealDoc ="";
		
		if($("#RB_CCFlowMsg").attr("checked")){
			TurnToDealType="CCFlowMsg";
			TurnToDealDoc="";
		}else if($("#RB_SpecMsg").attr("checked")){
			TurnToDealType="SpecMsg";
			TurnToDealDoc=document.getElementById("TB_SpecMsg").value;
		}else if($("#RB_SpecUrl").attr("checked")){
			TurnToDealType="SpecUrl";
			TurnToDealDoc=document.getElementById("TB_SpecURL").value;
		}else {
			alert("请选择转向条件");
			return;
		}		
		location.href="<%=basePath%>turnToDeal/TurnToDeal_btn_Save.do?FK_Node="+ FK_Node+ "&TurnToDealDoc="+ TurnToDealDoc+"&TurnToDealType="+TurnToDealType;
	}
</script>
</head>
<body onload="load();">
	<form method="post" action="" id="form1">
	<input type="hidden" id="success" value="${success }" />
		<div id="rightFrame"
			data-options="region:'center',noheader:true;scrolling:auto;">
			<div class="easyui-layout" data-options="fit:true;scrolling:auto;">
				<table style="width: 100%">
        <caption>
            发送后转向处理规则
            <tr>
                <td valign="top">
                    <fieldset>
                        <legend>
                            <input id="RB_CCFlowMsg" type="radio" name="TurnToDeal" value="RB_CCFlowMsg" <%=ttd.flowMsgCheck %> onclick="rb_onchange(this);" /><label for="ContentPlaceHolder1_RB_CCFlowMsg">提示jflow默认信息</label></legend>
                        <ul style="color: Gray">
                            <li>默认为不设置，按照机器自动生成的语言提示，这是标准的信息提示。</li>
                            <li>比如：您的当前的工作已经处理完成。下一步工作自动启动，已经提交给xxx处理。 </li>
                        </ul>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <input id="RB_SpecMsg" type="radio" name="TurnToDeal" value="RB_SpecMsg" <%=ttd.specMsgCheck %> onclick="rb_onchange(this);" /><label for="ContentPlaceHolder1_RB_SpecMsg">提示指定信息</label>
                        </legend><a href="javascript:ShowHidden('SpecMsg')">输入提示的信息:</a>
                        <div id="SpecMsg" style="display: none">
                            <ul style="color: Gray">
                                <li>按照您定义的信息格式，提示给已经操作完成的用户。</li>
                                <li>比如：您的申请已经发送至XXX用户进行审批。 </li>
                                <li>该自定义信息支持ccbpm的表达式，具体可参考右侧帮助文档。 </li>
                            </ul>
                        </div>
                        <input name="TB_SpecMsg" type="text" id="TB_SpecMsg" value="<%=ttd.specMsgText %>" style="width:95%; margin: 10px;" /><br/>
                    </fieldset>
                    <fieldset>
                        <legend>
                            <input id="RB_SpecUrl" type="radio" name="TurnToDeal" value="RB_SpecUrl" <%=ttd.specUrlCheck %> onclick="rb_onchange(this);" /><label for="ContentPlaceHolder1_RB_SpecUrl">转向指定的URL</label>
                        </legend><a href="javascript:ShowHidden('SpecUrl')">输入提示的信息:</a>
                        <div id="SpecUrl" style="display: none">
                            <ul style="color: Gray">
                                <li>按照您定义的url转向，可处理较为复杂的业务逻辑处理。</li>
                                <li>比如：URL为MyFlow.jsp页面或www.baidu.com。 </li>
                                <li>该URL支持ccbpm参数形式，具体传值参考右侧帮助。 </li>
                            </ul>
                        </div>
                        <input name="TB_SpecURL" type="text" id="TB_SpecURL" value="<%=ttd.specUrlText %>" style="width:95%; margin: 10px;" /><br/>
                    </fieldset>
                </td>
                <td valign="top">
                    <fieldset>
                        <legend>帮助</legend>
                        <ul style="color: Gray">
                            <li><a href="http://ccbpm.mydoc.io/?v=5404&t=17914" target="_blank">提示jflow默认信息</a></li>
                            <li><a href="http://ccbpm.mydoc.io/?v=5404&t=17914" target="_blank">提示指定信息</a></li>
                            <li><a href="http://ccbpm.mydoc.io/?v=5404&t=17914" target="_blank">转向指定的URL</a></li>
                        </ul>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                <a href="javascript:btn_Save_Click()" id="Btn_Save" name="Btn_Save" class="easyui-linkbutton l-btn" iconcls="icon-save"> 保存</a>
                   <!--  <input type="button" name="Btn_Save" value="保存" id="Btn_Save" onclick="save()"/> -->
                </td>
            </tr>
    </table>


				
			</div>
		</div>
	</form>
</body>
</html>
