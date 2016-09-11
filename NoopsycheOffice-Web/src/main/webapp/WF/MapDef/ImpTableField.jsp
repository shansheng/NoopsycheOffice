<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.jflow.model.wf.mapdef.ImpTableFieldModel"%>
    
    <%
    String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
    ImpTableFieldModel tableField = new ImpTableFieldModel(request, response,basePath);
    tableField.loadPage();
    %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
	<base target=_self  />
 	<link href="../Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../Comm/Style/CommStyle.css" rel="stylesheet" type="text/css" />
    <link href="../Scripts/easyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/easyUI/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script src="../Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script language="JavaScript" src="../Comm/JS/Calendar/WdatePicker.js" type="text/javascript"  defer="defer"></script>
    <script language="JavaScript" src="../Comm/JScript.js" type="text/javascript"></script> 
    <link href="../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
    <link href="../Comm/Style/Tabs.css" rel="stylesheet" type="text/css" />
    
    <style type="text/css">
        body
        {
            margin: 0 auto;
            /*color: #000;
            line-height: 20px;
            font-family: 宋体;
            text-align: center;
            width: 90%;*/
        }
    </style>
    
    <script type="text/javascript">
        function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
    </script>
    <script type="text/javascript">
        function OpenSelectBindKey(ctl) {
            var url = 'ImpTableFieldSelectBindKey.aspx';
            var str = window.showModalDialog(url, '', 'dialogHeight: 550px; dialogWidth:950px; dialogTop: 100px; dialogLeft: 100px; center: no; help: no');
            if (str == undefined)
                return;
            if (str == null)
                return;
            ctl.value = str;
            return;
        }

        function CheckAll(checked) {
            $.each($(":checkbox"), function () {
                this.checked = checked;
            });
        }

        function editLT(link) {
            var colname = link.substring('A_LogicType_'.length);
            var colLT = $('#LBL_LogicType_' + colname).text();
            //alert(colLT);

            $('#typeWin').dialog({ title: '更改 ' + colname + ' 逻辑类型' });
            $('.navlist').empty();
            $('ul.navlist').append("<li><div>" + (colLT == '普通' ? "<a><span class='nav'>*普通*</span></a>" : ("<a href='javascript:void(0)' onclick=\"setLT('" + colname + "',$(this).text())\"><span class='nav'>普通</span></a>")) + "</div></li>");
            $('ul.navlist').append("<li><div>" + (colLT == '枚举' ? "<a><span class='nav'>*枚举*</span></a>" : ("<a href='javascript:void(0)' onclick=\"setLT('" + colname + "',$(this).text())\"><span class='nav'>枚举</span></a>")) + "</div></li>");
            $('ul.navlist').append("<li><div>" + (colLT == '外键' ? "<a><span class='nav'>*外键*</span></a>" : ("<a href='javascript:void(0)' onclick=\"setLT('" + colname + "',$(this).text())\"><span class='nav'>外键</span></a>")) + "</div></li>");
            $('#typeWin').dialog('open');
        }

        function setLT(colname, colLT) {
            $('#LBL_LogicType_' + colname).text(colLT);
            $('#typeWin').dialog('close');
        }

        //上移
        function up(obj, idxTBColumnIdx) {
            var objParentTR = $(obj).parent().parent();
            var prevTR = objParentTR.prev();
            var currTrId;
            var prevTrId;
            if (prevTR.length > 0 && !isNaN(prevTR.children(":eq(0)").text())) {
                prevTR.insertAfter(objParentTR);
                currTrId = Number(objParentTR.children(":eq(0)").text());
                prevTrId = Number(prevTR.children(":eq(0)").text());
                objParentTR.children(":eq(0)").text(prevTrId);
                prevTR.children(":eq(0)").text(currTrId);
                objParentTR.children(":eq(" + idxTBColumnIdx + ")").children(":first").val(prevTrId);
                prevTR.children(":eq(" + idxTBColumnIdx + ")").children(":first").val(currTrId);
            } else {
                return;
            }
        }
        //下移
        function down(obj, idxTBColumnIdx) {
            var objParentTR = $(obj).parent().parent();
            var nextTR = objParentTR.next();
            var currTrId;
            var nextTrId;
            if (nextTR.length > 0 && !isNaN(nextTR.children(":eq(0)").text())) {
                nextTR.insertBefore(objParentTR);
                currTrId = Number(objParentTR.children(":eq(0)").text());
                nextTrId = Number(nextTR.children(":eq(0)").text());
                objParentTR.children(":eq(0)").text(nextTrId);
                nextTR.children(":eq(0)").text(currTrId);
                objParentTR.children(":eq(" + idxTBColumnIdx + ")").children(":first").val(nextTrId);
                nextTR.children(":eq(" + idxTBColumnIdx + ")").children(":first").val(currTrId);
            } else {
                return;
            }
        }

        $(document).ready(function () {
            $("#maintable tr:gt(0)").hover(
                function () { $(this).addClass("tr_hover"); },
                function () { $(this).removeClass("tr_hover"); });
        });
        
        function btn_Save_Click(){
        	var value = document.getElementById("ucen").innerHTML;
       		$('#FormHtml').val(value);
       		$("#form1").attr("action","<%=tableField.getBasePath()%>WF/MapDef/ImpTableFieldSave.do");
     		$("#form1").submit();
        }
        
        function btn_Next_Click(){
        var value = document.getElementById("ucen").innerHTML;
       		$('#FormHtml').val(value);
       		$("#form1").attr("action","<%=tableField.getBasePath()%>WF/MapDef/ImpTableFieldNext.do?STable=<%=tableField.getSTable()%>&FK_SFDBSrc=<%=tableField.getFK_SFDBSrc()%>");
     		$("#form1").submit();
        
        }
    </script>
</head>

<body >   
 	<form id="form1" method="post">
        <input type="hidden" id="FormHtml" name="FormHtml" value=""/>
	    <input type="hidden" name="FK_MapData" value="<%=tableField.getFK_MapData() %>"/>
        <div  id="ucen" style="height:100%">
 			<%=tableField.getPub1()%>
 		</div>
 	</form>
</body>
</html>