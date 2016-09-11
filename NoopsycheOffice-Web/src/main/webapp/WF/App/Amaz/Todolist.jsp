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
				<strong class="am-text-primary am-text-lg">首页</strong> / <small>待办列表</small>
			</div>
		</div>
		<!-- 数据 -->
		<div class="am-g">
			<div class="am-u-sm-12" id="listbox">
				<jsp:include page="TodolistInfo.jsp" />
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
	function reLoad() {
		$.ajax({
			url : "TodoList.do",
			type : 'post',
			dataType : 'html',
			async : false,
			success : function(data) {
				$("#listbox").html(data);
			}
		});
	}
	setInterval("reLoad()", 3000);
    function WinOpen(url) {
        var newWindow = window.open(url, 'z', 'height=500,width=600,top=100,left=200,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
        newWindow.focus();
        return;
    }
</script>
</html>