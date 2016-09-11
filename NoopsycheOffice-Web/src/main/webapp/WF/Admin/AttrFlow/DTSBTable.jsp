<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import= "java.util.ArrayList"%>
<%@page import= "java.util.List"%>
<%@ include file="/WF/head/head1.jsp"%>
<head>
</head>
<body>
<%
	DTSBTableModel dtsb = new DTSBTableModel(request,response);
	dtsb.init();
    String flowNo = request.getParameter("FK_Flow");
    if (flowNo == null || flowNo == "")
        flowNo = "001";
    BP.WF.Flow fl = new BP.WF.Flow(flowNo);
    %>
    <table>
        <caption>与业务表数据同步</caption>
        <tr>
            <td valign="top" style="width: 20%; color:Gray">
                <fieldset>
                    <legend>应用场景</legend>
                    <ol>
                        <li>在稍大的应用中，流程系统与业务系统的数据库是分开的。比如：业务流程系统、固定资产系统、客户关系管理系统、财务系统。</li>
                        <li>在固定资产管理系统中，流程审批数据库与固定资产数据库是分开的，一个固定资产的采购申请走完后，需要把该固定资产采购的信息同步到固定资产系统中去，或者一个固定资产的报废需要把该审批结果需要更新固定资产状态。</li>
                        <li>流程走完一个订单审批后，需要把订单的信息同步到仓库管理系统中去。</li>
                    </ol>
                </fieldset>
                <fieldset>
                    <legend>帮助</legend>
                    <ol>
                        <li>ccbpm在运转的过程中会把节点表单的数据存储到ccbpm数据库的数据表 <span style="color: Blue;">[
                            <%=fl.getPTable()%>] </span>里，这个表的名称可以在流程属性里定义。 </li>
                        <li>流程数据存储表可以自定义，定义路径：流程属性=》 基本属性=》流程数据表。</li>
                        <li>有的应用场景下，会把该表的业务数据同步到其他系统中去，ccbpm提供了事件可以使用编程的方式实现这样的需求。</li>
                        <li>为了更好的适应开发者的需求，我们提供了界面化的定义工具。 </li>
                        <li>该功能可以把流程数据转出到指定的数据库上，指定的数据表里。</li>
                    </ol>
                </fieldset>
            </td>
            <td valign="top" style="text-align: center;">
                <fieldset>
                    <legend>
                        <input type="radio" ID="RB_DTSWay0" Text="" <%if(dtsb.RB_DTSWay0){ %>checked="checked"<%} %> name="Way22" runat="server" >不执行同步</input>
                    </legend>
                    <ul style="color:Gray">
                        <li>流程运行的数据存储到<span style="color: Blue;">[<%=fl.getPTable()%>]</span> ,不与其他系统交换数据。</li>
                        <li>其他系统可以读写这个表<span style="color: Blue;"> [<%=fl.getPTable() %>] </span>的数据，完成相关的业务操作。</li>
                        <li>该表名<span style="color: Blue;"> [<%=fl.getPTable() %>] </span>是可以在流程属性配置。</li>
                    </ul>
                </fieldset>
                <fieldset>
                    <legend>
                        <input type="radio" ID="RB_DTSWay1" <%if(dtsb.RB_DTSWay1){ %>checked="checked"<%} %> Text="" name="Way22" runat="server" >执行同步</input>
                    </legend>
                    <table style="text-align: center;">
                        <tr>
                            <td>
                                请选择要导出的数据源
                            </td>
                            <td>
                                <select ID="DDL_DBSrc" runat="server" OnSelectedIndexChanged="DDL_DBSrc_SelectedIndexChanged">
                                	<% for(Map.Entry<String, String> entry:dtsb.DDL_DBSrc.entrySet()){%>
                                		<option value='<%=entry.getKey() %>'><%=entry.getValue()%></option>
                                	<%} %>
                                </select>
                                &nbsp;
                                <%--</td>
                            <td>--%>
                                你可以在表单库中, <!-- <a href="javascript:OpenDBASource();"></a> -->
                                    【设置数据源】。
                                <%--<a href="javascript:WinOpen('../../Comm/Sys/SFDBSrcNewGuide.jsp','_blank');">设置数据源</a>。--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                指定的表
                            </td>
                            <td>
                                <select ID="DDL_Table" runat="server" OnSelectedIndexChanged="DDL_Table_SelectedIndexChanged">
                                	<% for(Map.Entry<String, String> entry:dtsb.DDL_Table.entrySet()){%>
                                		<option value='<%=entry.getKey() %>'><%=entry.getValue()%></option>
                                	<%} %>
                                </select>
                                &nbsp;
                                <%-- </td>
                            <td>--%>
                                要把数据同步到那个数据表里去？
                            </td>
                        </tr>
                        <tr>
                            <td>
                                同步的计算方式
                            </td>
                            <td>
                                <input type="radio" ID="RB_DTSField0" <%if(dtsb.RB_DTSField0){ %>checked="checked"<%} %> Text="" name="Way" runat="server" >字段名相同</input>
                                <input type="radio" ID="RB_DTSField1" <%if(dtsb.RB_DTSField1){ %>checked="checked"<%} %> Text="" name="Way" runat="server" >按设置字段</input>
                                &nbsp; [<a href="javascript:OpenFields()">设置字段匹配</a>]
                            </td>
                        </tr>
                        <script type="text/javascript">
                        function OpenDBASource(){
                            if(window.parent && window.parent.addTab){
                            	window.parent.addTab('dtsbTable','设置数据源','../../Comm/Sys/SFDBSrcNewGuide.jsp','');
                            }else{
                                window.open('../../Comm/Sys/SFDBSrcNewGuide.jsp','newwindow', 'height=600, width=800, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
                            }
                        }
   //设置字段匹配
   function OpenFields() {
      var src = $("#DDL_DBSrc").val();
      if(src==null||src==''||src==undefined){
    	  src=$("#DDL_DBSrc option:first").val();
      }
      var tableName = $("#DDL_Table").val();
      if(tableName==null||tableName==''||tableName==undefined){
    	  tableName=$("#DDL_Table option:first").val();
      }
      var fk_flow='<%=flowNo %>';

      var url='../../Admin/AttrFlow/DTSBTableExt.jsp?FK_Flow='+fk_flow+'&FK_DBSrc=' + src + '&TableName=' + tableName + '&';
      if(window.parent && window.parent.addTab){
        window.parent.addTab('dtsbTable','设置字段匹配',url,'');
      }else{
    	  window.open(url,'_blank');
      }
   }
   function OpenDTSNodes() {
   var toggleStyle= document.getElementById("dis").style.display;
   if (toggleStyle=="none") {
     document.getElementById("dis").style.display="block";
      }else {
     document.getElementById("dis").style.display="none";
}
   }
function WinOpen(url, winName) {
    var newWindow = window.open(url, winName, 'width=700,height=400,top=100,left=300,scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
    newWindow.focus();
    return;
}
   //必须初始化
   window.onload=function(){
      checkNodes();
   };
 
   function checkNodes(){
        var  input = document.getElementsByTagName("input");
         var   value='';
        for (var i = 0; i < input.length; i++) {
            if (input[i].type == "checkbox") {
                if (input[i].checked) {
                    value += input[i].id+",";
                }
            }
        }
    
      $("#HiddenField").val(value);
    }
                        </script>
    <script type="text/javascript">
        function BtnSave_Click(){
        	var param = window.location.search;
        	var Way22 = $("input[name=Way22]:checked").attr("id");//id
        	var DDL_DBSrc = $("#DDL_DBSrc").val();
        	var DDL_Table = $("#DDL_Table").val();
        	var Way = $("input[name=Way]:checked").attr("id");
        	var xx = $("input[name=xx]:checked").attr("id");
        	var HiddenField = $("#HiddenField").val();
        	$.ajax({
    			url:'<%=basePath%>WF/DTSBTable/BtnSaveClick.do'+param,
    			type:'post', //数据发送方式
    			dataType:'json', //接受数据格式
    			data:{Way22:Way22,DDL_DBSrc:DDL_DBSrc,DDL_Table:DDL_Table, Way:Way, xx:xx,HiddenField:HiddenField},
    			async: false ,
    			error: function(data){
    				alert(data.msg);
    			},
    			success: function(data){
    				alert(data.msg);
    			}
    		});
        }
    </script>
                        <tr>
                            <td style="border-bottom: none;">
                                同步的时间
                            </td>
                            <td style="border-bottom: none;">
                                <input type="radio" ID="RB_DTSTime0" <%if(dtsb.RB_DTSTime0){ %>checked="checked"<%} %> Text="" name="xx" runat="server" >所有的节点发送后</input>
                                <br />
                                <input type="radio" ID="RB_DTSTime2" <%if(dtsb.RB_DTSTime2){ %>checked="checked"<%} %> Text="" name="xx" runat="server" >流程结束时</input>
                                <br />
                                <input type="radio" ID="RB_DTSTime1" <%if(dtsb.RB_DTSTime1){ %>checked="checked"<%} %> Text="" name="xx" runat="server" >指定的节点发送后</input>
                                [<a href="javascript:OpenDTSNodes()">设置同步的节点</a>]
                                <div id="dis" style="display: none;">
                                    <fieldset>
                                        <legend>选择节点</legend>
                                        <%
                                            BP.WF.Nodes nds = fl.getHisNodes();
                                            String html = "<table><tr>";
                                            int count = 1;

                                            String[] checkNodes = fl.getDTSSpecNodes().split(",");
											for (BP.WF.Node nd : nds.ToJavaList())
											{
												boolean isChecked = false;
												for (String cn : checkNodes)
												{
													if ((nd.getNodeID()+"").equals(cn))
													{
														isChecked = true;
													}
												}
												if (count == 2) //一行两列
												{
													if (isChecked)
													{
														html += "<td ><input onclick=\"checkNodes();\"  class=\"checkNode\"   checked=\"checked\" id=\"" + nd.getNodeID() + "\" type=\"checkbox\" />[" + nd.getNodeID() + "]" + nd.getName() + "</td></tr>";
													}
													else
													{
														html += "<td><input onclick=\"checkNodes();\"  class=\"checkNode\" id=\"" + nd.getNodeID() + "\" type=\"checkbox\" />[" + nd.getNodeID() + "]" + nd.getName() + "</td></tr>";
													}

													count = 0;
												}
												else
												{
													if (isChecked)
													{
														html += "<td><input onclick=\"checkNodes();\"  class=\"checkNode\"  checked=\"checked\"  id=\"" + nd.getNodeID() + "\" type=\"checkbox\" />[" + nd.getNodeID() + "]" + nd.getName() + "</td>";
													}
													else
													{
														html += "<td><input onclick=\"checkNodes();\"  class=\"checkNode\"  id=\"" + nd.getNodeID() + "\" type=\"checkbox\" />[" + nd.getNodeID() + "]" + nd.getName() + "</td>";
													}
												}
												count += 1;
											}
											html += "</table>";
                                        %>
                                        <%=html %>
                                        <input type="hidden" ID="HiddenField" runat="server" value=''/>
                                    </fieldset>
                                </div>
                                <br />
                            </td>
                            <td style="border-bottom: none;">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <input type="button" ID="BtnSave" runat="server" OnClick="BtnSave_Click()" value=" 保 存 " />
            </td>
        </tr>
    </table>
</body>
</html>