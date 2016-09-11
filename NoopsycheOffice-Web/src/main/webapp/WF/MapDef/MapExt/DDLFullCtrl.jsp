<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@page import="cn.jflow.model.wf.mapdef.mapext.*"%>
<%
DDLFullCtrlModel dfc=new DDLFullCtrlModel(request, response);
dfc.init();
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
		var myPk='<%=dfc.getMyPK()%>';
		var RefNo='<%=dfc.getRefNo()%>';
		var FK_MapData='<%=dfc.getFK_MapData()%>';
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
	function btn_Del_Click(){
		var myPk='<%=dfc.getMyPK()%>';
		var RefNo='<%=dfc.getRefNo()%>';
		var FK_MapData='<%=dfc.getFK_MapData()%>';
		var url='<%=basePath%>wf/ddlFullCtrl/Btn_Delete_Click.do?myPk='+myPk+'&RefNo='+RefNo+'&FK_MapData='+FK_MapData;
		 if(confirm("确定要删除数据吗")){
			 $.ajax({  
		      type:'post',  
		      url:url,  
		      data:{},  
		      cache:false,  
		      success:function(data){
		    	  if(data="success"){
		    		  alert("删除成功！");
		    		  $("#TB_SQL").val('');
		    	  }
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
		<div data-options="region:'center',title:''" style="padding:5px;">

			<table style=" width:100%;">
			<caption>为下拉框【<%=dfc.getRefNo()%>】设置自动填充 </caption>
			<tr>
			<td class="Idx">1</td>
			<td valign="top" colspan="2"  style=" width:100%;" >  
			<a href="javascript:ShowHidden('sqlexp')" >自动填充SQL: </a>
			 <div id="sqlexp" style="color:Gray; display:none">
			 <ul>
			 <li>设置一个查询的SQL语句，必须返回No,Name两个列，用于显示下拉列表，其他的列与字段名称对应以便系统自动对应填充。</li>
			 <li>比如:SELECT Name as CZYName, Tel as DianHua, Email as YouJian FROM WF_Emp WHERE No like '@Key%' </li>
			 <li>ccform为您准备了一个demo,请参考表单库\\本机数据源\\表单元素\\基础功能</li>
			 <li><img alt="" src="../Img/TBCtrlFull.png" /></li>
			 </ul>
			 </div>
			  <textarea name="TB_SQL" rows="5" cols="20" id="TB_SQL" title="点击标签显示帮助." style="width:95%;"><%=dfc.getTbSql() %></textarea> 
			 </td>
			</tr>
			
			
			<tr>
			<td class="Idx">2</td>
			<td valign="top" >  <a href="javascript:ShowHidden('dbsrc')" >执行SQL的数据源: </a>
			<div id="dbsrc" style="color:Gray; display:none">
			 <ul>
			   <li>ccform支持从其它数据源里获取数据.</li>
			   <li>您可以在系统维护里维护数据源.</li>
			 </ul>
			 </div>
			</td>
			<td  style="width:50%;">
			 <select name="DDL_DBSrc" id="DDL_DBSrc">
			 	<c:forEach items="<%=dfc.getDDL_DBSrc() %>" var="op" varStatus="i">
			 		<option value="${op.s_val }" ${op.selected }>${op.s_name }</option>
			 	</c:forEach>
			</select>
			 </td>
			</tr>
			
			
			<tr>
			<td colspan="3">
			    <input type="button" name="Btn_Save" value="保存" id="Btn_Save" onclick="btn_Save_Click('1');" />
			    <input type="button" name="Btn_SaveAndClose" value="保存并关闭" id="Btn_SaveAndClose" onclick="btn_Save_Click('2');" />
			    <input value="关闭" type="button"  onclick="javascript:window.close();" />
			
			
			    <input type="submit" name="Btn_FullDtl" value="填充从表(暂未实现)" id="Btn_FullDtl" title="当数据填充后，需要改变指定的从表数据。比如：主表选择人员，从表人员简历信息。" />
			    <input type="submit" name="Btn_FullDDL" value="填充下拉框(暂未实现)" id="Btn_FullDDL" title="当数据填充后，需要改变指定的下拉框内容。比如：选择人员后，有一个人员岗位的下拉框，该下拉框的内容仅仅需要显示人员岗位。" />
			    <input type="button" name="Btn_Delete" value="删除" onclick="btn_Del_Click();" id="Btn_Delete" />
			  </td>
			</tr>
			</table>
    </div>
</form>
</body>
</html>