<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>JFlow</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%-- <link title="default" rel="stylesheet" type="text/css" href="<%=basePath%>App/Style/login.css" /> --%>
<link title="default" rel="stylesheet" type="text/css" href="<%=basePath%>WF/Style/jquery.alert.css" />

<link  rel="stylesheet" type="text/css" href="<%=basePath%>WF/Style/visgreatyStyle.css" />
<link  rel="stylesheet" type="text/css" href="<%=basePath%>WF/Style/global.css" />

<script type="text/javascript" src="<%=basePath%>WF/Scripts/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/jquery.alert.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/jq.fun.js"></script>
<script type="text/javascript">
	window.onresize=function(){ location=location };
</script>
<script type="text/javascript">
$(function() {

	$.ajax({
		url:'<%=basePath%>WF/validateDB.do',
		type:'post', //数据发送方式
		dataType:'json', //接受数据格式
		async: false ,
		error: function(data){},
		success: function(data){
			json = eval(data);
			if(json.success){				
			}else{			
				
				window.location.href = "<%=basePath%>/WF/Admin/DBInstall.jsp?msg="+json.msg;	
			}
		}
	});
	
 });
</script>

<link rel="shortcut icon" href="<%=basePath%>WF/Img/ccbpm.ico" ></link>
<!-- <style type="text/css">
	.tab
	{
		margin-left: 180px;	
		width:90%;
	}
</style> -->
</head>
<body>
<!-- 
	<div class="head"></div>
	<div class="main">
		<div class="login">
			<form method="post" action="" id="form1">
				<table class="tab">
					<tr>
						<td>账户名</td>
						<td><input type="text" name="loginName" id="name" class="login_input" /></td>
						<td>密&nbsp;&nbsp;&nbsp;&nbsp;码</td>
						<td><input type="password" name="loginPass" id="password" class="login_input" /></td>
						<td width="100"><button type="button" style="font-size: 15;"
							class="login_bt" onclick="onCheck();"><strong>登&nbsp;&nbsp;&nbsp;录</strong></button></td>
						<td><a href="javascript:winoper('forget_password.html')"
							target="" title="忘记密码">忘记密码?</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
							href="javascript:winoper('change_password.html')" target=""
							title="修改密码">修改密码</a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="clear"></div> -->

	<div class="bg"> 
    	<div class="main-login">
            <div class="logo-login">
               
                <div class="b"><img src="<%=basePath%>WF/Img/logo-login-2.png" width="554" height="75"  alt=""/></div>
            </div>  
            <div class="cot-login">
                <form method="post" action="" id="form1">
					<table class="tab">
						<tr style="font-size: 15; margin-left:0px;">
							<td>账户名</td>
							<td><input type="text" class="txt txt-1" name="loginName" id="name" class="login_input" /></td>
							
							
							
						</tr>
						<tr style="font-size: 15; margin-left:0px;">
							<td>密&nbsp;&nbsp;&nbsp;&nbsp;码</td>
							<td><input type="password"  class="txt txt-1" name="loginPass" id="password" class="login_input" /></td>
						</tr>
						<tr style="height: 60px;">
							<td colspan="2" style="text-align: right;">
								<span style="font-size:12px;width:150px;text-align:left;line-height:70px;">默认账号：admin</span>
								<button type="button" style="width:80px;height:40px;text-align:center;font-size:15px;color:#666;line-height:40px; border: #999 solid 1px;"
								 onclick="onCheck();"><strong>登&nbsp;&nbsp;&nbsp;录</strong></button></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right;">
								<span style="font-size:12px;width:150px;text-align:left;line-height:10px;">通用密码：pub</span>
								<a href="WF/Admin/CCBPMDesigner/Login.jsp" style="font-size:12px;">进入流程设计器</a>
							</td>
						</tr>
					</table>
				</form>            
            </div>
         
       </div>
    </div>
	
</body>

<script type="text/javascript">
	$(document).keydown(function(e) {
		if (e.keyCode == 13) {
			onCheck();
		}
	});

	/* var errNo = GetQueryString("errNo");
	if(null != errNo && "" != errNo){
		if("1" == errNo)$("#name").alert("请填写正确的账户名！");
	} */
	
	function onCheck() {
		var name = $.trim($("#name").val());
		if (name.length == 0) {
			$("#name").alert("请填写账户名！");
			return false;
		}
		var password = $.trim($("#password").val());
		if (password.length == 0) {
			$("#password").alert("请填写密码！");
			return false;
		}
		
		$.ajax({
			url:'<%=basePath%>WF/Login.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:$('#form1').serialize(),
			async: false ,
			error: function(data){},
			success: function(data){
				json = eval(data);
				if(json.success){
					window.location.href = "<%=basePath%>WF/Default.jsp";
				}else{				
					$("#password").alert(json.msg);				
						
				}
			}
		});
		
	<%-- 	window.location.href = "<%=basePath%>WF/Default.jsp?name=" + name; --%>
	}
	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}
</script>
</html>
