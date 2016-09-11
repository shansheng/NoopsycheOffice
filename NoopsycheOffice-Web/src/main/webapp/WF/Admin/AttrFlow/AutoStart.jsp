<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="BP.WF.Template.*"%>
<%@page import="BP.WF.*"%>
<%@page import="BP.DA.*"%>
<%@page import="BP.WF.Template.FlowSheet"%>
<%@include file  = "/WF/head/head1.jsp" %>
<body>
<%
	String FK_Flow = request.getParameter("FK_Flow");
    int fl_flow = Integer.parseInt(FK_Flow);
	FlowSheet en = new FlowSheet(FK_Flow);
    String frw = en.getFlowRunWay().toString();
    boolean RB_HandWork = false;
    boolean RB_SpecEmp = false;
    boolean RB_DataModel = false;
    boolean RB_InsertModel = false;
    String TB_SpecEmp = "";
    String TB_DataModel = "";
	if (frw.equals(FlowRunWay.HandWork.getValue()+"")){
		RB_HandWork = true;
	}else if(frw.equals(FlowRunWay.SpecEmp.getValue()+"")){
		RB_SpecEmp = true;
        TB_SpecEmp = en.getRunObj();
	}else if(frw.equals(FlowRunWay.DataModel.getValue()+"")){
		TB_DataModel = en.getRunObj();
        RB_DataModel = true;
	}else if(frw.equals(FlowRunWay.InsertModel.getValue()+"")){
		RB_InsertModel = true;
	}
