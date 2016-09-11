<%@page import="cn.jflow.model.wf.mapdef.CopyDtlFieldModel"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	CopyDtlFieldModel cdfm=new CopyDtlFieldModel(request,response);
	cdfm.page_Load();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
    <link href="<%=basePath%>WF/Comm/Style/Table0.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=basePath%>WF//Comm/JScript.js" ></script>
	<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"></script>
	
	<script type="text/javascript">
		function btn_Click(){
		  $.ajax({
				  url : "<%=basePath %>WF/MapDef/copyBtn_Click.do",
				  type : 'post',
				  dataType : 'html',
				  data: $('#form1').serialize(),
				  async : false,
				  success : function(data) {
					 var s=data;
					 alert(s);
					 window.close();
				  }
				 }); 
		}
		
		
	</script>
</head>
<body>
	<form  id="form1"  method="post">
	<input type="hidden" id="mypk" name="mypk" value='<%=cdfm.getMyPK() %>'/>
	<input type="hidden" id="dtl" name="dtl" value='<%=cdfm.getDtl() %>'/>
		<div name="pub1" id="pub1">
			<%=cdfm.getPub() %>
		</div>
	</form>
</body>
</html>