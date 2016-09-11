<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@page import="cn.jflow.model.wf.mapdef.mapext.*"%>
<%
RadioBtnsModel rb=new RadioBtnsModel(request, response);
rb.init();
%>
<script language=javascript>
	function Esc() {
		if (event.keyCode == 27)
			window.close();
		return true;
	}
	
	
	function WinOpen(url, name) {
		window.open(url,name,'height=600, width=800, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
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
	
	function btn_Save_Click(v){
		var myPk='<%=rb.getMyPK()%>';
<%-- 		var RefNo='<%=rb.getRefNo()%>'; --%>
		var FK_MapData='<%=rb.getFK_MapData()%>';
		var tbSql=$("#TB_SQL").val();
		var DDL_DBSrc=$("#DDL_DBSrc").val();
		var url='<%=basePath%>wf/ddlFullCtrl/btn_Save_Click.do?myPk='+myPk+'&RefNo='+RefNo+'&FK_MapData='+FK_MapData+'&tbSql='+tbSql+'&DDL_DBSrc='+DDL_DBSrc;
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
	
	
</script>
</head>
<body onkeypress="Esc();" class="easyui-layout" >
<form method="post" action="" id="form1">
	<input type="hidden" id="success" value="${success }" />
		<div data-options="region:'center',title:'单选按钮的高级属性'" style="padding:5px;">
			<table width="100%">
				<caption>RadioButton字段[<%=rb.getTitle() %>]的高级设置</caption>
				<tr>
					<!-- <td valign="top">
						<ul>
						</ul>
					</td> -->
					<td valign="top" width="95%"><input id="RB_0" type="radio" name="xx"
						value="RB_0" /><label for="RB_0">不设置</label> <input id="RB_1"
						type="radio" name="xx" value="RB_1" /><label for="RB_1">执行JS脚本</label>
						<input id="RB_2" type="radio" name="xx" value="RB_2" /><label
						for="RB_2">联动其他的控件使其属性该表(可见，只读)</label>

						<div id="JS">
							<textarea cols="85" rows="5" runat="server" style="width: 100%"></textarea>
						</div>
						<div id="Fields">
							<table width="100%">
								<tr>
									<th>序</th>
									<th>字段</th>
									<th>字段名</th>
									<th>可用</th>
									<th>可见</th>
								</tr>
								<c:forEach items="<%=rb.getFiledList() %>" var="f" varStatus="i">
								<tr>
									<td>${i.count }</td>
									<td>${f.KeyOfEn }</td>
									<td>${f.FiledName }</td>
									<td><input id="CB_Visable_" type="checkbox" name="CB_Visable_" /><label for="CB_Visable_">可见</label></td>
									<td><input id="CB_Enable_" type="checkbox" name="CB_Enable_" /><label for="CB_Enable_">可用</label></td>
								</tr>
								</c:forEach>
							</table>
						</div></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" name="Btn_Save"  value="保存" id="Btn_Save" /> 
						<input type="submit" name="Btn_SaveAndClose" value="保存并关闭" id="Btn_SaveAndClose" /> 
						<input type="button" name="Btn_Close" value="关闭" id="Btn_Close"  onclick="javascript:window.close();" />
					</td>
				</tr>
			</table>
		</div>
</form>
</body>
</html>