<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file  = "/WF/head/head1.jsp" %>
<%@page import  = "java.math.BigDecimal" %>
<%@page import  = "java.util.List" %>
<%@page import  = "BP.DA.DataRowCollection" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <style type="text/css">
        body{
            margin: 0px;
            padding: 0px;
        }
        .center{
            text-align: center;
        }
        .node div{
            cursor: pointer;
            width: 140px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            -o-text-overflow: ellipsis;
            -icab-text-overflow: ellipsis;
            -khtml-text-overflow: ellipsis;
            -moz-text-overflow: ellipsis;
            -webkit-text-overflow: ellipsis;
        }       
    </style>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="../../../../Scripts/jquery/themes/default/easyui.css" rel="stylesheet"
        type="text/css" />
    <link href="../../../../Scripts/jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../../../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../../../../Scripts/jquery/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../../../Scripts/jquery/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
        });
    </script>
  </head>
  <body>
    <table style="width: 100%; min-width: 750px;">
        <caption>
            节点数据分析</caption>
        <tr>
            <th class="GroupTitle" rowspan="2">
                IDX
            </th>
            <th class="GroupTitle center" rowspan="2">
                节点
            </th>
            <th class="GroupTitle center" rowspan="2">
                岗位
            </th>
            <th class="GroupTitle center" colspan="2">
                用时分析(单位:分钟)
            </th>
            <th class="GroupTitle center" colspan="4">
                状态分析
            </th>
            <th class="GroupTitle center" rowspan="2">
                按期办结率
            </th>
            <th class="GroupTitle center" rowspan="2">
                停留<br>逾期
            </th>
            <th class="GroupTitle center" rowspan="2">
                停留<br>待办
            </th>
            <th class="GroupTitle center" rowspan="2">
                工作<br>人员
            </th>
        </tr>
        <tr>
            <th class="GroupTitle center">
                提前
            </th>
            <th class="GroupTitle center">
                逾期
            </th>
            <th class="GroupTitle center">
                按时
            </th>
            <th class="GroupTitle center">
                及时
            </th>
            <th class="GroupTitle center">
                超期
            </th>
            <th class="GroupTitle center">
                逾期
            </th>
        </tr>
        <%
            String flowNo = request.getParameter("FK_Flow");
            
            BP.WF.Nodes nds = new BP.WF.Nodes(flowNo);

            String dbstr = BP.Sys.SystemConfig.getAppCenterDBVarStr();

            int idx = 0;
                idx++;
            for (Node item: nds.Tolist()){

                //提前完成的分钟数.
                BP.DA.Paras ps = new BP.DA.Paras();
                //ps = new BP.DA.Paras();
                ps.SQL = "SELECT SUM(" + BP.WF.Data.CHAttr.OverMinutes + ") FROM  WF_CH WHERE FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                BigDecimal saveMinte = BP.DA.DBAccess.RunSQLReturnValDecimal(ps, new BigDecimal(0), 2);

                //计算预期的分钟数.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT SUM(" + BP.WF.Data.CHAttr.OverMinutes + ") FROM  WF_CH WHERE FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                BigDecimal yqMinute = BP.DA.DBAccess.RunSQLReturnValDecimal(ps, new BigDecimal(0), 2);

                //按期完成.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT(" + BP.WF.Data.CHAttr.MyPK + ") FROM  WF_CH WHERE CHSta=" + dbstr + "CHSta  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.CHSta, BP.WF.Data.CHSta.AnQi.ordinal());
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int ch0 = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);

                //及时完成.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT(" + BP.WF.Data.CHAttr.MyPK + ") FROM  WF_CH WHERE CHSta=" + dbstr + "CHSta  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.CHSta, BP.WF.Data.CHSta.JiShi.ordinal());
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int ch1 = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);

                //预期完成.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT(" + BP.WF.Data.CHAttr.MyPK + ") FROM  WF_CH WHERE CHSta=" + dbstr + "CHSta  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.CHSta, (int)BP.WF.Data.CHSta.YuQi.ordinal());
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int ch2 = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);

                //超期完成.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT(" + BP.WF.Data.CHAttr.MyPK + ") FROM  WF_CH WHERE CHSta=" + dbstr + "CHSta  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.CHSta, (int)BP.WF.Data.CHSta.YuQi.ordinal());
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int ch3 = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);

                //按期完成率。
                BigDecimal rate = new BigDecimal(0);
                int all = ch0 + ch1 + ch2 + ch3;

                if (all != 0)
                    rate = new BigDecimal( (ch0 + ch1) / all * 100);

                //停留的逾期.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT( distinct WorkID) AS Num FROM  WF_GenerWorkerlist WHERE IsPass=0  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int tolistYuQi = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);

                //停留待办.
                ps = new BP.DA.Paras();
                ps.SQL = "SELECT COUNT( distinct WorkID) AS Num FROM  WF_GenerWorkerlist WHERE IsPass=0  AND FK_Node=" + dbstr + "FK_Node";
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                int tolist = BP.DA.DBAccess.RunSQLReturnValInt(ps, 0);


                //工作人员.
                String worker = "";
                ps = new BP.DA.Paras();
                if(flowNo!=null && !"".equals(flowNo)){
                	int flowNoInt = Integer.parseInt(flowNo);
                    ps.SQL = "SELECT DISTINCT EmpFrom, EmpFromT FROM ND" + flowNoInt + "Track WHERE NDFrom=" + dbstr + "FK_Node";

                }
                ps.Add(BP.WF.Data.CHAttr.FK_Node, item.getNodeID());
                DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(ps);

                if (dt.Rows.size() == 0) {
                    worker = "无";
                }
                else{
                    for(DataRow dr: dt.Rows){
                        worker += dr.toString() + "、";
                    }
                    out.println("worker"+worker);
                   /*  for(int i=0;i<dt.Rows.size();i++){
                    	worker += dt.get(0).toString()+"、";
                    	
                    } */
                    int index = worker.toString().lastIndexOf("、");  
                    StringBuffer sb = new StringBuffer(worker);
                    worker = sb.deleteCharAt(index).toString();
                }
        %>
        <tr>
            <td class="Idx">
                <%=idx %>
            </td>
            <td class="node">
                <div title="<%=item.getName() %>" class="easyui-tooltip infTip">
                    [<%=item.getNodeID()  %>]
                    <%=item.getName()%></div>
            </td>
            <% if (item.getHisStationsStr().length() > 4)
               {%>
            <td class="center" style="min-width: 55px;">
                <a title="<%=new StringBuffer(item.getHisStationsStr()).deleteCharAt(item.getHisStationsStr().indexOf(",")) %>" class="easyui-tooltip infTip" href="javascript:;">
                    点击查看</a>
            </td>
            <%}
               else
               { %>
            <td class="center" style="width: 55px;">
                <%=new StringBuffer(item.getHisStationsStr()).deleteCharAt(',') %>
            </td>
            <%} %>
            <td class="center">
                <%=saveMinte%>
            </td>
            <td class="center">
                <%=yqMinute%>
            </td>
            <td class="center">
                <%=ch0 %>
            </td>
            <td class="center">
                <%=ch1 %>
            </td>
            <td class="center">
                <%=ch2 %>
            </td>
            <td class="center">
                <%=ch3 %>
            </td>
            <td class="center">
                <%=rate %>
            </td>
            <td class="center">
                <%=tolistYuQi%>
            </td>
            <td class="center">
                <%=tolist %>
            </td>
            <td class="center">
                <%
                    if (worker.length() > 4)
                    {%>
                <a title="<%=worker %>" class="easyui-tooltip infTip" href="">点击查看</a>
                <%}
                    else{%>
                <a title="<%=worker %>" href="">
                    <%=worker %></a>
                <%}
                %>
            </td>
        </tr>
        <%}%>
      </table>
  </body>
</html>