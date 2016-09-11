<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<head>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	MessagesReplay mr = new MessagesReplay(request,response);
	mr.pageLoad(request,response);
	String receiver = request.getParameter("RE");
    String mypk = request.getParameter("MyPK");
%>

</head>
<body>
<link href="Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/easyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="Scripts/EasyUIUtility.js" type="text/javascript"></script>
    <script type="text/javascript">
        function openSelectEmp(hid, tid) {
            var url = '<%=basePath %>WF/Comm/Port/SelectUser_Jq.jsp';

            var selected = $('#' + hid).val();
            if (selected != null && selected.length > 0) {
                url += '?In=' + selected + '&tk=' + Math.random();
            }

            OpenEasyUiDialog(url, 'eudlgframe', '选择发起人', 760, 470, 'icon-user', true, function (ids) {
                var arr = ids.split(',');
                var hiddenId = arr[0];
                var tbId = arr[1];

                var innerWin = document.getElementById('eudlgframe').contentWindow;
                $('#' + tbId).val(innerWin.getReturnText());
                $('#' + hiddenId).val(innerWin.getReturnValue());
            }, hid + ',' + tid);
        }
        function onCancel(){
        	location.href='javascript:history.go(-1);'
    	}
        function onCheck(){
        	var rec = $("#rec").val();
        	var title = $("#title").val();
        	var con = $("#con").val();
        	if(rec.length ==0)
        	{
        		alert("接收人不能为空");
        		return false;
        	}
        	if(title.length ==0)
        	{
        		alert("标题不能为空");
        		return false;
        	}
        	if(con.length ==0)
        	{
        		alert("正文不能为空");
        		return false;
        	}
    	} 
    </script>
    <div>
	    <form method="post" onsubmit="return onCheck();"
			action="<%=basePath %>/WF/WorkOpt/btn_Save_Click.do?RE=<%=receiver %>&MyPK=<%=mypk %>" >
	    	<%=mr.pub1 %>
	    </form>
    </div>
</body>
</html>