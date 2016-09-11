<%@page import="cn.jflow.common.model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = BP.WF.Glo.getCCFlowAppPath();
	String rptNo = request.getParameter("RptNo");
	String fkFlow = request.getParameter("FK_Flow");
	SearchModel sm = new SearchModel(request, response);
	String toolBar = sm.initToolBar();
	String pub = sm.initPub();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>查询</title>
<style type="text/css">
html, body {
	height: 100%;
	margin: 0 auto;
}
</style>
<link href="<%=basePath%>WF/Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>WF/Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>WF/Scripts/easyUI/themes/icon.css"	rel="stylesheet" type="text/css" />
<script src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=basePath%>WF/Comm/JS/Calendar/WdatePicker.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=basePath%>WF/Comm/JScript.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" onload="load()">
	<input type="hidden" id="success" value="${success }" />
	<div id="mainDiv" data-options="region:'center',title:'查询'"
		style="padding: 5px">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',noheader:true,split:false"
				style="padding: 2px; height: auto; background-color: #E0ECFF; line-height: 30px">
				<form id="searchBtnHtml" style="height: 100%" method="post">
					<input type="hidden" id="inputValue" name="inputValue" value="">
						<div style='float:right'><a href='<%=basePath%>WF/Rpt/OneFlow.jsp?FK_MapData=<%=sm.getFK_MapData() %>&FK_Flow=<%=sm.getFK_Flow() %>' ><img src='<%=basePath%>WF/Img/Setting.png' width='12px' border=0/>&nbsp;设置</a></div>
						<div id="toolbar_div"><%=toolBar%></div>
				</form>
				
			</div>
			<div id="pub" data-options="region:'center',noheader:true,border:false">
				<%=pub%>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function WinOpen(url, winName) {
    var newWindow = window.open(url, winName, 'height=800,width=1030,top=' + (window.screen.availHeight - 800) / 2 + ',left=' + (window.screen.availWidth - 1030) / 2 + ',scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
    newWindow.focus();
    return;
}
function OpenAttrs(ensName) {
    var url = './../../Sys/EnsAppCfg.jsp?EnsName=' + ensName;
    var s = 'dialogWidth=680px;dialogHeight=480px;status:no;center:1;resizable:yes'.toString();
    val = window.showModalDialog(url, null, s);
    window.location.href = window.location.href;
}
function DDL_mvals_OnChange(ctrl, ensName, attrKey) {
if(ensName=='null'){return; }
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
function __doPostBack(eventTarget, eventArgument) {
	var theForm = document.forms['form1'];
    if (!theForm) {
        theForm = document.form1;
    }
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
function ddl_SelectedIndexChanged_GoTo(){
	var item = $("#GoTo").val();
    var tKey = new Date();
	var s1="D3";
	var s2="Contrast";
    if(item==s2){
    	alert("此功能正在升级,敬请期待.");
    	return;
    }
    window.location="<%=basePath%>WF/Rpt/" + item + ".jsp?RptNo=<%=sm.getRptNo()%>&FK_Flow=<%=sm.getFkFlow()%>&T="+tKey;
	
}
function ToolBar1_ButtonClick(btnName){
	$("#inputValue").val($("#toolbar_div").html());
	var url = "<%=basePath%>WF/Rpt/Search.do?RptNo=<%=sm.getRptNo()%>&FK_Flow=<%=sm.getFkFlow()%>&btnName=" + btnName;
	if(btnName=='Btn_Search'){
		search();
	}else{
		//$("#searchBtnHtml").attr("action", url);
		//$("#searchBtnHtml").submit();
		 doExp();
	}
	
}

    //查询
	function search() {
		$("#inputValue").val($("#toolbar_div").html());
			$.ajax({
				cache: true,
				type: "POST",
		        url:"<%=basePath%>WF/Rpt/btn_search.do?RptNo=<%=sm.getRptNo()%>&FK_Flow=<%=sm.getFkFlow()%>",
				data:$('#searchBtnHtml').serialize(),
			    success: function(data) {
					var obj=eval("("+data+")");
					$("#pub").html('');
					$("#pub").html(obj.pub);
			    },
			    error:function(data){
			    	alert('error');
			    }
		    });
	}
	
	//导出
	function doExp() {
		 $("#inputValue").val($("#toolbar_div").html());
		 $.ajax({
			cache: true,
			type: "POST",
	        url:"<%=basePath%>WF/Rpt/ExpExel.do?RptNo=<%=sm.getRptNo()%>&FK_Flow=<%=sm.getFkFlow()%>",
			data:$('#searchBtnHtml').serialize(),
		    success: function(data) {
				 window.open(data);
		    },
		    error:function(data){
		    	alert('error');
		    }
	   });
	}
	
	function load() {
		var successStr = $("#success").val();
		if (successStr.length == 0) {
			return;
		} else {
			alert(successStr);
		}
	}
</script>
</html>