<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	MExtModel mem=new MExtModel(request,response,basePath);
	mem.init();
%>

<script type="text/javascript">
function WinOpen(url) {
    var newWindow = window.open(url, 'z', 'scroll:1;status:1;help:1;resizable:1;dialogWidth:680px;dialogHeight:420px');
    newWindow.focus();
    return;
}
function LoadRETemplete(fk_mapdata, keyOfEn, myPK) {
    var url = 'RETemplete.jsp?FK_MapData=' + fk_mapdata + '&ForCtrl=' + keyOfEn + '&KeyOfEn=' + keyOfEn;
    var v = window.showModalDialog(url, 'dsd', 'dialogHeight: 550px; dialogWidth: 650px; dialogTop: 100px; dialogLeft: 150px; center: yes; help: no');
    window.location.href = window.location.href;
}
</script>
<script type="text/javascript">
    function DoDel(mypk,fk_mapdata,extType) {
        if (window.confirm('您确定要删除吗？') == false)
            return;
        window.location.href = 'MapExt.jsp?DoType=Del&FK_MapData=' + fk_mapdata + '&ExtType=' + extType + '&MyPK=' + mypk;
    }
    
    function btn_SaveJiLian_Click(){
    	var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveJiLian.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
    }
    
    function rb_CheckedChanged(){
    	var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/RBCheckChange.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
    }
    
    function btn_SaveInputCheck_Click(){
    	var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveInputCheck.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
    }
    
	function BindRegularExpressionEdit_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/ExpressionEdit.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
   
	function btn_SavePopVal_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SavePopVal.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function btn_SaveAutoFull_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveAutoFull.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function mybtn_SaveAutoFullDtl_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveAutoFullDtl.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function mybtn_CancelAutoFullDtl_Click(){
		var param = window.location.search;
		location.href="MapExt.jsp"+params;
	}
	
	function mybtn_SaveAutoFullM2M_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveAutoFullM2M.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function btn_Save_AutoFullDLL_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/AutoFullDLL.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function BindLinkEdit_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/BindLinkEdit.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function BindLinkDelete_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/BindLinkDelete.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function mybtn_SaveAutoFullJilian_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveAutoFullJilian.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
	function btn_SavePageLoadFull_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SavePageLoadFull.do"+param;
		$("#form1").attr("action", url);
		$("#url").val(param);
		$("#form1").submit();
	}
	
	function btn_SaveReTemplete_Click(){
		var param = window.location.search;
		$("#FormHtml").val($("#form1").html());
		var url = "<%=basePath%>DES/SaveReTemplete.do"+param;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	
</script>
<body>

		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'west',split:true,title:'功能列表'"
				style="width: 200px">
				<%=mem.Left.toString()%>
			</div>
			<div data-options="region:'center',title:'<%=mem.Lab%>'"
				style="padding: 5px">
				<form method="POST" action="" class="am-form" id="form1">
				<input type="hidden" id="url" name="url" >
				<input type="hidden" id="FormHtml" name="FormHtml" value="">
				<%=mem.Pub2.toString()%>
				</form>
			</div>
		</div>
</body>
</html>