<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<%
	String PageSmall = null;
	String PageID = Glo.getCurrPageID();
	if (PageID.toLowerCase().contains("smallsingle")) {
		PageSmall = "SmallSingle";
	} else if (PageID.toLowerCase().contains("small")) {
		PageSmall = "Small";
	} else {
		PageSmall = "";
	}

	String FK_Flow = request.getParameter("FK_Flow") == null?"":request.getParameter("FK_Flow");
	String GroupBy = request.getParameter("GroupBy") == null?"FlowName":request.getParameter("GroupBy");
%>
<script type="text/javascript">
function WinOpen(url) {
    var newWindow = window.open(url, 'z', 'height=500,width=600,top=250,left=400,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
    newWindow.focus();
    return;
}
	function Do(warning, url) {
		if (confirm(warning)) {
			window.location.href = url;
		}
	}
	// 撤销。
	function UnSend(appPath, pageID, fid, workid, fk_flow) {
		if (confirm('您确定要撤销本次发送吗？')) {
			var url = appPath + 'WF/Do.jsp?DoType=UnSend&FID=' + fid
					+ '&WorkID=' + workid + '&FK_Flow=' + fk_flow + '&PageID='
					+ pageID;
			var v = window.open(url, 'sd', 'height=370,width=700,top=160,left=400,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
		}
	}
	// 催办
	function Press(appPath, fid, workid, fk_flow) {
		var url = appPath + 'WF/WorkOpt/Press.jsp?FID=' + fid + '&WorkID='
				+ workid + '&FK_Flow=' + fk_flow;
		var v = window.open(url, 'sd', 'height=300,width=600,top=200,left=400,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
	}
	function GroupBarClick(appPath, rowIdx) {
		var alt = document.getElementById('Img' + rowIdx).alert;
		var sta = 'block';
		if (alt == 'Max') {
			sta = 'block';
			alt = 'Min';
		} else {
			sta = 'none';
			alt = 'Max';
		}

		document.getElementById('Img' + rowIdx).src = appPath + 'WF/Img/' + alt
				+ '.gif';
		document.getElementById('Img' + rowIdx).alert = alt;
		var i = 0;
		for (i = 0; i <= 5000; i++) {
			if (document.getElementById(rowIdx + '_' + i) == null)
				continue;
			if (sta == 'block') {
				document.getElementById(rowIdx + '_' + i).style.display = '';
			} else {
				document.getElementById(rowIdx + '_' + i).style.display = sta;
			}
		}
	}
</script>
</head>
<body>
	<!-- 内容 -->
	<div class="admin-content">
		<div class="am-cf am-padding">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">首页</strong> / <small>在途列表</small>
			</div>
		</div>
		<div class="am-g">
			<div class="am-u-sm-12" id="listbox">
				<jsp:include page="RuningInfo.jsp">
					<jsp:param value="<%=FK_Flow %>" name="FK_Flow"/>
					<jsp:param value="<%=GroupBy %>" name="GroupBy"/>
					<jsp:param value="<%=PageID %>" name="PageID"/>
					<jsp:param value="<%=PageSmall %>" name="PageSmall"/>
				</jsp:include>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	/* function reLoad(){
		window.location.reload(true);
		window.parent.frames["left"].location.reload(true);  
	}
	setInterval("reLoad()",3000); */
function reLoad(){
	var PageID = '<%=PageID%>';
	var PageSmall = '<%=PageSmall%>';
	
	var FK_Flow = '<%=FK_Flow%>';
	var GroupBy = '<%=GroupBy%>';
	$.ajax({
		url : "Runing.do",
		type : 'post',
		dataType : 'html',
		data : {
			PageID : PageID,
			PageSmall : PageSmall,
			FK_Flow : FK_Flow,
			GroupBy : GroupBy
		},
		async : false,
		success : function(data) {
			$("#listbox").html(data);
		}
	});
}
setInterval("reLoad()",3000);
</script>
</html>
