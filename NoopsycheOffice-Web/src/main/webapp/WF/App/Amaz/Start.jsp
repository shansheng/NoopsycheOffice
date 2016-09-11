<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<%
	JZFlowsModel model = new JZFlowsModel(basePath, request);
	model.init();
%>
<script type="text/javascript">
function StartListUrl(appPath, url, fk_flow, pageid) {
    var v = window.showModalDialog(url, 'sd', 'dialogHeight: 550px; dialogWidth: 650px; dialogTop: 100px; dialogLeft: 150px; center: yes; help: no');
    //alert(v);
    if (v == null || v == "")
        return;

    window.location.href = appPath + 'WF/MyFlow.jsp?FK_Flow=' + fk_flow + v;
}
function WinOpenIt(url) {
    var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
    newWindow.focus();
    return;
}

function WinOpen(url, winName) {
    var newWindow = window.open(url, winName, 'height=800,width=1030,top=' + (window.screen.availHeight - 800) / 2 + ',left=' + (window.screen.availWidth - 1030) / 2 + ',scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
    newWindow.focus();
    return;
}
</script>
</head>
<body>

	<!-- 内容 -->
	<div class="admin-content">
		<div class="am-cf am-padding">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">首页</strong> / <small>发起列表</small>
			</div>
		</div>
		<div class="am-g">
			<div class="am-u-sm-12">
				<form method="post" action="" class="am-form" id="form1">
					<input type="hidden"  id="FormHtml"  name="FormHtml"  value=""></input>
					<%=model.ui.ListToString() %>
				</form>
			</div>
		</div>
	</div>
</body>
</body>
</html>
