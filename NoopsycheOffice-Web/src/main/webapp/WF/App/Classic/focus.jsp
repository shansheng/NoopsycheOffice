<%@page import="BP.DA.DataTable" %>
<%@page import="BP.WF.Dev2Interface" %>
<%@page import="BP.DA.DataRow" %>
<%@page import="java.util.*" %>
<%@ include file="/WF/head/head1.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" src="Scripts/easyUI/jquery-1.8.0.min.js"></script>
    <script type="text/javascript">
        //取消关注
        function unfollow(workid)
        {
            $.ajax({
                url: "../../Do.jsp?ActionType=Focus&WorkID=" + workid,
               // async: false,
                success: function () {
                    window.location.reload(true);//刷新
                    alert("您已取消关注！");
                }

            });
           
        }
    </script>
</head>
<body>
 <table style="width:100%;height:700px;border:0px">
        <caption class='CaptionMsg'>&nbsp&nbsp&nbsp 我关注的流程 </caption>
        <tr>
            <td valign="top">
                <table width="100%";>
                    <tr>
                        <th>序</th>
                        <th>流程</th>
                        <th>标题</th>
                        <th>发起人</th>
                        <th>发起日期</th>
                        <th>状态</th>
                        <th>停留节点</th>
                        <th>最后处理人</th>
                        <th>操作</th>
                    </tr>
                    <% 
                        String flowNo = request.getParameter("FK_Flow");
                        int idx = 0;
                        //获得关注的数据.
                        DataTable dt = Dev2Interface.DB_Focus(flowNo,WebUser.getNo());

                        for (DataRow dr : dt.Rows)
                        {
                            String Title = dr.getValue("Title").toString();
                            String flowName = dr.getValue("FlowName").toString();
                            String StarterName = dr.getValue("StarterName").toString();
                            String RDT = dr.getValue("RDT").toString();
                            String Starter = dr.getValue("Starter").toString();
                            int wfsta = Integer.parseInt(dr.getValue("WFSta").toString());
                            String wfstaT = "运行中";
                            if (wfsta == 0)
                                wfstaT = "草稿";
                            if (wfsta == 1)
                                wfstaT = "运行中";
                            if (wfsta == 2)
                                wfstaT = "已完成";

                            String nodeName = dr.getValue("NodeName").toString();
                            String WorkID = dr.getValue("WorkID").toString();
                            flowNo = dr.getValue("FK_Flow").toString();
                            String FK_Node = dr.getValue("FK_Node").toString();
                            String lastNames=String.valueOf(dr.getValue("sender"));
                            String rlastName="";
                            if(lastNames.length()>1){
                            	String[] lastName=lastNames.replaceAll("[\\(\\)]","").split(",");
                            	if(lastName.length>=1){
                            		rlastName=lastName[1];
                				}
                            }
                      %>
                    <tr>
                        <td class="Idx" ><%=idx+1%></td>
                        <td><%=flowName%></td>
                        <td><a href="javascript:WinOpen('<%=basePath%>WF/WFRpt.jsp?WorkID=<%=WorkID %>&FK_Flow=<%= flowNo%>&FK_Node=<%=FK_Node%>')"><%=Title%></td>
                        <td><%=StarterName%></td>
                        <td><%=RDT%></td>
                        <td><%=wfstaT%></td>
                        <td><%=nodeName%></td>
                        <td><%=rlastName%></td>
                        <td><a  href="#" onclick="unfollow('<%=WorkID %>')" >取消关注</a></td>
                    </tr>
                    <% }%>
                  
                </table>
            </td>
        </tr>
    </table>
</body>
</html>