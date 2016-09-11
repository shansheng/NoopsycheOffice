<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="cn.jflow.common.model.DesignerModel"%>
<%

   

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	boolean checked=false;
	DesignerModel dm=new DesignerModel(request,response,basePath);
	dm.init();
	
	//执行升级.
	BP.WF.Glo.UpdataCCFlowVer();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>驰骋工作流引擎设计器 - JFlow </title>
    <style type="text/css">
    html, body {
	    height: 100%;
	    overflow: auto;
    }
    body {
	    padding: 0;
	    margin: 0;
    }
    #silverlightControlHost {
	    height: 100%;
	    text-align:center;
    }
    </style>
    <script type="text/javascript" src="Silverlight.js"></script>
    <script type="text/javascript">
	    function maximizeWindow() {
	        window.moveTo(0, 0)
	        window.resizeTo(screen.width, window.screen.availHeight)
	    }
	    function GetBrowserWidth() {
	        return window.screen.width;
	    }
	    function GetBrowserHeight() {
	        return window.screen.height; 
	    }
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
    </script>
</head>
<body onload="javascript:maximizeWindow()">
    <form id="form1" runat="server" style="height:100%">
    <div id="silverlightControlHost">
		<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
			<param name="source" value="<%=basePath %>/WF/Admin/ClientBin/CCFlowDesigner.xap"/>
			<param name="onerror" value="onSilverlightError" />
			<param name="background" value="white" />
         <%--   <param name="windowless" value="true" />--%>
         	<param name="AllowHtmlPopupWindow" value="true" />
			<param name="minRuntimeVersion" value="2.0.31005.0" />
			 
		    <param name="autoUpgrade" value="false" />
			
			<a href="<%=BP.WF.Glo.getSilverlightDownloadUrl() %>" style="text-decoration: none;"  >
     			<img src="" alt="Get Microsoft Silverlight" style="border-style: none"/>
			</a>
		</object>
		<iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
    </div>
    </form>
</body>
</html>
