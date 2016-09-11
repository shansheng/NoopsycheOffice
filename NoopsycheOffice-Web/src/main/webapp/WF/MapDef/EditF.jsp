<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	EditFModel edit = new EditFModel(request, response);
	edit.init();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target=_self  />
<title><%=edit.getTitle()%></title>
<script language="JavaScript" src="<%=Glo.getCCFlowAppPath() %>WF/Comm/JScript.js"></script>
<script language=javascript>
    /* ESC Key Down */
        function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
    function btn_Save_Click(btnName){
    	var param = window.location.search;
    	$("#FormHtml").val($("#form1").html());
    	if(btnName=='Btn_Del'){
    	if (window.confirm('您确认吗?') == false)
            return;
    	}
        
        var url = "<%=basePath%>WF/MapDefEditF/btn_Save_Click.do"+param+"&btnName="+btnName+"&RefNo=<%=edit.getRefNo()%>";
        if(url.indexOf("RefNo=null")>-1){//修复重复保存问题  qin
        	 var TB_KeyOfEn=$('#TB_KeyOfEn').val();
        	 var refNo="<%=edit.getMyPK()%>"+"_"+TB_KeyOfEn;
        	 url=url.replace("RefNo=null","RefNo="+refNo);
        }
		$("#form1").attr("action",url);
		$("#form1").submit();
    }
    function ddl_SelectedIndexChanged_DefVal(){
    	var obj=document.getElementById('DDL_SelectDefVal');
    	var text=obj.options[obj.selectedIndex].value;
    	var tb=document.getElementById("TB_DefVal");
    		tb.value=text;
    }
    function ddlType_SelectedIndexChanged(){
    	$("#FormHtml").val($("#form1").html());
        var url = "<%=basePath%>WF/MapDefEditF/ddlType_SelectedIndexChanged.do?DoType=<%=edit.getDoType()%>&MyPK=<%=edit.getMyPK()%>&RefNo=<%=edit.getRefNo()%>&FType=<%=edit.getFType()%>&GroupField=<%=edit.getGroupField()%>";
		$("#form1").attr("action",url);
		$("#form1").submit();
    }
    function btn_Click(btnName){
    	$("#FormHtml").val($("#form1").html());
        var url = "<%=basePath%>WF/MapDefEditF/btn_Click1.do?DoType=<%=edit.getDoType()%>&MyPK=<%=edit.getMyPK()%>&RefNo=<%=edit.getRefNo()%>&FType=<%=edit.getFType()%>&GroupField=<%=edit.getGroupField()%>&btnName="+ btnName;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	function ddlBig_SelectedIndexChanged() {
		var obj = document.getElementById('DDL_TBModel');
		var text = obj.options[obj.selectedIndex].value;
		var tbm = document.getElementById("TB_MaxLen");
		var tbu = document.getElementById("TB_UIHeight");
		if (text == "0") {
			tbm.value = "400";
			tbm.disabled = true;
		} else {
			tbm.value = "4000";
			tbu.value = "390";
			tbm.disabled = false;
		}
	}
	function cb_CheckedChanged() {
		var tbm = document.getElementByName("TB_MaxLen");
//		var tbu = document.getElementByName("TB_UIHeight");
		if (document.getElementByName("CB_IsM").checked) {
			tbm.disabled = false;
			tbm.value = "4000";
			tbu.value = "90";
		} else {
			tbm.disabled = true;
			tbm.value = "50";
		}
	}
	function cb_CheckedChanged_rdt() {
		var tbd = document.getElementById("TB_DefVal");
		if (document.getElementById("CB_DefVal").checked) {
			tbd.value = "@RDT";
		} else {
			tbd.value = "";
		}
	}
	
	function displayResult(){
		var tbv=document.getElementById("TB_Name").value;
		tbv=encodeURI(tbv);
		$.ajax({ //一个Ajax过程 
			type: "get", 
			url : "<%=basePath%>WF/MapDefEditF/parse.do?parse="+tbv, 
			dataType:'json',
			success: function(json){
				//var obj = eval ("(" + json + ")");
				//alert(obj);
				document.getElementById("TB_KeyOfEn").value=json.result;
			} 
		}); 
	}
	
</script>
<base target=_self />
<link href="../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
</head>
<body onkeypress="Esc()">
	<form id="form1" method="post"
		action="EditF.jsp?DoType=<%=edit.getDoType()%>&amp;MyPK=<%=edit.getMyPK()%>&amp;RefNo=<%=edit.getRefNo()%>&amp;FType=<%=edit.getFType()%>&amp;GroupField=<%=edit.getGroupField()%>"
		class="am-form">
		<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div align=center width='90%'>
			<%=edit.Pub1.ListToString()%>
		</div>
	</form>
</body>
</html>