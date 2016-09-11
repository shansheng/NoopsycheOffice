<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
</head>
<body>
	<div class="admin-content" id="listbox">
		<jsp:include page="HomeInfo.jsp" />
	</div>
</body>
<script type="text/javascript">
function reLoad(){
	$.ajax({
		url : "Index.do",
		type : 'post',
		dataType : 'html',
		async : false,
		success : function(data) {
			$("#listbox").html(data);
		}
	});
}
setInterval("reLoad()",3000);
</script>
</html>