<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@page import="cn.jflow.model.wf.mapdef.mapext.*"%>
<%
ActiveDDLModel add=new ActiveDDLModel(request, response);
add.init();
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
	
	function btn_Save_Click(){
		var myPk='<%=add.getMyPK()%>';
		var RefNo='<%=add.getRefNo()%>';
		var FK_MapData='<%=add.getFK_MapData()%>';
		var DDL_Attr=$("#DDL_Attr").val();
		var ctl12=$("#ctl12").val();
		var TB_Doc=$("#TB_Doc").val();
		var url='<%=basePath%>wf/activeDDL/btn_Save_Click.do?myPk='+myPk+'&RefNo='+RefNo+'&FK_MapData='+FK_MapData+'&DDL_Attr='+DDL_Attr+'&TB_Doc='+TB_Doc+'&ctl12='+ctl12;
		$.ajax({  
		      type:'post',  
		      url:url,  
		      data:{},  
		      cache:false,  
		      success:function(data){
		    	  if(data="success"){
		    		  alert("保存成功！");
		    	  }else{
		    		  alert(msg);
		    	  }
		       },  
		       error:function(){
		    	   alert("出错了！");
		       }  
		 });
	}
	function Btn_Delete_Click(){
		var myPk='<%=add.getMyPK()%>';
		var RefNo='<%=add.getRefNo()%>';
		var FK_MapData='<%=add.getFK_MapData()%>';
		var url='<%=basePath%>wf/activeDDL/Btn_Delete_Click.do?myPk='+myPk+'&RefNo='+RefNo+'&FK_MapData='+FK_MapData;
		if(confirm("确定要删除数据吗")){
			$.ajax({  
			      type:'post',  
			      url:url,  
			      data:{},  
			      cache:false,  
			      success:function(data){
			    	  if(data="success"){
			    		  alert("删除成功！");
			    	  }
			    	  $("#TB_Doc").val('');
			       },  
			       error:function(){
			    	   alert("出错了！");
			       }  
			 });
		 }else{
			 return null;
		 }
	}
	
</script>
</head>
<body onkeypress="Esc();" class="easyui-layout" >
<form method="post" action="" id="form1">
	<input type="hidden" id="success" value="${success }" />
		<div data-options="region:'center',title:''" style="padding: 5px;">

			<div style='width: 100%'>
				<div class='easyui-panel' title='为下拉框[<%=add.getRefNo() %>]设置联动.'
					data-options="iconCls:'icon-edit',fit:true"
					style='height: auto; padding: 10px'>
					<Table class='Table' cellpadding='0' cellspacing='0' border='0'
						style='width: 100%'>
						<TR>
							<TD class='GroupTitle' nowrap>联动下拉框：</TD>
							<TD><select name="DDL_Attr" id="DDL_Attr">
								<c:forEach items="<%=add.getLinkAgeList() %>" var="l">
									<option value="${l.value }" ${l.selected }>${l.name }</option>
								</c:forEach>
							</select></TD>
							<TD nowrap>要实现联动的菜单</TD>
						</TR>
						<TR>
							<TD class='GroupTitle' colspan=1>数据源</TD>
							<TD><select id="ctl12" name="ctl12">
								<c:forEach items="<%=add.getDataSourceList() %>" var="data">
									<option value="${data.value }"  ${data.selected }>${data.name }</option>
								</c:forEach>
s							</select></TD>
							<TD nowrap>jform允许从其他数据源中取数据,<a
								href="javascript:WinOpen('<%=basePath %>WF/Comm/Search.jsp?EnsName=BP.Sys.SFDBSrcs','d2')"><img
									src='<%=basePath %>WF/Img/Setting.png' border=0 />设置/新建数据源</a>, <a
								href="javascript:window.localhost.href=window.localhost.href;">刷新数据源</a></TD>
						</TR>
						<TR>
							<TD colspan='3' nowrap>在下面文本框中输入一个SQL,具有编号，标签列，用来绑定下从动下拉框。<br />比如:SELECT
								No, Name FROM CN_City WHERE FK_SF = '@Key' <BR> 
								<textarea
									name="TB_Doc" rows="7" cols="80" id="TB_Doc" class="TH"
									style="width: 99%;"><%=add.getBindSelectSql() %></textarea>
								<BR>说明:@Key是jflow约定的关键字，是主下拉框传递过来的值主菜单是编号的是从动菜单编号的前几位，不必联动内容。<br />比如:
								主下拉框是省份，联动菜单是城市。
							</TD>
						</TR>
						<TR>
							<TD nowrap colspan=2>
								<a href="javascript:btn_Save_Click();" id="Btn_Save" name="Btn_Save" class="easyui-linkbutton l-btn" iconcls="icon-save"> 保存</a>
								<%
								  if(add.getShowDel()>0){
								%>
								<a href="javascript:Btn_Delete_Click();" id="Btn_Del" name="Btn_Del" class="easyui-linkbutton l-btn" iconcls="icon-delete"> 删除</a>
								<%} %>
							</TD>
						</TR>
					</Table>
				</div>
			</div>

		</div>

	</form>
</body>
</html>