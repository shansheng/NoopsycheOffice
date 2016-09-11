<%@page import="cn.jflow.model.wf.rpt.S3ColsLabelModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</head>
<%@ include file="/WF/head/head1.jsp"%>
<%
	S3ColsLabelModel s=new S3ColsLabelModel(request,response);
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
	 $(document).ready(function () {
         $("table tr:gt(0)").hover(
             function () { $(this).addClass("tr_hover"); },
             function () { $(this).removeClass("tr_hover"); });
     });

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
     function Editsave()
     {
    	 var RptNo='<%=s.getRptNo()%>';
    	 var FK_MapData="<%=s.getFK_MapData()%>";
    	 var FK_Flow='<%=s.getFK_Flow()%>';
    	 $("#form1").attr("action","<%=basePath%>mapdef/S3ColsLabel_Btn_Save_Click.do?RptNo="+RptNo+"&FK_MapData="+FK_MapData+"&FK_Flow="+FK_Flow);
    	 $("#form1").submit();
     }
     function Btn_SaveAndNext1()
     {
    	 var RptNo='<%=s.getRptNo()%>';
    	 var FK_MapData="<%=s.getFK_MapData()%>";
    	 var FK_Flow='<%=s.getFK_Flow()%>';
    	 $("#form1").attr("action","<%=basePath%>mapdef/S3ColsLabel_Btn_SaveAndNext1_Click.do?RptNo="+RptNo+"&FK_MapData="+FK_MapData+"&FK_Flow="+FK_Flow);
    	 $("#form1").submit();
     }
</script>
<body class="easyui-layout" onload="load()">
<input type="hidden" value="${success }" id="success" />
<form method="post" action="" id="form1">
	<%= s.Pub2.ListToString() %>
	<br/><br/>
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

