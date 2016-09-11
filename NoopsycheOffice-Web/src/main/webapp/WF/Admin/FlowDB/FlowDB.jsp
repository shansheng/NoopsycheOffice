<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	String FK_Flow = request.getParameter("FK_Flow");
	if (StringHelper.isNullOrEmpty(FK_Flow)) {
		FK_Flow = "200";
	}
	int WorkID;
	String workid = request.getParameter("WorkID");
	if (StringHelper.isNullOrEmpty(workid)) {
		WorkID = 0;
	} else {
		WorkID = Integer.parseInt(workid);
	}
	
	String DoType = StringHelper.isEmpty(request.getParameter("DoType"),"");;
	
	String Search = request.getParameter("IsSearch");
	boolean IsSearch=true;
	if (Search==null||Search.equals("0")) {
		IsSearch = false;
	} else if (Search.equals("1")) {
		IsSearch = true;
	}
	String Depts = StringHelper.isEmpty(request.getParameter("Depts"), "");
	String Emps = StringHelper.isEmpty(request.getParameter("Emps"),"");
	String DeptsText = StringHelper.isEmpty(request.getParameter("DeptsText"),"");
	String EmpsText = StringHelper.isEmpty(request.getParameter("EmpsText"),"");
	String DateFrom = StringHelper.isEmpty(request.getParameter("DateFrom"),"");
	String DateTo = StringHelper.isEmpty(request.getParameter("DateTo"),"");
	String Keywords = StringHelper.isEmpty(request.getParameter("Keywords"),"");
	FlowDBModel fdb = new FlowDBModel(request, response,
			basePath, FK_Flow, Depts, Emps, DateFrom, DateTo, Keywords,
			WorkID, DeptsText, EmpsText, IsSearch, DoType);
	
	fdb.init();
%>
<script type="text/javascript">
	$(document).ready(function() {
		$("table.Table tr:gt(0)").hover(function() {
			$(this).addClass("tr_hover");
		}, function() {
			$(this).removeClass("tr_hover");
		});
	});

	//工作删除.
	function DelIt(fk_flow, workid) {
		var url = 'FlowDB.jsp?DoType=DelIt&FK_Flow=' + fk_flow + '&WorkID='
				+ workid;
		//WinShowModalDialog(url, '');
		var v = window.showModalDialog(url, 'del', 'scrollbars=yes;resizable=yes;center=yes;minimize:yes;maximize:yes;dialogHeight: 200px; dialogWidth: 300px; dialogTop: 100px; dialogLeft: 150px;');
		window.location.href = window.location.href;
	}

	//流程移交.
	function FlowShift(fk_flow, workid) {

		var url = 'FlowShift.jsp?FK_Flow=' + fk_flow + '&WorkID=' + workid;
		var b = window
				.showModalDialog(
						url,
						'ass',
						'dialogHeight: 400px; dialogWidth: 600px; dialogTop: 100px; dialogLeft: 110px; center: yes; help: no');
		if (b != null)
			window.location.href = window.location.href;
	}

	//跳转.
	function FlowSkip(fk_flow, workid) {
		var url = 'FlowSkip.jsp?FK_Flow=' + fk_flow + '&WorkID=' + workid;
		var v = window
				.showModalDialog(
						url,
						'sd',
						'dialogHeight: 550px; dialogWidth: 650px; dialogTop: 100px; dialogLeft: 150px; center: yes; help: no');
		if (v != null)
			window.location.href = window.location.href;
	}

	function openSelectEmp(hid, tid) {
		var url = '<%=basePath%>WF/Comm/Port/SelectUser_Jq.jsp';
		var selected = $('#' + hid).val();
		if (selected != null && selected.length > 0) {
			url += '?In=' + selected + '&tk=' + Math.random();
		}
		OpenEasyUiDialog(
				url,
				'eudlgframe',
				'选择发起人',
				520,
				360,
				'icon-user',
				true,
				function(ids) {
					var arr = ids.split(',');
					var hiddenId = arr[0];
					var tbId = arr[1];

					var innerWin = document.getElementById('eudlgframe').contentWindow;
					$('#' + tbId).val(innerWin.getReturnText());
					$('#' + hiddenId).val(innerWin.getReturnValue());
				}, hid + ',' + tid);
	}

	function openSelectDept(hid, tid) {
		var url = '<%=basePath%>WF/Comm/Port/SelectDepts_Jq.jsp';
		var selected = $('#' + hid).val();
		if (selected != null && selected.length > 0) {
			url += '?In=' + selected + '&tk=' + Math.random();
		}

		OpenEasyUiDialog(
				url,
				'eudlgframe',
				'选择部门',
				520,
				360,
				'icon-department',
				true,
				function(ids) {
					var arr = ids.split(',');
					var hiddenId = arr[0];
					var tbId = arr[1];

					var innerWin = document.getElementById('eudlgframe').contentWindow;
					$('#' + tbId).val(innerWin.getReturnText());
					$('#' + hiddenId).val(innerWin.getReturnValue());
				}, hid + ',' + tid);
	}
</script>
<script type="text/javascript">
			function doPostBack() {
				var depts = $("#Hid_Dept").val();
	            var emps = $("#Hid_FQR").val();
	            var deptsText = $("#TB_Dept").val();
	            var empsText = $("#TB_FQR").val();
	            var dateFrom = $("#TB_DateFrom").val();
	            var dateTo = $("#TB_DateTo").val();
	            var keywords =$("#TB_KeyWords").val();

	            var url = "FlowDB.jsp?FK_Flow=<%=FK_Flow%>&WorkID=<%=WorkID%>&IsSearch=1&Depts="
				+ depts
				+ "&DeptsText="
				+ deptsText
				+ "&Emps="
				+ emps
				+ "&EmpsText="
				+ empsText
				+ "&DateFrom="
				+ dateFrom
				+ "&DateTo=" + dateTo + "&Keywords=" + keywords;
		$("#form1").attr("action", url);
		$("#form1").submit();
	}
	//]]>
</script>
</head>
<body topmargin="0" leftmargin="0" style="font-size: smaller">
	<form method="post"	action="" id="form1">
		<div>
			<%=fdb.Pub3.toString() %>
			<%=fdb.Pub1.toString() %>
			<%=fdb.Pub2.toString() %>
		</div>
	</form>
</body>
</html>