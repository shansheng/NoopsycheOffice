<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@ page import="BP.Sys.Frm.MapExtAttr"%>
<%@ page import="BP.Sys.Frm.MapExt"%>
<%@ page import="BP.Sys.SysEnums"%>
<%@ page import="BP.Sys.SysEnum"%>
<body>
<%
	String FK_MapData = request.getParameter("FK_MapData");
	String ExtType = request.getParameter("ExtType");
	String RefNo = request.getParameter("RefNo");
	String OperAttrKey = request.getParameter("OperAttrKey");
	String MyPK = request.getParameter("MyPK");
	
	String TB_SQL="";
	String DDL_DBSrc="";
	
	MapExt me = new MapExt();
	
	me.Retrieve(MapExtAttr.FK_MapData, FK_MapData, MapExtAttr.ExtType, MapExtAttr.ExtType, MapExtAttr.AttrOfOper, RefNo);
	TB_SQL=me.getDoc();
	System.out.println(TB_SQL);
	java.util.ArrayList arr = new java.util.ArrayList();
	SysEnums ens = new SysEnums("DBSrcType");
	
	for (SysEnum en : SysEnums.convertSysEnums(ens))
	{
		arr.add(en.getLab());
	
	}
	
	//switch (me.FK_DBSrc)
	//ORIGINAL LINE: case "1":
	if (me.getFK_DBSrc().equals("1"))
	{
			DDL_DBSrc = "SQLServer数据库";
	}
	//ORIGINAL LINE: case "100":
	else if (me.getFK_DBSrc().equals("100"))
	{
			DDL_DBSrc = "WebService数据源";
	}
	//ORIGINAL LINE: case "2":
	else if (me.getFK_DBSrc().equals("2"))
	{
			DDL_DBSrc = "Oracle数据库";
	}
	//ORIGINAL LINE: case "3":
	else if (me.getFK_DBSrc().equals("3"))
	{
			DDL_DBSrc = "MySQL数据库";
	}
	//ORIGINAL LINE: case "4":
	else if (me.getFK_DBSrc().equals("4"))
	{
			DDL_DBSrc = "Informix数据库";
	}
	else
	{
			DDL_DBSrc = "应用系统主数据库(默认)";
	}
	//this.DDL_DBSrc.DataSource = arr;
	//this.DDL_DBSrc.DataBind();

%>
<script type="text/javascript">
        function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
        function WinOpen(url, name) {
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
<table style=" width:100%;">
<caption>为文本框【<%=request.getParameter("RefNo") %>】设置自动填充 </caption>
<tr>
<td class="Idx">1</td>
<td valign="top" colspan="2"  style=" width:100%;" >  
<a href="javascript:ShowHidden('sqlexp')" >自动填充SQL: </a>
 <div id="sqlexp" style="color:Gray; display:none">
 <ul>
 <li>设置一个查询的SQL语句，必须返回No,Name两个列，用于显示下拉列表，其他的列与字段名称对应以便系统自动对应填充。</li>
 <li>比如:SELECT No,Name, Name as CZYName, Tel as DianHua, Email as YouJian FROM WF_Emp WHERE No like '@Key%' </li>
 <li>ccform为您准备了一个demo,请参考表单库\\本机数据源\\表单元素\\基础功能</li>
 <li><img alt="" class="style1" src="../Img/TBCtrlFull.png" /></li>
 </ul>
 </div>
  <textArea ID="TB_SQL" value="" runat="server" TextMode="MultiLine"  Rows="5" ToolTip="点击标签显示帮助."  style="Width:95%"><%=TB_SQL %></textArea>
 
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
 <select ID="DDL_DBSrc" runat="server">
 	<%for(int i=0;i<arr.size();i++){ %>
 		<option value="<%=arr.get(i)%>" <% if(DDL_DBSrc.equals(arr.get(i))){%> selected="selected" <% }%> ><%=arr.get(i)%></option>
 	<%} %>
 </select>
 </td>
</tr>

<tr>
<td colspan="3">
    <input type="button" ID="Btn_Save" runat="server" value="保存" onclick="onSave(0)" />
    <input type="button" ID="Btn_SaveAndClose" runat="server" value="保存并关闭" 
        onclick="onSave(1)" />
    <input value="关闭" type="button"  onclick="javascript:window.close();" />


    <input type="button" ID="Btn_FullDtl" runat="server" value="填充从表" ToolTip="当数据填充后，需要改变指定的从表数据。比如：主表选择人员，从表人员简历信息。" OnClick="Btn_FullDtl_Click()"  />
    <input type="button" ID="Btn_FullDDL" runat="server" value="填充下拉框"  ToolTip="当数据填充后，需要改变指定的下拉框内容。比如：选择人员后，有一个人员岗位的下拉框，该下拉框的内容仅仅需要显示人员岗位。" OnClick="Btn_FullDDL_Click()"  />
    <input type="button" ID="Btn_Delete"  
        OnClientClick="javascript:return confirm('您确定要删除吗？');"  runat="server" 
        value="删除" onclick="Btn_Delete_Click()" />
  </td>
</tr>
</table>
</body>
<script>
	$("img").attr("src","Img/TBCtrlFull.png");
	
	//ajax 提交
	function onSave(x){
		var keys = "";
		var TB_SQL=$("#TB_SQL").val();
		var DDL_DBSrc=$("#DDL_DBSrc").val();
		$.ajax({
			url:'<%=basePath%>WF/TBFullCtrl/Btn_Save_Click.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{TB_SQL:TB_SQL,DDL_DBSrc:DDL_DBSrc,FK_MapData:'<%=FK_MapData%>',OperAttrKey:'<%=OperAttrKey%>',ExtType:'<%=ExtType%>',RefNo:'<%=RefNo%>'},
			async: false ,
			error: function(data){
				alert("保存失败");
			},
			success: function(data){
				alert("保存成功");
			}
		});
		if(x>0){
			window.close();
		}
	}
	
	//ajax 删除
	function Btn_Delete_Click(){
		$.ajax({
			url:'<%=basePath%>WF/TBFullCtrl/Btn_Delete_Click.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{FK_MapData:'<%=FK_MapData%>',OperAttrKey:'<%=OperAttrKey%>',ExtType:'<%=ExtType%>',RefNo:'<%=RefNo%>'},
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
	
	function Btn_FullDtl_Click(){
		var url = "TBFullCtrl_Dtl.jsp?FK_MapData=<%=FK_MapData%>&MyPK=<%=MyPK%>";
		window.location.href=url;
	}
	
	function Btn_FullDDL_Click(){
		var url = "TBFullCtrl_ListNew.jsp?FK_MapData=<%=FK_MapData%>&MyPK=<%=MyPK%>";
		window.location.href=url;
	}
</script>
</html>