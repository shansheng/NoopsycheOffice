<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<link href="<%=basePath%>WF/Comm/Style/CommStyle.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>WF/Comm/Style/Table0.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>WF/Scripts/easyUI/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<link href="<%=basePath%>WF/Scripts/easyUI/themes/icon.css" rel="stylesheet"
	type="text/css" />
<script src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"
	type="text/javascript"></script>
<script src="<%=basePath%>WF/Scripts/easyUI/jquery.easyui.min.js"
	type="text/javascript"></script>
<head>
    <title>流程图</title>
    <style type="text/css">
        html, body
        {
            height: 100%;
        }
        body
        {
            padding: 0;
            margin: 0;
        }
    </style>
    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            }
 
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;
 
            if (errorType == "ImageError" || errorType == "MediaError") {
                return;
            }
            var errMsg = "Silverlight 应用程序中未处理的错误 " + appSource + "\n";
 
            errMsg += "代码: " + iErrorCode + "    \n";
            errMsg += "类别: " + errorType + "       \n";
            errMsg += "消息: " + args.ErrorMessage + "     \n";
 
            if (errorType == "ParserError") {
                errMsg += "文件: " + args.xamlFile + "     \n";
                errMsg += "行: " + args.lineNumber + "     \n";
                errMsg += "位置: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {
                if (args.lineNumber != 0) {
                    errMsg += "行: " + args.lineNumber + "     \n";
                    errMsg += "位置: " + args.charPosition + "     \n";
                }
                errMsg += "方法名称: " + args.methodName + "     \n";
            }
            alert(errMsg);
        }
 
        function appLoad() {
            var xamlObject = document.getElementById("silverlightControl");
            if (xamlObject != null)
            { }
        }
    </script>
</head>
<body>
    <div id="silverlightControlHost" style="height: 100%; width: 100%; text-align: center;">
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"
            width="100%" height="450">
            <param name="source" value="<%=basePath %>WF/Admin/sClientBin/CCFlowDesigner.xap" />
            <param name="onLoad" value="appLoad" />
            <param name="onerror" value="onSilverlightError" />
            <param name="background" value="white" />
            <param name="minRuntimeVersion" value="2.0.31005.0" />
            <param name="initParams" value="platForm=JAVA,appName=">
            <param name="windowless" value="true" />
            <param name="autoUpgrade" value="true" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
                <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight"
                    style="border-style: none" />
            </a>
        </object>
    </div>
</body>
</html>

