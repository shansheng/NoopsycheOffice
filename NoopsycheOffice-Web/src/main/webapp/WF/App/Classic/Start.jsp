<%@page import="cn.jflow.common.model.JZFlowsModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BP.WF.FlowAppType"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.WF.Flows"%>
<%@page import="BP.WF.Flow"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Template.FlowSorts"%>
<%@page import="BP.WF.Template.FlowSort"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发起</title>
  <link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript">
        function StartListUrl(appPath, url, fk_flow, pageid) {
            var v = window.showModalDialog(url, 'sd', 'dialogHeight: 550px; dialogWidth: 650px; dialogTop: 100px; dialogLeft: 150px; center: yes; help: no');
            //alert(v);
            if (v == null || v == "")
                return;

            window.location.href = appPath + '../MyFlow.jsp?FK_Flow=' + fk_flow + v;
        }
        function WinOpen(url, winName) {
            var newWindow = window.open(url, winName, 'height=650,width=1030,top=' + (window.screen.availHeight - 800) / 2 + ',left=' + (window.screen.availWidth - 1030) / 2 + ',scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
            newWindow.focus();
            return;
        }
        function winOpen(url, winName) {
            var newWindow = window.open(url, winName, 'height=650,width=1030,top=' + (window.screen.availHeight - 800) / 2 + ',left=' + (window.screen.availWidth - 1030) / 2 + ',scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
            newWindow.focus();
            return;
        }
        function WinOpenIt(url) {
            var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
            newWindow.focus();
            return;
        }
    </script>
	<style type="text/css">
		a{color:#0066CC;text-decoration:none;}
        a:hover{color:#0084C5;text-decoration:underline;}
		table {margin: 0px;padding: 0px;width: 100%;}
		table tr:nth-child(odd)>td,table tr:nth-child(odd)>th {background-color: #EEF3FF;}
		table td{font-family:Microsoft YaHei;padding:10px;}
		table th{font-family:Microsoft YaHei;padding:5px 10px;}
		ul {margin-left: -10px;margin-top: 2px;font: 12px 宋体, Arial, Verdana;}
		ul li {list-style-image: url(Port/Img/li_q_4.gif);line-height: 20px;height: 20px;margin-top: 3px;}
		span {font-size: 16px;font-family: Vijaya;margin-right: 5px;}
		.noHaveIt {color: Red;} .haveIt {color: Blue;}
		caption {background: url(Port/Img/TitleBG.png);}
		.CaptionMsg {background: url(Port/Img/TitleMsg.png);}
	</style>
</head>
<body>
<%
	String basePath = Glo.getCCFlowAppPath();
	JZFlowsModel model = new JZFlowsModel(basePath, request);
	model.init();
%>
<%=model.ui.ListToString() %>
</body>
</html>