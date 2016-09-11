<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
AutoFullNewModel afn=new AutoFullNewModel(request, response);
afn.init();
%>
<script language=javascript>
	function Esc() {
		if (event.keyCode == 27)
			window.close();
		return true;
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

	function btn_Save_Click(v){
		var RefNo='<%=afn.getRefNo()%>';
		var FK_MapData='<%=afn.getFK_MapData()%>';
		var Tag=$("input[name='tag']:checked").val();
		var Doc=$("#TB_Exp").val();
		var url='<%=basePath%>WF/MapDef/btn_Save_Click.do?RefNo='+RefNo+'&FK_MapData='+FK_MapData+'&Tag='+Tag+'&Doc='+Doc;
		if(Tag=='' || typeof(Tag)=='undefined' || Tag=='null'){
			alert("请选择一项设置");
			return false;
		}else{
			$.ajax({  
			      type:'post',  
			      url:url,  
			      data:{},  
			      cache:false,  
			      success:function(data){
			    	  if(data="success"){
			    		  if(v==1) alert("保存成功！");
			    		  if(v==2) {window.close(); alert("保存成功！");}
			    	  }
			       },  
			       error:function(){
			    	   alert("出错了！");
			       }  
			 });
		}
	}
	
</script>
</head>
<body onkeypress="Esc();" class="easyui-layout" >
<form method="post" action="" id="form1">
	<input type="hidden" id="success" value="${success }" />
		<div data-options="region:'center',title:''" style="padding:5px;">

			<table style="width: 100%;">
				<caption>为文本框【<%=afn.getRefNo() %>】设置自动完成.</caption>
				<tr>
					<td style="width: 70%;" valign="top">
						<fieldset>
							<legend>
								<input id="RB_0" type="radio" <%=afn.getRadioCheck1() %>
									name="tag" value="0" /><label
									for="RB_0">不设置(默认)</label>
							</legend>
							<ul>
								<li>不做任何处理.</li>
							</ul>
						</fieldset>

						<fieldset>
							<legend>
								<input id="RB_1" type="radio" <%=afn.getRadioCheck2() %>
									name="tag" value="1" /><label
									for="RB_1">使用Javascript 四则混合运算.</label>
							</legend>

							<a href="javascript:ShowHidden('exp')">请输入表达式: </a>
							<div id="exp" style="color: Gray; display: none">
								<ul>
									<li>用于处理主表同一个表单内的文本框与其他文本框数值的四则混合运算，或者明细表的一行数据的内的字段四则混合运算。</li>
									<li>格式：@中文字段1 + @中文字段2 或者: @Filed1 + @Field2</li>
									<li>比如1：当前的文本框为“应纳税额” 您可以设置 @发票金额 * @增值税税率 也可设置为
										@FPJE*@ZZSSL</li>
									<li>比如2：当前的文本框为“小计” 您可以设置 @数量*@单价 也可设置为 @ShuLiang*@DanJia
									</li>
									<li>重要提示: 表达式支持中文与英文的编写，但是需要特别注意，一个字段不能包含另外一个字段，这样就会出现错误。</li>
									<li>比如： @Field1 与 @Field11 系统就区分不出来，因为@Field11 包含 @Field1
										，它会导致计算紊乱，所以需要正确的起名字。</li>
								</ul>
							</div>

							<textarea name="TB_Exp" rows="3"
								cols="20" id="TB_Exp" title="点击标签显示帮助."
								style="width: 98%;"><%=afn.getBdsTextArea() %></textarea>
						</fieldset>
					</td>

				</tr>

				<tr>
					<td colspan="1">
						<input type="button" name="Btn_Save" onclick="btn_Save_Click('1');" value="保存" id="Btn_Save" /> 
						<input type="button" name="Btn_SaveAndClose" onclick="btn_Save_Click('2');" value="保存并关闭" id="Btn_SaveAndClose" />
					 	<input value="关闭" type="button" onclick="javascript: window.close();" />
					 </td>
				</tr>
			</table>
		</div>
</form>
</body>
</html>