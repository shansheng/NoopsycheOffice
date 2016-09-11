<%@page import="cn.jflow.model.wf.rpt.S5SearchCondModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	S5SearchCondModel s = new S5SearchCondModel(request, response);
	s.Page_Load();
%>
<script type="text/javascript">
 function load() {
		var success = document.getElementById("success").value;
		if (success == "" || success == null) {
			return;
		} else {
			alert(success);
		}

	}
 function Editsave()
 {
	 var RptNo='<%=s.getRptNo()%>';
	 var FK_MapData="<%=s.getFK_MapData()%>";
	 var FK_Flow='<%=s.getFK_Flow()%>';
	 var DDL_DTSearchWay=$("#DDL_DTSearchWay").get(0).selectedIndex;
	 var DDL_DTSearchKey=$("#DDL_DTSearchKey").get(0).selectedIndex;
	 $("#form1").attr("action","<%=basePath%>mapdef/S5SearchCond_Btn_Save_Click.do?RptNo="+RptNo+"&FK_MapData="+FK_MapData+"&FK_Flow="+FK_Flow+"&DDL_DTSearchWay="+DDL_DTSearchWay+"&DDL_DTSearchKey="+DDL_DTSearchKey);
	 $("#form1").submit();
 }
 function Btn_SaveAndNext1()
 {
	 var DDL_DTSearchWay=$("#DDL_DTSearchWay").val();
	 var DDL_DTSearchKey=$("#DDL_DTSearchKey").val();
	 if(DDL_DTSearchWay==null || DDL_DTSearchWay=="")
	 {
	 	DDL_DTSearchWay=0;
	 }else
		 {
		 DDL_DTSearchWay=$("#DDL_DTSearchWay").get(0).selectedIndex;
		 }
	 if(DDL_DTSearchKey==null || DDL_DTSearchWay=="")
	 {
		 DDL_DTSearchKey=0;
	 }
	 else
		 {
		 DDL_DTSearchKey=$("#DDL_DTSearchKey").get(0).selectedIndex;
		 }
	 var RptNo='<%=s.getRptNo()%>';
	 var FK_MapData="<%=s.getFK_MapData()%>";
	 var FK_Flow='<%=s.getFK_Flow()%>';
	 $("#form1").attr("action","<%=basePath%>mapdef/S5SearchCond_Btn_SaveAndNext1_Click.do?RptNo="+ RptNo + "&FK_MapData=" + FK_MapData + "&FK_Flow="+ FK_Flow + "&DDL_DTSearchWay=" + DDL_DTSearchWay+ "&DDL_DTSearchKey=" + DDL_DTSearchKey);
		$("#form1").submit();
	}
</script>
</head>
<body class="easyui-layout" onload="load()">
	<input type="hidden" value="${success }" id="success" />
	<form method="post" action="" id="form1">
		<%=s.Pub2.ListToString()%>
		<a id="Btn_Save1" class="easyui-linkbutton"
			data-options="iconCls:&#39;icon-save&#39;"
			href="javascript:Editsave()">保存</a> <a id="Btn_SaveAndNext1"
			class="easyui-linkbutton" data-options="iconCls:&#39;icon-save&#39;"
			href="javascript:Btn_SaveAndNext1()">保存并继续</a> <a id="Btn_Cancel1"
			class="easyui-linkbutton" data-options="iconCls:&#39;icon-undo&#39;"
			href="javascript:window.close();">取消</a>
	</form>
</body>
</html>

