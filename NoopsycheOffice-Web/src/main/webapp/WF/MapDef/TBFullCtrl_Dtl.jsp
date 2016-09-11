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
<body>
<%
String MyPK = request.getParameter("MyPK");
MapExt myme = new MapExt(MyPK);
MapDtls dtls = new MapDtls(myme.getFK_MapData());
String[] strs = myme.getTag1().split("$");
String TB_SQL = "";
String LabZD = "";
String LabNo = "";
String LabName = "";

for (MapDtl dtl : MapDtls.convertMapDtls(dtls))
{
	for (String s : strs)
	{
		if (s == null)
		{
			continue;
		}

		if (s.contains(dtl.getNo() + ":") == false)
		{
			continue;
		}

		String[] ss = s.split(":");
	    TB_SQL=ss[1];
	}


	LabNo=dtl.getNo(); //编号显示
	LabName=dtl.getName(); //名称显示
	MapAttrs attrs = new MapAttrs(dtl.getNo());
	for (MapAttr item : MapAttrs.convertMapAttrs(attrs))
	{
		if ("OID".equals(item.getKeyOfEn())|| "RefPKVal".equals(item.getKeyOfEn()))
		{
			continue;
		}
		LabZD=(LabZD + item.getKeyOfEn() + ","); //可填充的字段显示
	}


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
<caption><a href="javascript:void(0)" onclick="history.go(-1)">返回</a>设置自动填充从表 </caption>

<tr>
<td style="width:70%;"  valign="top"  >  
<fieldset>
<legend><a href="javascript:ShowHidden('onblur')" >设置自动填充从表（点击查看帮助）: </a></legend>
    编号:<label ID="LabNo" runat="server" Text="Label">'<%=LabNo %>'</label>,名称:<label ID="LabName" runat="server" Text="Label">'<%=LabName %>'</label>
<textArea ID="TB_SQL" runat="server" TextMode="MultiLine"  Rows="5" ToolTip="点击标签显示帮助."  style="Width:95%">'<%=TB_SQL %>'</textArea>
    <div>可填充的字段:<label ID="LabZD" runat="server" Text="Label"><%=LabZD %></label></div>
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
	$("img").attr("src","Img/TBCtrlFull.png");
	
	//ajax 提交
	function onSave(x){
		var keys = "";
		var TB_SQL=$("#TB_SQL").val();
		//var DDL_DBSrc=$("#DDL_DBSrc").val();
		$.ajax({
			url:'<%=basePath%>WF/TBFullCtrlDtl/Btn_Save_Click.do?MyPK=<%=MyPK%>',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{TB_SQL:TB_SQL},
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
</script>
</html>