%>
<table style="width: 100%">
        <caption>自动发起</caption>
        <tr>
            <td valign="top" style="width: 20%;">
                <fieldset>
                    <legend>帮助</legend>
                    <ul>
                    <li> 定义：自动启动工作流程，一个流程的开始节点的填写与发起是在特定规则的设置下自动发起的流程。</li>
                    <li> 解释：通常模式下的流程启动是手工的启动，就是用户从一个发起列表，点击流程名字，就启动了该流程。但是有的时候，是系统自动发起该流程。</li>

                        <li>应用场景</li>
                        <li> 1 周例会流程，用户希望每个周都要启动例会通知流程这个启动是让系统自动发起而非人工发起。</li>
                        <li> 2 周例会流程，用户希望每个周都要启动例会通知流程这个启动是让系统自动发起而非人工发起。</li>

                    </ul>
                </fieldset>
            </td>
            <td valign="top">
                <fieldset>
                    <legend>
                        <input type="radio" <%if(RB_HandWork){ %>checked="checked"<%} %> ID="RB_HandWork" Text="" name="xzgz" runat="server" Checked="true" />手工启动（默认）</legend>
                        <ul>
                        <li>
                     <font color="gray">说明：就是说工作人员从流程发起列表里，点流程，就发起流程。</font>
                     </li>
                     </ul> 
                </fieldset>
                <fieldset>
                    <legend>
                        <input type="radio" <%if(RB_SpecEmp){ %>checked="checked"<%} %> ID="RB_SpecEmp" Text="" runat="server" name="xzgz" />指定人员按时启动</legend>
                        
                         <a href="javascript:ShowHidden('emps')">操作员参数设置:</a>
              <div id="emps" style=" display:none;color:Gray">
               <ul>
               <li>说明：指定的人员指定的发起时间点自动启动流程。</li>
               <li>请打开操作手册：<a href="javascript:WinOpen('http://ccbpm.mydoc.io/?v=5404&t=17088')">操作手册</a></li>
               <li>一个人启动的参数格式：人员编号@时间点1@时间点2@时间点n  </li>

               <li>n个人启动的参数格式：人员编号@时间点1@时间点2@时间点n,人员编号@时间点1@时间点2@时间点n,人员编号@时间点1@时间点2@时间点n</li>

               <li>比如：zhangshan@01:01@12:01  让张三在每天的 1点零1分，与12点零1分发起此流程。</li>
               <li>比如：zhangshan@-01 01:01  让张三在每月1号的1点零1分发起此流程。</li>
               <li>比如：zhangshan@06-01 01:01  让张三在每年的6月1号的1点零1分发起此流程。</li>

               <li>cc的日期格式为：yyyy-MM-dd HH:mm 如果时间匹配到您设置的时间点，那么系统就会触发流程，多个时间点用@符号隔开。</li>
               </ul>
               </div>

               <input type="text" value="<%=TB_SpecEmp %>" ID="TB_SpecEmp"  runat="server" Width="95%"/>       
                </fieldset>



                <fieldset>
                    <legend>
                        <input type="radio" <%if(RB_DataModel){ %>checked="checked"<%} %> ID="RB_DataModel" runat="server" name="xzgz" />数据集按时启动</legend>
                        <a href="javascript:ShowHidden('sql')">SQL参数设置:</a>
              <div id="sql" style=" display:none;color:Gray">
               <ul>
               <li>请设置一个SQL语句，该语句返回一个数据源。</li>
               <li>系统就会对每一条数据发起一条流程，这就是按照数据源的模式自动发起流程。</li>
               <li>该数据源的列名如果与开始节点表单的字段名一致，就会自动赋值。</li>
               <li>该参数支持ccbpm的表达式。</li>
               <li><a href="javascript:WinOpen('<%=basePath%>WF/MapDef/MapExt.jsp?s=d34&FK_MapData=ND<%=fl_flow%>01&ExtType=StartFlow&RefNo=8')">配置数据源</a></li>
               <li>请打开操作手册：<a href="javascript:WinOpen('http://ccbpm.mydoc.io/?v=5404&t=17088')">操作手册</a></li>
               </ul>
               </div>

					<input type="text" value="<%=TB_DataModel %>" ID="TB_DataModel"  runat="server" Width="95%"/>

                </fieldset>


                <fieldset>
                    <legend>
                        <input type="radio" <%if(RB_InsertModel){ %>checked="checked"<%} %> ID="RB_InsertModel" Text="" runat="server" name="xzgz" />触发式启动</legend>
                        <ul style="color:Gray">
                        <li>说明:第三方软件向特定的表 WF_Task 中写入数据，每写入一条数据系统就会自动发起一条流程。</li>
                        <li>ccBPM就会读取这张表来完成流程的发起，发起成功后就把这条记录设置成已经发起的状态。</li>
                        <li>详见设置以及该表的结构参考<a href="javascript:WinOpen('http://ccbpm.mydoc.io/?v=5404&t=17088')">操作手册</a></li>
                        </ul>
                    <font color="gray">
                    </font>                 
                </fieldset>
                <input type="button" class="easyui-linkbutton" id="Btn_Save"
				runat="server" value="保存" onClick="onSave()" />

                <a style=" float:right" href="javascript: if ( confirm('您确定要执行吗? 注意:对于数据量交大的数据因为web上执行时间的限时问题，会造成执行失败。') ) { WinOpen('<%=basePath %>WF/Comm/Refmethod.jsp?Index=7&EnsName=BP.WF.Template.FlowSheets&No=<%=FK_Flow %>&r=1208095548','_blank') }" tooltip="">手动启用定时任务</a>
            </td>
        </tr>
    </table>
</body>
<SCRIPT>
	function WinOpen(url) {
	    window.open(url, "", 'height=600, width=800, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
	    //window.open(url, 'xx');
	}
	function ShowHidden(id){
		$("#"+id).toggle();
	}
	
	//ajax 提交
	function onSave(){
		var keys = "";
		var xzgz=$("input[name=xzgz]:checked").attr("id");
		var TB_SpecEmp=$("#TB_SpecEmp").val();
		var TB_DataModel=$("#TB_DataModel").val();
		$.ajax({
			url:'<%=basePath%>WF/AutoStart/BtnSaveClick.do',
			type:'post', //数据发送方式
			dataType:'json', //接受数据格式
			data:{TB_SpecEmp:TB_SpecEmp,TB_DataModel:TB_DataModel,xzgz:xzgz,FK_Flow:'<%=FK_Flow%>'},
			async: false ,
			error: function(data){},
			success: function(data){
				var json = eval("("+data+")");
				if(json.success){
					keys = json.msg;
				}else{
				}
			}
		});
		if (window.opener != undefined) {
	        window.top.returnValue = keys;
	    } else {
	        window.returnValue = keys;
	    }
		window.close();
	}
</SCRIPT>
</html>