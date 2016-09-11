
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	String FK_Flow=request.getParameter("FK_Flow");
%>
<head>
<style type="text/css">
input[type=text]{
    height: 20px;
    width: 95%;
}
</style>
</head>
<script  type="text/javascript">
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
        
        $(document).ready(function(){
        	getPage();
        }); 
    //ajax 取数据
    function getPage(){
		var keys = "";
		$.ajax({
			url:'<%=basePath%>WF/Limit/PageLoad.do',
			type:'post', //数据发送方式
			//dataType:'json', //接受数据格式
			data:{FK_Flow:'<%=FK_Flow%>'},
			async: false ,
			error: function(data){
			},
			success: function(data){
				var json = eval("("+data+")");
				$("#TB_Alert").val(json.TB_Alert);
				$("#TB_ByTimePara").val(json.TB_ByTimePara);
				$("#DDL_ByTime").val(json.DDL_ByTime);
				$("#TB_ColNotExit_Fields").val(json.TB_ColNotExit_Fields);
				$("#TB_SQL_Para").val(json.TB_SQL_Para);
				
				$("input:radio[name='xzgz']").removeAttr("checked");
				if(json.RB_None=="true"){
					$("#RB_None").attr("checked","checked");
				}else if(json.RB_ColNotExit=="true"){
					$("#RB_ColNotExit").attr("checked","checked");
				}else if(json.RB_ByTime=="true"){
					$("#RB_ByTime").attr("checked","checked");
				}else if(json.RB_SQL=="true"){
					$("#RB_SQL").attr("checked","checked");
				}
			}
		});
	}
    //ajax 提交
	function onSave(){
		var keys = "";
		var TB_Alert=$("#TB_Alert").val();
		var xz=$("input[name=xzgz]:checked").attr("id");
		var DDL_ByTime=$("#DDL_ByTime").val();
		var TB_ByTimePara=$("#TB_ByTimePara").val();
		var TB_ColNotExit_Fields=$("#TB_ColNotExit_Fields").val();
		var TB_SQL_Para=$("#TB_SQL_Para").val();
		var DDL_SQL=$("#DDL_SQL").val();
		$.ajax({
			url:'<%=basePath%>WF/Limit/BtnSaveClick.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{TB_Alert:TB_Alert,xz:xz,DDL_ByTime:DDL_ByTime,TB_ByTimePara:TB_ByTimePara,TB_ColNotExit_Fields:TB_ColNotExit_Fields,TB_SQL_Para:TB_SQL_Para,DDL_SQL:DDL_SQL,FK_Flow:'<%=FK_Flow%>'},
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
<table style="width: 100%">
	<caption>发起限制规则</caption>
	<tr>
		<td valign=top style="width: 20%;"   >
			<fieldset>
				<legend> 填写帮助</legend>

				<ul>
					<li>发起限制，根据不同的应用场景来设置的发起频率的限制规则。</li>
					<li>比如：纳税人注销流程只能一个纳税人注销一次，不允许多次注销，发起多次，就是违反也正常的业务逻辑。。</li>

				</ul>
			</fieldset>
		</td>

		<td valign="top">
			<fieldset>
				<legend>
					<input type="radio" id="RB_None" name="xzgz" value="" checked="checked"/>不限制（默认）
				</legend>
				<ul style="color: Gray">
					<li>不限制发起次数，比如报销流程、请款流程。</li>
				</ul>
			</fieldset>


			<fieldset>
				<legend>
					<input type="radio" id="RB_ByTime" name="xzgz" value=""/>按时间规则计算
				</legend>

				<table style="width: 100%">
					<tr>
						<td style="width: 80px;">规则模式：</td>
						<td><select id="DDL_ByTime" name="DDL_ByTime" runat="server">
								<option Value="0">每人每天一次</option>
								<option Value="1">每人每周一次</option>
								<option Value="2">每人每月一次</option>
								<option Value="3">每人每季一次</option>
								<option Value="4">每人每年一次</option>
						</select></td>

						<td class="style2"><font color="gray">
								<ul>
									<li>按照选择的时间频率进行设置发起限制</li>
									<li><a
										href="javascript:WinOpen('http://bbs.ccflow.org/showtopic-3711.aspx')">更多规则模式与参数设置</a>
									</li>
								</ul>
						</font></td>
					</tr>
					<tr>
						<td colspan=3><a href="javascript:ShowHidden('FQGZ')">发起时间段限制参数设置:</a>
							<div id="FQGZ" style="display: none; color: Gray">
								<ul>
									<li>该设置，可以为空。</li>
									<li>用来限制该流程可以在什么时间段内发起。</li>
									<li>例如:按照每人每天一次设置时间范围，规则参数：@08:30-09:00@18:00-18:30，解释：该流程只能在08:30-09:00与18:00-18:30两个时间段发起且只能发起一次。</li>
								</ul>
							</div> <BR><input type="text" id="TB_ByTimePara" runat="server"></input></td>
					</tr>
				</table>
			</fieldset>
			
			<fieldset>
				<legend>
					<input type = "radio" id="RB_OnlyOneSubFlow" name=""xzgx>为子流程时，仅仅只能被调用1次
			    </legen>
				<ul>
					<li>如果当前为子流程，仅仅只能被调用1次。</li>
				</ul>
				</fieldset>

			<fieldset>
				<legend>
						<input type="radio" id="RB_ColNotExit" name="xzgz" value=""/>按照发起字段不能重复规则
				</legend>

				<a href="javascript:ShowHidden('fields')">填写设置字段</a>
				<div id="fields" style="display: none; color: Gray">
					<ul>
						<li>设置一个列允许重复，比如：NSRBH</li>
						<li>设置多个列的时候，需要用逗号分开，比如：field1,field2</li>
						<li>流程在发起的时候如果发现，该列是重复的，就抛出异常，阻止流程发起。</li>
						<li>比如：纳税人注销流程，一个纳税人只能发起一次注销，就要配置纳税人字段，让其不能重复。</li>
					</ul>
				</div>

				<BR><input id="TB_ColNotExit_Fields" type="text" runat="server" Width="95%"
					Height="20px"></input>
			</fieldset>

			<fieldset>
				<legend>
						<input type="radio" id="RB_SQL" name="xzgz" value=""/>按SQL规则
				</legend>
				&nbsp;&nbsp;规则模式：
				<select id="DDL_SQL" runat="server">
					<option Value="0">设置的SQL数据为空，或者返回结果为零时可以启动</option>
					<option Value="1">设置的SQL数据为空，或者返回结果为零时不可以启动</option>
				</select>
				<br /> <a href="javascript:ShowHidden('Div2')">SQL规则参数:</a>
				<div id="Div2" style="display: none; color: Gray">
					<ul>
						<li>例如：SELECT COUNT(*) AS Num FROM TABLE1 WHERE
							NAME='@MyFieldName'</li>
						<li>解释：编写一个sql语句返回一行一列，如果信息是0，就是可以启动，非0就不可以启动。</li>
						<li>该参数支持ccbpm的表达式。</li>
					</ul>
				</div>
				<BR><textArea id="TB_SQL_Para" runat="server" Rows="2"
					TextMode="MultiLine" style="width:95%"></textArea>
			</fieldset>


			<fieldset>
				<legend>
					<a href="javascript:ShowHidden('msgAlert')">限制提示信息:</a>
				</legend>

				<div id="msgAlert" style="display: none; color: Gray">
					<ul>
						<li>例如:您的发起的流程违反了xxx限制规则，不能发起该流程。</li>
						<li>当限制规则起作用的时候，应该提示给用户什么信息。</li>
						<li>该信息在创建工作失败的时候提示。</li>
					</ul>
				</div>
				<input id="TB_Alert" type="text" Width="95%" readonly="false"></input>
			</fieldset>


		</td>
	</tr>


	<tr>
		<td></td>
		<td><input type="button" class="easyui-linkbutton" id="Btn_Save"
				runat="server" value="保存" onClick="onSave()" /></td>
	</tr>

</table>
</body>