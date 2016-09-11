<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	Integer FK_Node = Integer.valueOf(request.getParameter("FK_Node"));
    String DoType = request.getParameter("DoType");
    String RefOID = request.getParameter("RefOID");
    ListenModel listen=new ListenModel(request, response);
    String pub=listen.init();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息收听</title>
<script type="text/javascript">
    function btn_Click(btnName){
    	var url = "<%=basePath %>WF/Admin/btn_Click.do?btnName="+btnName+"&FK_Node=<%=FK_Node%>&RefOID=<%=RefOID%>";
    	$("#form1").attr("action",url);
    	$("#form1").submit();
    }
function btn_Del_Click(){
	if(confirm('您确认删除吗？')){
		var url = "<%=basePath %>WF/Admin/btn_Del_Click.do?RefOID=<%=RefOID%>&FK_Node=<%=FK_Node%>";
		$("#form1").attr("action",url);
		$("#form1").submit();
	}else{
	 Window.close();
	}
    }
    </script>
</head>
<body class="easyui-layout">
	<form id="form1" method="post"
		action="Listen.jsp?FK_Node=<%=FK_Node %>&amp;DoType=<%=DoType%>&RefOID=<%=RefOID%>">
		<div data-options="region:'center',title:'消息收听',border:false"
			style="padding: 5px">
			<input type="hidden"  id="pData"  name="pData"  value=""></input>
			<%=pub %>
		</div>
	</form>
</body>
</html>