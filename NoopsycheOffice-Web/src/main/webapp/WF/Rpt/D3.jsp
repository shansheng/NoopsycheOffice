<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="cn.jflow.common.model.D3Model"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
String rptNo = request.getParameter("RptNo");
String fkFlow = request.getParameter("FK_Flow");
D3Model dm=new D3Model(request,response);
dm.InitLeft();
dm.Page_Load();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=basePath%>WF/Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>WF/Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>WF/Scripts/easyUI/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>WF/Scripts/easyUI/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="<%=basePath %>WF/Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath %>WF/Comm/JS/Calendar/WdatePicker.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=basePath %>WF/Comm/JScript.js" type="text/javascript"></script>

<script type="text/javascript" language="JavaScript">
function ddl_SelectedIndexChanged_Goto(){
	
	var item = $("#GoTo").val();
    var tKey = new Date();
	var s1="D3";
	var s2="Contrast";
    if(item==s2){
    	alert("此功能正在升级,zhi敬请期待.");
    	return;
    }
    window.location="<%=basePath %>WF/Rpt/" + item + ".jsp?RptNo=<%=rptNo %>&FK_Flow=<%=fkFlow %>&T="+tKey;
}
    //  事件.
    function DDL_mvals_OnChange(ctrl, ensName, attrKey) {
        var idx_Old = ctrl.selectedIndex;
        if (ctrl.options[ctrl.selectedIndex].value != 'mvals')
            return;
        if (attrKey == null)
            return;
        var timestamp = Date.parse(new Date());
        var url = 'SelectMVals.jsp?EnsName=' + ensName + '&AttrKey=' + attrKey + '&D=' + timestamp;
        var val = window.showModalDialog(url, 'dg', 'dialogHeight: 450px; dialogWidth: 450px; center: yes; help: no');
        if (val == '' || val == null) {
            ctrl.selectedIndex = 0;
        }
    }
    function Cell(d1, d2, paras) {
    }
    function ToolBar1_ButtonClick(btnName){
    	
    	var tKey = new Date();
    	alert("34");
    	var url = "<%=basePath %>WF/Rpt/ToolBar1_ButtonClick.do?RptNo=<%=rptNo %>&FK_Flow=<%=fkFlow %>&btnName="+btnName+"&T="+tKey;
    	$("#form1").attr("action",url);
    	$("#form1").submit();
    }
</script>
<title>Insert title here</title>
</head>
<body >
<div class="easyui-layout" data-options="fit:true">
<form method="post" id="form1" style="height:100%">
    <div data-options="region:'north',noheader:true,split:false" style="padding: 2px;height: auto; background-color: #E0ECFF; line-height:30px">
       <!--  <uc1:ToolBar ID="ToolBar1" runat="server" /> -->
        <%=dm.toolBar1.toString() %>
    </div>
    <div data-options="region:'west',title:'分析条件'" style="padding: 5px; width: 200px;">
        <!-- <uc2:Pub ID="Left" runat="server" /> -->
        <%=dm.Left.toString() %>
    </div>
    <div data-options="region:'center'" style="padding: 5px;">
<!--         <uc2:Pub ID="Right" runat="server" /> -->
        <%=dm.Right.toString() %>
    </div>
</form>
</div>

</body>
</html>