<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<body>
<script type="text/javascript">
	function ShowHidden(ctrlID) {

            var ctrl = document.getElementById(ctrlID);
            if (ctrl.style.display == "block") {
                ctrl.style.display = 'none';
            } else {
                ctrl.style.display = 'block';
            }
        }
	
	
</script>
<table style="width:100%">
<caption>为字段[<%=request.getParameter("RefNo") %>]设置pop返回值</caption>

<%
  String fk_mapdata=request.getParameter("FK_MapData");
  String refNo=request.getParameter("RefNo");
    
   BP.Sys.Frm.MapData md=new BP.Sys.Frm.MapData(fk_mapdata);
   //查询出实体.
   BP.Sys.Frm.MapExt ext = new BP.Sys.Frm.MapExt();
   int i= ext.Retrieve(BP.Sys.Frm.MapExtAttr.FK_MapData, fk_mapdata, 
		   BP.Sys.Frm.MapExtAttr.ExtType, "PopVal",
		   BP.Sys.Frm.MapExtAttr.AttrOfOper, refNo);
   boolean Btn_Delete = false;
   boolean RB_Model_Inntel = false;
   boolean RB_Model_Url =  false;
   boolean RB_Table = false;
   boolean RB_Tree = false;
   boolean RB_PopValSelectModel_0 = false;
   boolean RB_PopValSelectModel_1 = false;
   boolean RB_PopValFormat_0 = false;
   boolean RB_PopValFormat_1 = false;
   boolean RB_PopValFormat_2 = false;
   String TB_Group = "";
   String TB_Entity = "";
   String TB_URL = "";
    //实例化控件值.
	if (i == 0)
	{
	   Btn_Delete=true;
	}
    else
    {
	  Btn_Delete=false;
    }

	// 工作模式 0 -url .1-内置
	if (ext.getPopValWorkModel() == 1)
	{
		RB_Model_Inntel = true;
	}
	else
	{
		RB_Model_Url = true;
	}

	// 数据呈现方式
	if (ext.getPopValShowModel() == 0)
	{
		RB_Table = true;
	}
	else
	{
		RB_Tree = true;
	}

	//选择数据方式
	if (ext.getPopValSelectModel() == 0)
	{
		RB_PopValSelectModel_0 = true;
	}
	else
	{
		RB_PopValSelectModel_1 = true;
	}

	if (ext.getPopValFormat() == 0)
	{
		RB_PopValFormat_0 = true;
	}

	if (ext.getPopValFormat() == 1)
	{
		RB_PopValFormat_1 = true;
	}

	if (ext.getPopValFormat() == 2)
	{
		RB_PopValFormat_2 = true;
	}

	//数据源分组sql
	TB_Group=ext.getTag1();
	//数据源sql
	TB_Entity=ext.getTag2();
	// rul
	TB_URL=ext.getDoc();
  %>

<tr>
<td valign="top" > 
<fieldset>
 <legend><input type="radio" <%if(RB_Model_Inntel){ %>checked="checked"<%} %> ID="RB_Model_Inntel" runat="server" Text="" name="Model"  />ccform内置URL </legend>
 <table style=" width:100%;">
 <tr> 
 <td  colspan="2">
 <a href="javascript:ShowHidden('group')" >数据源分组SQL:</a>
 <div id="group" style="color:Gray; display:none">
 <ul>
 <li>设置一个查询的SQL语句，必须返回No,Name两个列。</li>
 <li>比如:SELECT No,Name FROM Port_Dept </li>
 <li>如果内容需要树形的方式展示，需要返回约定的三个列。</li>
 <li>比如:SELECT No,Name,ParentNo FROM Port_Dept </li>
 <li>该参数可以为空,为空的时候，就不能以树的方式展示了，系统就会使用Table的方式把数据内容展示出来。</li>
 </ul>
 </div>
   <textArea  value="" ID="TB_Group" runat="server" TextMode="MultiLine" Rows="2" ToolTip="参数支持ccbpm的表达式,点击标签显示帮助."  style="width:95%"><%=TB_Group %></textArea></td>
 </tr>

 <tr> 

 <td colspan="2" >
 <a href="javascript:ShowHidden('en')">数据源SQL:</a>
 <div id="en" style="color:Gray; display:none">
 <ul>
 <li>该参数可以为空. </li>
 <li>可以配置一个查询语句，该语句，支持ccbpm的表达式。</li>
 <li>Demo:有分组, SELECT No,Name,FK_Dept FROM Port_Emp </li>
 <li>Demo:无分组: SELECT No,Name FROM Port_Emp </li>
 </ul>
 </div>

   <textArea value="" ID="TB_Entity" runat="server" TextMode="MultiLine"  Rows="2" ToolTip="参数支持ccbpm的表达式,点击标签显示帮助." style="width:95%"><%=TB_Entity %></textArea> </td>
 </tr>
 
  <tr> 

 <td style="width:30%">
 <a href="javascript:ShowHidden('showway')">数据呈现方式:</a>
 <div id="showway" style="color:Gray; display:none">
 <ul>
 <li>配置的数据显示的风格. </li>
 <li>如果需要树形的解构显示，分组数据源必须是树解构的数据。</li>
 </ul>
 </div>

 
 </td>
  <td>
  <input type="radio" <%if(RB_Table){ %>checked="checked"<%} %> ID="RB_Table" Text="" runat="server" name="ShowWay" />表格方式
