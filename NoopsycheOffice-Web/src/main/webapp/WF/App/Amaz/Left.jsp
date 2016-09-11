<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
</head>
<body>
<div class="" id="admin-offcanvas">
	<div class="admin-offcanvas-bar" id="listbox">
		<jsp:include page="LeftInfo.jsp" />	
	</div>
</div>
</body>
<script type="text/javascript">
function reLoad(){
	$.ajax({
		url : "Left.do",
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