<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file  = "/WF/head/head1.jsp" %>
<%
	BlockModel block = new BlockModel(request, response);
	block.Page_Load();
%>
<script  type="text/javascript">
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
      function radioClick(obj){
       /*   var v=obj.value;
         if(v=='RB_None' || v=='RB_CurrNodeAll'){
 			$("#TB_SpecSubFlow").val('');
 			$("#TB_SQL").val('');
 			$("#TB_Exp").val('');
 		 }else if(v=='RB_SpecSubFlow'){
 			$("#TB_SQL").val('');
 			$("#TB_Exp").val('');
 		 }else if(v=='RB_SQL'){
 			$("#TB_SpecSubFlow").val('');
 			$("#TB_Exp").val('');
 		 }else if(v=='RB_Exp'){
 			$("#TB_SpecSubFlow").val('');
 			$("#TB_SQL").val('');
 		 } */
      }
      
      
      //保存按钮点击触发事件
      function btn_Save_Click(){
    	  var FK_Node = '<%=block.getFK_Node() %>';
    	  var blockType="";
    	  var blockContent="";
    	  if($("#RB_None").attr("checked")){
    		  blockType="None";
    		  blockContent="";
  		}else if($("#RB_CurrNodeAll").attr("checked")){
  			blockType="CurrNodeAll";
  			blockContent="";
  		}
  		else if($("#RB_SpecSubFlow").attr("checked")){
  			blockType="SpecSubFlow";
  			blockContent=document.getElementById("TB_SpecSubFlow").value;
  		}
  		else if($("#RB_SQL").attr("checked")){
  			blockType="BySQL";
  			blockContent=document.getElementById("TB_SQL").value;
  		}
  		else if($("#RB_Exp").attr("checked")){
  			blockType="ByExp";
  			blockContent=document.getElementById("TB_Exp").value;
  		}
  		else {
  			alert("请选择转向条件");
  			return;
  		}		
    	var TB_Alert=document.getElementById("TB_Alert").value;
    	location.href="<%=basePath%>block/block_btn_Save.do?FK_Node="+ FK_Node+ "&blockType="+ blockType+"&blockContent="+blockContent+"&TB_Alert="+TB_Alert;
      }
      
      
</script>

</head>
<body onload="load();">
	<form method="post" action="" id="form1">
		<input type="hidden" id="success" value="${success }" />
		<div id="rightFrame"
			data-options="region:'center',noheader:true;scrolling:auto;">
			<div class="easyui-layout" data-options="fit:true;scrolling:auto;">
				<table style="width: 100%;">
					<caption>发送阻塞模式</caption>
					<tr>
						<td valign="top">
							<fieldset>
								<legend>
									<input id="RB_None" type="radio"
										name="xxx" value="RB_None"
										<%=block.radioCheck1 %> onclick="radioClick(this);" /><label for="RB_None">不阻塞</label>
								</legend>
								<ul style="color: Gray;">
									<li>默认模式，不阻塞。</li>
									<li>如果以下几种模式不能满足需求就可以在发送成功前的事件里抛出异常，阻止向下运动。</li>
								</ul>
							</fieldset>
							
							<fieldset>
								<legend>
									<input id="RB_CurrNodeAll" type="radio"
										name="xxx" value="RB_CurrNodeAll" <%=block.radioCheck2 %> onclick="radioClick(this);"/><label
										for="RB_CurrNodeAll">当前节点有未完成的子流程时</label>
								</legend>
								<ul style="color: Gray;">
									<li>当前节点吊起了子流程，并且有未完成的子流程时就不能向下运动。</li>
								</ul>
							</fieldset>

							<fieldset>
								<legend>
									<input id="RB_SpecSubFlow" type="radio"
										name="xxx" value="RB_SpecSubFlow" <%=block.radioCheck3 %> onclick="radioClick(this);"/><label
										for="RB_SpecSubFlow">按约定格式阻塞未完成子流程</label>
								</legend>
								<a href="javascript:ShowHidden('flows')">请设置表达式:</a>

								<div id="flows" style="color: Gray; display: none">
									<ul>
										<li>当该节点向下运动时，要检查指定的历史节点曾经启动的指定的子流程全部完成，作为条件。</li>
										<li>例如：在D节点上，要检查曾经在C节点上启动的甲子流程是否全部完成，如果完成就不阻塞。</li>
										<li>配置格式：@指定的节点1=子流程编号1@指定的节点n=子流程编号n。</li>
									</ul>
								</div>
								<input name="TB_SpecSubFlow" value="<%=block.specSubFlow %>"
									type="text" id="TB_SpecSubFlow"
									style="width: 95%; margin: 10px;" />
							</fieldset>

							<fieldset>
								<legend>
									<input id="RB_SQL" type="radio"
										name="xxx" value="RB_SQL" <%=block.radioCheck4 %> onclick="radioClick(this);" /><label
										for="RB_SQL">按照SQL阻塞</label>
								</legend>
								<a href="javascript:ShowHidden('sql')">请输入SQL:</a>
								<div id="sql" style="color: Gray; display: none">
									<ul>
										<li>配置一个SQL，该SQL返回一行一列的数值类型的值。</li>
										<li>如果该值大于0，就是true, 否则就是false.</li>
										<li>配置的参数支持ccbpm表达式。</li>
									</ul>
								</div>
								<textarea name="TB_SQL" rows="1" cols="20" id="TB_SQL" style="width: 95%;margin: 10px; text-align: left;"><%=block.SQL.trim() %></textarea>
							</fieldset>

							<fieldset>
								<legend>
									<input id="RB_Exp" type="radio" name="xxx" value="RB_Exp" <%=block.radioCheck5 %> onclick="radioClick(this);"/><label
										for="RB_Exp">按照表达式阻塞</label>
								</legend>

								<a href="javascript:ShowHidden('exp')">请输入表达式:</a>
								<div id="exp" style="color: Gray; display: none">
									<ul>
										<li>配置一个SQL，该SQL返回一行一列的数值类型的值。</li>
										<li>如果该值大于0，就是true, 否则就是false.</li>
										<li>配置的参数支持ccbpm表达式。</li>
									</ul>
								</div>
								<input name="TB_Exp" type="text" value="<%=block.exp %>"
									id="TB_Exp" style="width: 95%;margin: 10px;" />
							</fieldset>

							<fieldset>
								<legend>其他选项设置</legend>

								<font color="gray">被阻塞时提示信息(默认为:符合发送阻塞规则，并能向下发送):</font> <input
									name="TB_Alert" type="text"
									id="TB_Alert" style="width: 95%;margin: 10px;" value="<%=block.other %>"/>
							</fieldset>
						</td>

						<td valign="top" style="width: 30%;">
							<fieldset>
								<legend>帮助</legend>
								<ul>
									<li>发送阻塞，就是让当前节点不能向下运动的规则。</li>
									<li>如果满足一定的条件，就不能让其向下运动。</li>
								</ul>
							</fieldset>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<a href="javascript:btn_Save_Click()" id="Btn_Save" name="Btn_Save" class="easyui-linkbutton l-btn" iconcls="icon-save"> 保存</a>
							<!-- <input type="submit"name="Btn_Save" value="保存" id="Btn_Save" /> -->
						</td>
					</tr>
				</table>

			</div>
		</div>
	</form>
</body>
</html>