<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<style  type="text/css" >
ul
{
    
}
</style>
<%
	String frmID = request.getParameter("FK_MapData");
	BP.Sys.Frm.MapData md=new BP.Sys.Frm.MapData(frmID);
	int  nodeID = Integer.parseInt(request.getParameter("FK_Node"));
	BP.WF.Node nd=new BP.WF.Node(nodeID);
	
	boolean RB_0=false;
	boolean RB_1=false;
	boolean RB_2=false;
	boolean RB_3=false;
	boolean RB_4=false;
	String TB_SQL = "";
	//Node nd= new Node(this.FK_Node);
   BP.WF.Template.FrmNode fn = new BP.WF.Template.FrmNode(nd.getFK_Flow(), nd.getNodeID(), frmID);
   if(fn.getFrmEnableRole().equals(BP.WF.Template.FrmEnableRole.Allways))
   {
	   RB_0 = true;
   }else if(fn.getFrmEnableRole().equals(BP.WF.Template.FrmEnableRole.WhenHaveData)){
	   RB_1 = true;
   }else if(fn.getFrmEnableRole().equals(BP.WF.Template.FrmEnableRole.WhenHaveFrmPara)){
	   RB_2 = true;
   }else if(fn.getFrmEnableRole().equals(BP.WF.Template.FrmEnableRole.ByFrmFields)){
	   RB_3 = true;
   }else if(fn.getFrmEnableRole().equals(BP.WF.Template.FrmEnableRole.BySQL)){
	   RB_4 = true;
	   TB_SQL = fn.getFrmEnableExp();
   }
%>
<script type="text/javascript">
	function Btn_SaveAndClose_Click(){
		//FK_Node FK_MapData xxx TB_SQL
		var xxx=$("input[name=xxx]:checked").attr("id");
		var TB_SQL=$("#TB_SQL").val();
		$.ajax({
			url:'<%=basePath%>WF/FrmEnableRole/Save.do?FK_MapData=<%=frmID%>',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{xxx:xxx,TB_SQL:TB_SQL,FK_Node:<%=nodeID%>},
			async: false ,
			error: function(data){
				alert("保存失败");
			},
			success: function(data){
				alert("保存成功");
			}
		});
		window.close();
	}
</script>
</head>
<body">
	<table  style=" width:100%;">

<caption>节点[<%=nd.getName()%>] - 表单[<%=md.getName()%>]</caption>

<tr>
<td>

<fieldset>
<legend><input type="radio" <%if(RB_0){ %>checked="checked"<%} %> ID="RB_0" runat="server" value="始终启用" name="xxx" />始终启用</legend>
<ul >
<li>始终启用该表单，任何情况下都启用该表单。</li>
</ul>
</fieldset>

<fieldset>
<legend><input type="radio" <%if(RB_1){ %>checked="checked"<%} %> ID="RB_1" runat="server" value="有数据时启用"  name="xxx" />有数据时启用</legend>
<ul>
<li>如果当前节点有数据，就要启用它，如果当前节点有数据初始化数据，就启用该表单。</li>
</ul>
</fieldset>

<fieldset>
<legend><input type="radio" <%if(RB_2){ %>checked="checked"<%} %> ID="RB_2" runat="server" value="有参数时启用" name="xxx" />有参数时启用</legend>
<ul>
<li>当外面的参数传递过来该表单ID的时候，就启用该表单。</li>
<li>通过外部的URL传递过来的参数，这个参数名称是固定的 Frms，比如:&Frms=Demo_Frm1，Demo_Frm1是一个表单ID.</li>
<li> 如果多个表单用逗号分开，比如：&Frms=Demo_Frm1,Demo_Frm2,Demo_Frm3</li>
</ul>
</fieldset>

<fieldset>
<legend><input type="radio" <%if(RB_3){ %>checked="checked"<%} %> ID="RB_3" runat="server" value="表单字段表达式成立的时候(未完成)." name="xxx" />表单字段表达式成立的时候(未完成).</legend>
<ul>
<li>当指定表单的指定的字段等于特定的值的时候，该表单启用。</li>
<li>指定方式类似于方向条件，比如：当金额大于xxx元时。</li>
</ul>
</fieldset>


<fieldset>
<legend><input type="radio" <%if(RB_4){ %>checked="checked"<%} %> ID="RB_4" runat="server" value="当SQL表达式返回大于0的数据的时" name="xxx" />当SQL表达式返回大于0的数据的时</legend>
<ul>
<li>请配置一个SQL语句该语句支持cc表达式,并且返回一行一列，如果该值大于0，这个表单就启用，否则就不启用。</li>
</ul>

<textArea ID="TB_SQL" runat="server" value="" TextMode="MultiLine" Rows="4"  Columns="80" style="width:95%;"><%=TB_SQL %>
</textArea>
  
</fieldset>
 </td>
</tr>


<tr>
<td>
  <input type="button" ID="Btn_SaveAndClose" runat="server" value="保存并关闭" 
        onclick="Btn_SaveAndClose_Click()" />
    <input type="button" ID="Btn_Close" runat="server" value="关闭"  onclick="javascript:window.close()" />
</td>
</tr>
</table>
</body>
</html>