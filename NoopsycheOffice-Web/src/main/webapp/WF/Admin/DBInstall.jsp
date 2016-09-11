<%@page import="javax.crypto.BadPaddingException"%>
<%@page import="BP.DA.DBAccess"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<%-- <%

  String path="D:\ccflow\value-added\CCFlow\WF\Data\FlowDemo\Form\01.表单元素\01.表单元素.xml";
  BP.DA.DataSet ds=new BP.DA.DataSet();
  ds.readXml(path);

  MapData md = MapData.ImpMapData(ds, false);
  

%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>驰骋工作流程管理系统 - JFlow 安装</title>
    <link href="../Style/FormThemes/Table0.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
</head>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
$(function() {
	function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); 
        var r = window.location.search.substr(1).match(reg);  
        if (r != null) return unescape(r[2]); return null; 
    }
	var value=getUrlParam('msg');
	if(value=="DBFalse"){
		$("#dbFalse").show();
	}else{
		$("#JflowFalse").show();
		$("#div1").show();
	}
	
});

//按钮点击后置灰
function setGray()
{
	var btnDis=document.getElementById('ContentPlaceHolder1_Pub1_Btn_s');
	btnDis.disabled = true;
	//setTimeout("btnDis.disabled=true",3000);
}
var index =0;
function installDB(){
	//setGray();
	document.getElementById('ContentPlaceHolder1_Pub1_Btn_s').value = "JFlow已经开始安装，请您稍候";
	index++;
	if(index>1){
		alert("JFlow已经开始安装，请您稍候.");		
	}else{
		$.ajax({
			url:'<%=basePath%>WF/dbinstall.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:$('#form1').serialize(),
			async: false ,
			error: function(data){},
			success: function(data){
				json = eval(data);
				if(json.success){
					alert("数据库安装成功,管理员 admin 密码 pub 其他用户请:  SELECT * FROM Port_Emp");
					window.location.href = "<%=basePath%>WF/Login.jsp";
				}else{				
					alert("数据库安装失败，请检查数据库连接配置是否正常.");			
						
				}
			}
		});
	
	}
	
}
function checkDB(){
	$.ajax({
		url:'<%=basePath%>WF/checkDb.do',
		type:'post',
		dataType:'json',
		asynv:false,
		error: function(data){},
		success:function(data){
			json = eval(data);
			if(!json.success){
				alert("表或视图已存在，或数据库用户权限不足，请您检查库");
			}
		}
	});
}
</script>

<body topmargin="0" leftmargin="0"  onload="checkDB()" >
   
