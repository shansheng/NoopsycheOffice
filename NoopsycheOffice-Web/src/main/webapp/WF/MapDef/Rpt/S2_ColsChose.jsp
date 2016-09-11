<%@page import="cn.jflow.model.wf.rpt.S2ColsChoseModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	S2ColsChoseModel s = new S2ColsChoseModel(request, response);
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
	function OnEditsave()
	 {
		 var RptNo='<%=s.getRptNo()%>';
		 var FK_MapData="<%=s.getFK_MapData()%>";
		 var FK_Flow='<%=s.getFK_Flow()%>';
		 $("#FormHtml").val($("#form11").html());
		 $("#form11").attr("action","<%=basePath%>/mapdef/S2ColsChose_Btn_Save_Click.do?RptNo="+RptNo+"&FK_MapData="+FK_MapData+"&FK_Flow="+FK_Flow);
		 $("#form11").submit();
	 }
	 function Btn_SaveAndNext1()
	 {
		 var RptNo='<%=s.getRptNo()%>';
		 var FK_MapData="<%=s.getFK_MapData()%>";
		 var FK_Flow='<%=s.getFK_Flow()%>';
		 $("#FormHtml").val($("#form11").html());
		 $("#form11").attr("action","<%=basePath%>/mapdef/S2ColsChose_Btn_SaveAndNext1_Click.do?RptNo="
							+ RptNo + "&FK_MapData=" + FK_MapData + "&FK_Flow="
							+ FK_Flow);
			$("#form11").submit();
		}
	 
	 function do_post_back()
	 {
		 var RptNo='<%=s.getRptNo()%>';
		 var FK_MapData="<%=s.getFK_MapData()%>";
		 var FK_Flow='<%=s.getFK_Flow()%>';
		 $("#FormHtml").val($("#form11").html());
		 $("#form11").attr("action","<%=basePath%>/mapdef/do_post_back.do?RptNo="
							+ RptNo + "&FK_MapData=" + FK_MapData + "&FK_Flow="
							+ FK_Flow);
			$("#form11").submit();
		}
</script>
</head>
<body class="easyui-layout" onload="load()">
	<input type="hidden" value="${success }" id="success" />
	<form method="post" action="" id="form11">
	<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<%=s.Pub2.ListToString()%>
		<br /> <br /> <a id="Btn_Save1" class="easyui-linkbutton"
			data-options="iconCls:&#39;icon-save&#39;"
			href="javascript:OnEditsave()">保存</a> <a id="Btn_SaveAndNext1"
			class="easyui-linkbutton" data-options="iconCls:&#39;icon-save&#39;"
			href="javascript:Btn_SaveAndNext1()">保存并设置显示列次序</a> <a id="Btn_Cancel1"
			class="easyui-linkbutton" data-options="iconCls:&#39;icon-undo&#39;"
			href="javascript:do_post_back();">取消</a>
		<!-- <script type="text/javascript">
			//<![CDATA[
			var theForm = document.forms['form1'];
			if (!theForm) {
				theForm = document.form1;
			}
			function __doPostBack(eventTarget, eventArgument) {
				if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
					theForm.__EVENTTARGET.value = eventTarget;
					theForm.__EVENTARGUMENT.value = eventArgument;
					theForm.submit();
				}
			}
			//]]>
		</script> -->

	</form>
</body>
</html>
