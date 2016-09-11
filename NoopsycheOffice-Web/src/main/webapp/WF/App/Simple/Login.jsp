<%@page import="BP.WF.Glo"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.WF.Port.Emp"%>
<%@page import="BP.Tools.StringHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String isDoLogin = request.getParameter("doLogin");
String userNo = request.getParameter("TB_NO");
String errerMsge = "";

if(!StringHelper.isNullOrEmpty(isDoLogin) && isDoLogin.equals("true")){
	if(StringHelper.isNullOrEmpty(userNo)){
		errerMsge = "用户名不能为空！";
	}else{
		Emp emp = new Emp();
		emp.setNo(userNo);
		if (emp.getIsExits() == false){
			errerMsge = "用户名(" + userNo + ")不存在....";
		}else{
			// 调用登录接口,写入登录信息。
			Dev2Interface.Port_Login(userNo);

			//转到待办.
			try{
				response.sendRedirect("Default.jsp");
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		
	}
}

%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>

</head>
<body>
	<font color="red"><%=errerMsge%></font>
	<form action="Login.jsp?doLogin=true" method="post">

		<h2>用户登录</h2>
		<fieldset>
			<legend> ccflow登录的API在Button事件后面 </legend>
			<br> 用户名: <input type="text" id="TB_NO" name="TB_NO">
			密码：<input type ="password" id="TB_Pass" name="TB_Pass"> 
			<input type="submit" value="登录"><br>
		</fieldset>
	</form>

	<fieldset>
		<legend>说明:</legend>
		<ul>
			<li>1, 登录界面是有您来编写的。</li>
			<li>2, 密码的验证，登录前后要处理的业务逻辑均有您来开发。</li>
			<li>3, 验证成功后，就调用ccflow的登录API。</li>
		</ul>
	</fieldset>

</body>
</html>