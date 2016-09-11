<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@ page import="BP.Sys.Frm.MapExtAttr"%>
<%@ page import="BP.Sys.Frm.MapAttrs"%>
<%@ page import="BP.Sys.Frm.MapAttr"%>
<%@ page import="BP.Sys.Frm.MapExt"%>
<%@ page import="BP.Sys.Frm.MapDtls"%>
<%@ page import="BP.Sys.Frm.MapDtl"%>
<%@ page import="BP.Sys.SysEnums"%>
<%@ page import="BP.Sys.SysEnum"%>
<%@ page import="BP.En.FieldTypeS"%>
<body>
<%
String MyPK = request.getParameter("MyPK");
MapExt myme = new MapExt(MyPK);
MapAttrs attrs = new MapAttrs(myme.getFK_MapData());
String[] strs = myme.getTag().split("$");
String LabJLZD = "";
String TB_SQL = "";
for (MapAttr attr : MapAttrs.convertMapAttrs(attrs))
{
	if (attr.getLGType() == FieldTypeS.Normal)
	{
		continue;
	}
	if (attr.getUIIsEnable() == false)
	{
		continue;
	}
	for (String s : strs)
	{
		if (s == null)
		{
			continue;
		}
		if (s.contains(attr.getKeyOfEn() + ":") == false)
		{
			continue;
		}
		String[] ss = s.split(":");
		TB_SQL=ss[1]; //填充文本
	}
	LabJLZD=(attr.getName() + " " + attr.getKeyOfEn() + " 字段"); //填充lab控件
}

%>
 <style type="text/css">
    .style1
    {
        width: 451px;
        height: 127px;
    }
  </style>
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
<caption><a href="javascript:void(0)" onclick="history.go(-1)">返回</a>设置级连菜单 </caption>

<tr>
<td style="width:70%;"  valign="top"  >  
<fieldset>
    <div>发文密级<label ID="LabJLZD" runat="server" Text="Label"><%=LabJLZD %></label>字段</div>
<textArea ID="TB_SQL" runat="server" TextMode="MultiLine"  Rows="5" ToolTip="点击标签显示帮助."  style="Width:95%"><%=TB_SQL %></textArea>
</fieldset> 
 </td>
</tr>
<tr>
<td colspan="2">
    <input type="button" ID="Btn_Save" runat="server" value="保存" onclick="onSave(0)" />
     <input type="button" ID="Btn_SaveAndClose" runat="server" value="保存并关闭" 
        onclick="onSave(1)" />
    <input value="关闭" type="button"  onclick="javascript: window.close();" />
 </td>
</tr>



</table>
</body>
<script>
	//$("img").attr("src","Img/TBCtrlFull.png");
	
	//ajax 提交
	function onSave(x){
		var keys = "";
		var TB_SQL=$("#TB_SQL").val();
		//var DDL_DBSrc=$("#DDL_DBSrc").val();
		$.ajax({
			url:'<%=basePath%>WF/TBFullCtrlList/Btn_Save_Click.do?MyPK=<%=MyPK%>',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{TB_SQL:TB_SQL},
			async: false ,
			error: function(data){
				alert(data.msg);
			},
			success: function(data){
				alert(data.msg);
			}
		});
		if(x>0){
			window.close();
		}
	}
</script>
</html>