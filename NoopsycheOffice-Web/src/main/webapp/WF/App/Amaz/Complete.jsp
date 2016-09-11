<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
</head>
<body>
	<!-- 内容 -->
	<!-- 表格数据 -->
	<div class="admin-content">

		<div class="am-cf am-padding">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">首页</strong> / <small>完成列表</small>
			</div>
		</div>

		<!-- 数据 -->
		<div class="am-g">
			<div class="am-u-sm-12" id="listbox">
				<jsp:include page="CompleteInfo.jsp" />	
			</div>
		</div>

	</div>
</body>
<script type="text/javascript">
function WinOpen(url) {
    var newWindow = window.open(url, 'z', 'height=500,width=600,top=100,left=200,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
    newWindow.focus();
    return;
}
	function WinOpenCC(ccid, fk_flow, fk_node, workid, fid, sta) {
        var url = '';
        if (sta == '0') {
            url = '<%=basePath%>WF/Do.jsp?DoType=DoOpenCC&FK_Flow=' + fk_flow + '&FK_Node=' + fk_node + '&WorkID=' + workid + '&FID=' + fid + '&Sta=' + sta + '&MyPK=' + ccid + "&T=" + dateNow;
        }
        else {
            url = '<%=basePath%>WF/WorkOpt/OneWork/Track.jsp?FK_Flow='
					+ fk_flow + '&FK_Node=' + fk_node + '&WorkID=' + workid
					+ '&FID=' + fid + '&Sta=' + sta + '&MyPK=' + ccid + "&T="
					+ dateNow;
		}
		//window.parent.f_addTab("cc" + fk_flow + workid, "抄送" + fk_flow + workid, url);
		var newWindow = window.open(url, 'z');
		newWindow.focus();
	}
	/* function reLoad(){
		window.location.reload(true);
		window.parent.frames["left"].location.reload(true);  
	}
	setInterval("reLoad()",3000); */
function reLoad(){
	$.ajax({
		url : "Complete.do",
		type : 'post',
		dataType : 'html',
		async : false,
		success : function(data) {
			$("#listbox").html(data);
		}
	});
}
</script>
</html>