<div style="width:700px; margin:0 auto;border: #dcdcdc solid 1px;padding: 20px 10px;">
      <fieldset width='50%' id="dbFalse" style="display: none;">
      <legend>驰骋工作流程引擎-JFlow 数据库配置提示.</legend>
            <ul>
			 <li> 您没有正确的配置好jFlow的数据库连接，请检查并修改 \resources\jflow.properties 全局配置文件.  </li>
			 			  <li>初次安装需要创建一个空白的数据库，如果在安装过程失败，请删除该数据库重新创建。 </li>
			 			  
			 			  <li><a href="/jflow-web/" >点击这里刷新，检查数据库连接。</a></li>
		    </ul>
   	  </fieldset>
   	  
   	  <!--  
   	   <fieldset width='50%' id="JflowFalse" style="display: none;">
      <legend>驰骋工作流程引擎-JFlow 提示</legend>
            <ul>
            <li> 您已经安装好了 jFlow , 如果您要重新安装，需要删除该数据库并新建空白的数据库，再执行安装。</li>			 			  
		    </ul>
   	  </fieldset>
   	   -->
     
     <div id="div1" style="display: none;">
     <H3>JFlow 数据库修复与安装工具 </H3>
     <form id="form1">
     <fieldset width='100%' >
     <legend>&nbsp;选择安装语言(JFlow目前仅支持中文).&nbsp;</legend>
     <span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_CH" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ch" value="RB_CH" checked="checked" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_CH">简体中文</label>
     </span>
     <span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_B5" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ch" value="RB_B5" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_B5">繁体中文</label></span><span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_EN" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ch" value="RB_EN" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_EN">English</label>
     </span>
     <span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_JP" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ch" value="RB_JP" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_JP">日本语</label>
     </span>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_RU" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ch" value="RB_RU" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_RU">Русский</label>
     </span>
     </fieldset>
     <BR>
     <fieldset width='100%' >
     <legend>&nbsp;当前数据库安装类型(如果要修改数据库类型请修改 \resources\jflow.properties设置).&nbsp;</legend>
     <span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_SQL" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$sd" value="RB_SQL" checked="checked" disabled="disabled"/>
     <label for="ContentPlaceHolder1_Pub1_RB_SQL">SQLServer2000,2005,2008系列版本</label>
     </span>
     <BR>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_Oracle" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$sd" value="RB_Oracle" disabled="disabled"/>
     <label for="ContentPlaceHolder1_Pub1_RB_Oracle">Oracle,Oracle9i,10g系列版本</label>
     </span>
     <BR>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_MYSQL" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$sd" value="RB_MYSQL" disabled="disabled"/>
     <label for="ContentPlaceHolder1_Pub1_RB_MYSQL">MySQL系列版本</label>
     </span>
     <BR>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_DB2" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$sd" value="RB_DB2" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_DB2">Informix 系列版本(首先需要执行:jflow-web\src\main\webapp\WF\Data\Install\Informix.sql)</label>
     </span>
     <BR>
     </fieldset>
     <fieldset width='100%' >
     <legend>&nbsp;JFlow的运行模式,(如果请修改 \resources\jflow.properties设置) 中的 OSModel 进行配置. &nbsp;</legend>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_WorkFlow" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$model" value="RB_WorkFlow" checked="checked" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_WorkFlow">集成模式</label>
     </span>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_BMP" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$model" value="RB_BMP" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_BMP">BPM工作模式</label>
     </span>
     <BR>
     </fieldset>
  <!--    <fieldset width='100%' >
     <legend>&nbsp;是否需要安装CCIM.&nbsp;</legend>
     <input id="ContentPlaceHolder1_Pub1_RB_CCIM_Y" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ccim" value="RB_CCIM_Y" checked="checked" />
     <label for="ContentPlaceHolder1_Pub1_RB_CCIM_Y">是</label>
     <input id="ContentPlaceHolder1_Pub1_RB_CCIM_N" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$ccim" value="RB_CCIM_N" />
     <label for="ContentPlaceHolder1_Pub1_RB_CCIM_N">否</label>
     <BR>
     </fieldset> -->
     <fieldset width='100%' >
     <legend>&nbsp;应用环境模拟.&nbsp;</legend>
     <span class="aspNetDisabled">
     <input id="ContentPlaceHolder1_Pub1_RB_Inc" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$hj" value="RB_Inc" checked="checked" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_Inc">集团公司，企业单位。</label>
     </span>
     <BR>
     <span class="aspNetDisabled"><input id="ContentPlaceHolder1_Pub1_RB_Gov" type="radio" name="ctl00$ContentPlaceHolder1$Pub1$hj" value="RB_Gov" disabled="disabled" />
     <label for="ContentPlaceHolder1_Pub1_RB_Gov">政府机关，事业单位。</label>
     </span>
     <BR>
     </fieldset>
     <BR>
     <fieldset width='100%' ><legend>&nbsp;是否装载演示流程模板?&nbsp;</legend>
     <input id="ContentPlaceHolder1_Pub1_RB_DemoOn" type="radio" name="demo" value="RB_DemoOn" checked="checked" />
     <label for="ContentPlaceHolder1_Pub1_RB_DemoOn">是:我要安装demo组织结构体系、demo流程模板、表单模板，以方便我学习jflow与jform.</label>
     <BR>
     <input id="ContentPlaceHolder1_Pub1_RB_DemoOff" type="radio" name="demo" value="RB_DemoOff" />
     <label for="ContentPlaceHolder1_Pub1_RB_DemoOff">否:不安装demo。仅仅安装空白的ccbpm环境(估计在2-3分钟内安装完成)。</label>
     <BR>
     </fieldset>
     <BR>
     <input type="button" name="ctl00$ContentPlaceHolder1$Pub1$Btn_s" value="接受JFlow的 GPL开源软件协议并安装" onclick="installDB()" id="ContentPlaceHolder1_Pub1_Btn_s" class="Btn" />
     <BR>
     <BR>1.估计在<font color=red size=“6px” >10分钟</font>内安装完成.
     <BR>2.您需要先在数据库中建立名为 jflow(自命名)的空数据库.
     <BR>3.当前的数据库连接用户，需要有创建删除视图与表的权限，否则安装失败.
     <BR>4.安装期间请耐心等待,不要关闭界面,如果您选择demo模式，系统将会装载200多个demo流程模版导致安装过程变慢.
     <BR>5.如果安装错误,都要删除数据库重新建,或svn最新的程序进行重新安装,或者把安装遇到的问题反馈给jflow开发团队. 
     <BR>
     <a href='http://bbs.ccflow.org' target=_blank >JFlow 技术论坛</a> | <a href='http://jflow.cn' target=_blank >JFlow 管方网站</a>
     
     </form>
     </div>



   <%--  <H3>JFlow 数据库修复与安装工具 </H3>
    <HR>
    <%
	
	try
	{
        if (DBAccess.IsExitsObject("WF_Flow") ==true)
        {
    %>
	
    <fieldset width='100%' >
      <legend>&nbsp;提示&nbsp;</legend>
          数据已经安装，如果您要重新安装，您需要手工的清除数据库里对象。
   </fieldset>
   
   <%  
      return;
	
	}catch
	{
		%>
		
     <fieldset width='50%' >
      <legend>驰骋工作流程引擎-JFlow 安装提示.</legend>
            <ul>
			 <li> 驰骋工作流程引擎包含.net 版本ccflow 官方网站 http://ccflow.org  与Java版本的JFlow. http://www.jflow.cn </li>
			 <li> 在安装JFlow之前您需要遵守JFlow的GPL开源协议，什么是GPL开源协议请到网上了解。</li>
			 <li> 您没有正确的配置好jFlow的数据库连接，请修改 \resources\conf\web.properties 文件。</li>			  
		    </ul>
   </fieldset>
   
		<%
		return ;
	}
    %>
         
     
     <fieldset width='50%' >
      <legend>驰骋工作流程引擎-JFlow 安装提示.</legend>
            <ul>
			 <li> 驰骋工作流程引擎包含.net 版本ccflow 官方网站 http://ccflow.org  与Java版本的JFlow. http://www.jflow.cn </li>
			 <li> 在安装JFlow之前您需要遵守JFlow的GPL开源协议，什么是GPL开源协议请到网上了解。</li>
			 <li> 您即将把JFlow安装在 <%= BP.Sys.S SystemConfig.AppCenterDNS %> 上，如果您要修改数据库，请修改 \resources\conf\web.properties 文件。</li>
		    </ul>
			
			[<a href="?DoIt=1">接受JFlow的GPL开源协议并安装</a>] -  [<a href="">接受JFlow的GPL开源协议并安装</a>]
   </fieldset>
   
    --%>
   
</div>    
    </form>
</body>
</html>