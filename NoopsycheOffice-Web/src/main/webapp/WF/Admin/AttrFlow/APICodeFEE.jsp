<%@page import="cn.jflow.controller.wf.admin.AttrFlow.APICodeFEE"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file  = "/WF/head/head1.jsp" %>
<%
	APICodeFEE acf = new APICodeFEE(request,response);
	acf.Page_Load();

%>
<title><%=acf.getTitle() %>自定义事件代码生成</title>
    <link href="../../Scripts/SyntaxHighlighter/Styles/shCoreDefault.css" rel="stylesheet"
        type="text/css" />
    <script src="../../Scripts/SyntaxHighlighter/shCore.js" type="text/javascript"></script>
    <script src="../../Scripts/SyntaxHighlighter/shBrushCSharp.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" data-options="border:false">
    <form id="form1" runat="server">
        <div data-options="region:'center',border:false,title:'<%=acf.getTitle() %>自定义事件代码生成'," style="padding: 5px">        
            <%=acf.Pub1 %>
    </div>
    </form>
</body>
</html>
