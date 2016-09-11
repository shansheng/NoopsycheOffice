<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cn.jflow.model.wf.admin.GetTaskModel" %>	
<%
	GetTaskModel gtm = new GetTaskModel(request, response);
	gtm.page_load();
%>
<%@ include file="/WF/head/head1.jsp"%>
<script  language=javascript>
function EditIt(fk_flow, nodeid) {
    var url = 'GetTask.jsp?RefNo=' + fk_flow + '&Step=3&FK_Node=' + nodeid;
    var v = window.showModalDialog(url, 'sd', 'dialogHeight: 550px; dialogWidth: 650px; dialogTop: 100px; dialogLeft: 150px; center: yes; help: no');
    window.location.href = window.location.href;
}
function Esc() {
    if (event.keyCode == 27)
        window.close();
    return true;
}
function WinOpen(url,name) {
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

function btn_Click(v){
	var nodeIds='';
	if(v=='cancel'){
		window.close();
	}else if(v=='del'){
		$.ajax({
			url:'<%=basePath%>wf/admin/getTask/btn_save.do?FK_Node=<%=gtm.getFK_Node()%>&RefNo=<%=gtm.getRefNo()%>&nodeIds='+nodeIds,
			type:'post', //数据发送方式
			async: false ,
			error: function(data){},
			success: function(data){
				if(data=='success'){
					$("input[name*='CB_']:checkbox").removeAttr("checked");
					alert("操作成功！");
				}
			}
		});
	}else{
		$("input[name*='CB_']:checkbox").each(function(){
			if(this.checked==true){
				  nodeIds+="'"+$(this).attr('value')+"',";
			}
		});
		if(nodeIds.length<=0){
			alert("您没有设置可以跳转审核的节点。");
			return false;
		}
		$.ajax({
			url:'<%=basePath%>wf/admin/getTask/btn_save.do?FK_Node=<%=gtm.getFK_Node()%>&RefNo=<%=gtm.getRefNo()%>&nodeIds='+nodeIds,
			type:'post', //数据发送方式
			async: false ,
			error: function(data){},
			success: function(data){
				if(data=='success'){
					alert("保存成功！");
				}
			}
		});
	}
}


</script>
</head>
<body onkeypress="Esc();" topmargin="0" leftmargin="0"   style="font-size:smaller">
<form method="post" action="./GetTask.jsp" id="form1">
<div>
<%=gtm.Pub1.ListToString() %>
</div>
</form>
</body>
</html>