&nbsp;<input type="radio" <%if(RB_Tree){ %>checked="checked"<%} %> ID="RB_Tree" Text="" runat="server"  name="ShowWay" />树形方式
      </td>
 </tr>

 
  <tr> 

 <td >
 <a href="javascript:ShowHidden('select')">选择数据方式:</a>
 <div id="select" style="color:Gray; display:none">
 <ul>
 <li>单项选择，就是每次只能选择一个项目,每个内容使用的是RadioButton控件. </li>
 <li>多项选择，每次可以选择多个项目，使用checkbox控件展示数据。</li>
 <li>多项选择返回的数据使用“;”分开。</li>
 </ul>
 </div>

  </td>
  <td>
  <input type="radio" <%if(RB_PopValSelectModel_0){ %>checked="checked"<%} %> ID="RB_PopValSelectModel_0" Text="" runat="server" name="xxxx" />多项选择
&nbsp;<input type="radio" <%if(RB_PopValSelectModel_1){ %>checked="checked"<%} %> ID="RB_PopValSelectModel_1" Text="" runat="server"  name="xxxx" />单项选择
      </td>
 </tr>
 

<tr> 

 <td colspan=2>
 <a href="javascript:ShowHidden('back')">返回值格式:</a>
 <div id="back" style="color:Gray; display:none">
 <ul>
 <li>以什么样的格式返回到文本框上。</li>
 <li>如果是接受人文本框需要使用“;”分开。</li>
 <li>比如：发送给：xxxxx;uuu;  抄送给：yyyy;xxxx;</li>
 </ul>
 </div>
  <br />
 <input type="radio" <%if(RB_PopValFormat_0){ %>checked="checked"<%} %> ID="RB_PopValFormat_0" runat="server" Text="" name="back" />No(仅编号)
 <input type="radio" <%if(RB_PopValFormat_1){ %>checked="checked"<%} %> ID="RB_PopValFormat_1" runat="server" Text="" name="back" />Name(仅名称)
 <input type="radio" <%if(RB_PopValFormat_2){ %>checked="checked"<%} %> ID="RB_PopValFormat_2" runat="server" Text="" name="back" />No,Name(编号与名称,比如zhangsan,张三;lisi,李四;)
      </td>
 </tr>
 </table>
</fieldset>


<fieldset>
 <legend><input type="radio" <%if(RB_Model_Url){ %>checked="checked"<%} %> ID="RB_Model_Url" runat="server" Text="" name="Model" />自定义URL </legend>
 <a href="javascript:ShowHidden('url')">&nbsp;请输入一个URL:</a>
 <div id="url" style="color:Gray; display:none">
 <ul>
 <li>您选择了使用外部的URL. </li>
 <li>使用外部的URL，我们提供了一个demo,您需要按照自己的格式来编写该url.</li>
 <li>该demo的位置 /SDKFlowDemo/SDKFlowDemo/PopSelectVal.aspx </li>
 </ul>
 </div>
    <input type="text" value="<%=TB_URL %>" ID="TB_URL" runat="server" ToolTip="参数支持ccbpm的表达式,点击标签显示帮助."  style="Width:95%"/>
</fieldset>

  </td>

   
</tr>

<tr>
<td colspan=2  > 
    <input type="button" ID="Btn_Save" runat="server" value="保存" onclick="save(0)" />
    <input type="button" ID="Btn_SaveAndClose" runat="server" value="保存&关闭" 
        onclick="save(0)" />
        <input type=button value="关闭"  onclick="window.close()" />

        <input type="button" ID="Btn_Delete" runat="server" value="删除" <%if(Btn_Delete ){ %>style="display:none;"<%} %>
        OnClientClick="return confirm('您确定要删除吗？');" 
        onclick="deleteX()"   />
    </td>
</tr>

</table>
</body>
<SCRIPT>
//ajax 提交
	function save(x){
		var Model=$("input[name=Model]:checked").attr("id");
		var ShowWay=$("input[name=ShowWay]:checked").attr("id");
		var back=$("input[name=back]:checked").attr("id");
		var xxxx=$("input[name=xxxx]:checked").attr("id");
		var TB_Group=$("#TB_Group").val();
		var TB_Entity=$("#TB_Entity").val();
		var TB_URL=$("#TB_URL").val();
		var fk_mapdata = '<%=fk_mapdata%>';
		var refNo = '<%=refNo%>';
		//alert(fk_mapdata);
		//alert(refNo);
		$.ajax({
			url:'<%=basePath%>WF/PopVal/savex.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{Model:Model,ShowWay:ShowWay,back:back,xxxx:xxxx,TB_Group:TB_Group,TB_Entity:TB_Entity,TB_URL:TB_URL,FK_MapData:fk_mapdata,RefNo:refNo},
			async: false ,
			error: function(data){
				alert("保存失败");
			},
			success: function(data){
				alert("保存成功");
			}
		});
		if (x==1) {
			window.close();
	    }
	}
	//ajax 删除
	function deleteX(){
		var Model=$("input[name=Model]:checked").attr("id");
		var ShowWay=$("input[name=ShowWay]:checked").attr("id");
		var back=$("input[name=back]:checked").attr("id");
		var xxxx=$("input[name=xxxx]:checked").attr("id");
		var TB_Group=$("#TB_Group").val();
		var TB_Entity=$("#TB_Entity").val();
		var TB_URL=$("#TB_URL").val();
		var fk_mapdata = '<%=fk_mapdata%>';
		var refNo = '<%=refNo%>';
		$.ajax({
			url:'<%=basePath%>WF/PopVal/deleteX.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{Model:Model,ShowWay:ShowWay,back:back,xxxx:xxxx,TB_Group:TB_Group,TB_Entity:TB_Entity,TB_URL:TB_URL,FK_MapData:fk_mapdata,RefNo:refNo},
			async: false ,
			error: function(data){
				alert("删除失败");
			},
			success: function(data){
				alert("删除成功");
			}
		});
		window.close();
	}
</SCRIPT>
</html>