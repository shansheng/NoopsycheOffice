<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="BP.Port.*"%>
<%@page import="cn.jflow.common.model.TaskPoolSharingModel"%>
<%@page import="BP.WF.*"%>
<%@page import="BP.DA.*"%>
<%@page import="cn.jflow.common.model.TaskPoolApplyModel"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	TaskPoolApplyModel tpsm = new TaskPoolApplyModel(request, response);
	String htmlStr = tpsm.init();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>驰骋工作流程管理系统</title>
<!-- <link rel="stylesheet" href="assets/css/amazeui.min.css" /> -->
<link rel="stylesheet" href="assets/css/admin.css">
<script src="assets/js/jquery.min.js"></script>
<!-- <script src="assets/js/amazeui.min.js"></script> -->
<script src="assets/js/app.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Comm/JScript.js"></script>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
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
        var i = 0
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
    function WinOpenIt(url) {
        var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
        newWindow.focus();
        return;
    }
    function PutOne(workid) {
        var doUrl = '<%=basePath%>WF/Do.jsp?ActionType=PutOne&WorkID='
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
		window.location.href = window.location.href;
	}
</script>
<style>
* {
	margin: 0px;
	padding: 0px;
}


.input_text {
	border: 1px solid #CED5DB;
	height: 20px;
	width: 100px;
}

.input_button {
	background: #FED778;
	border: 1px solid #DEA203;
	color: #853433
}

table {
	border-collapse: collapse;
}

.table_list {
	margin-top: 30px;
}

.table_list tr td {
	border: 1px solid #CED5DB;
	text-align: center;
	line-height: 28px;
}

.td_red {
	color: #F00;
	font-weight: bold
}

.table_list tr:hover {
	background: #F1F1F1
}

.TTD {
	word-wrap: break-word;
	　　 word-break: normal;
}

.Icon {
	width: 16px;
	height: 16px;
	border: 0px;
}
</style>
</head>
<body>
	<!-- 内容 -->
	<!-- 表格数据 -->
	<table border=1px align=center width='100%'>
		<Caption ><div class='' >发起列表</div></Caption>

		<!-- 数据 -->

		<div class="am-g">
			<div class="am-u-sm-12">
				<%=htmlStr%>
			</div>
		</div>

	</table>
</body>
</html>