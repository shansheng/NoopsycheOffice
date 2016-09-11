<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<%
	TaskPoolSharingModel tpsm = new TaskPoolSharingModel(request,
	response);
	String htmlStr = tpsm.init();
%>
<script type="text/javascript">
$(function () {
    var userStyle = "ccflow默认";
    $('#winOpencss').attr('href', 'Style/FormThemes/WFWinOpen.css');
    $('#freeFormcss').attr('href', 'Style/FormThemes/Table0.css');

});
var NS4 = (document.layers);
var IE4 = (document.all);
var win = window;
var n = 0;
function findInPage(str) {
    alert(document.getElementById('string1'));
    str = document.getElementById('string1').value;
    //    alert(str);
    var txt, i, found;
    if (str == "")
        return false;
    if (NS4) {
        if (!win.find(str))
            while (win.find(str, false, true))
                n++;
        else
            n++;
        if (n == 0)
            alert("对不起！没有你要找的内容。");
    }
    if (IE4) {
        txt = win.document.body.createTextRange();
        for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) {
            txt.moveStart("character", 1);
            txt.moveEnd("textedit");
        }
        if (found) {
            txt.moveStart("character", -1);
            txt.findText(str);
            txt.select();
            txt.scrollIntoView();
            n++;
        }
        else {
            if (n > 0) {
                n = 0;
                findInPage(str);
            }
            else
                alert("对不起！没有你要找的内容。");
        }
    }
    return false;
}

function SetImg(appPath, id) {
    document.getElementById(id).src = appPath + 'WF/Img/Mail_Read.png';
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
    document.getElementById('Img' + rowIdx).src = appPath + 'WF/Img/' + alt + '.gif';
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
function WinOpenIt(url, workid) {
    if (window.confirm('您确定要申请下来该任务吗？') == false) {
        return;
    }
    var doUrl = '<%=basePath%>WF/Do.jsp?ActionType=DoAppTask&WorkID='
				+ workid;
		var str = window
				.showModalDialog(
						doUrl,
						'',
						'dialogHeight: 50px; dialogWidth:50px; dialogTop: 100px; dialogLeft: 100px; center: no; help: no');
		if (str == undefined)
			return;
		if (str == null)
			return;
		var newWindow = window
				.open(
						url,
						'_blank',
						'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
		newWindow.focus();
		window.location.href = window.location.href;
		return;
	}
</script>
</head>
<body>

	<!-- 内容 -->
	<!-- 表格数据 -->
	<table border=1px align=center width='100%'>
		<Caption ><div class='CaptionMsg' >共享任务</div></Caption>
		<!-- 数据 -->

		<div class="am-g">
			<div class="am-u-sm-12">
				<%=htmlStr %>
				<!-- <ul class="am-pagination am-pagination-right">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul> -->
			</div>
		</div>

	</table>
</body>
</html>