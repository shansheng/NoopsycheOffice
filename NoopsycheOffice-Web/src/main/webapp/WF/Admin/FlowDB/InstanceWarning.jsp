<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file  = "/WF/head/head1.jsp" %>
<%@page import= "java.math.BigDecimal" %>
<%@page import= "java.util.Enumeration" %>
<%@page import= "java.util.List" %>
  
  
<html>    
  <head>
    <link href="../../Scripts/jquery/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../Scripts/CommonUnite.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <link href="../../Comm/Charts/css/style_3.css" rel="stylesheet" type="text/css" />
    <link href="../../Comm/Charts/css/prettify.css" rel="stylesheet" type="text/css" />
    <script src="../../Comm/Charts/js/prettify.js" type="text/javascript"></script>
    <script src="../../Comm/Charts/js/json2_3.js" type="text/javascript"></script>
    <script src="../../Comm/Charts/js/FusionCharts.js" type="text/javascript"></script>
    <script src="../../Comm/Charts/js/FusionChartsExportComponent.js" type="text/javascript"></script>
    <link href="../../Comm/Style/Table.css" rel="stylesheet" type="text/css" />    
    <style type="text/css">
        .style1{
            width: 956px;
            height: 280px;
        }
    </style>
  </head>
    

<body>
  <table id="main" style="width:100%;">
  <caption> 逾期未完成实例</caption>

<%
    String currDT = BP.DA.DataType.getCurrentDataTime();
    String dbstr = BP.Sys.SystemConfig.getAppCenterDBVarStr();
    BP.DA.Paras ps = new BP.DA.Paras();
    //ps = new BP.DA.Paras();
    //求流程
    if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MSSQL){
        ps.SQL = "SELECT Top 5 A.Num,B.Name FROM ( SELECT COUNT(FK_Flow) as Num,FK_Flow FROM WF_GenerWorkFlow WHERE "
            + " SDTOfNode <=" + dbstr + "SDTOfNode AND WFState!=3 AND  WFState > 0 Group BY FK_Flow) A LEFT JOIN WF_Flow B ON A.FK_Flow=B.No"
            + " ORDER BY A.Num DESC";
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MySQL){
        ps.SQL = "SELECT A.Num,B.Name FROM ( SELECT COUNT(FK_Flow) as Num,FK_Flow FROM WF_GenerWorkFlow WHERE "
            + " SDTOfNode <=" + dbstr + "SDTOfNode AND WFState!=3 AND  WFState > 0 Group BY FK_Flow) A LEFT JOIN WF_Flow B ON A.FK_Flow=B.No"
            + " ORDER BY A.Num DESC LIMIT 5 ";     
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.Oracle){
        ps.SQL ="SELECT * FROM  ("
            + "SELECT A.Num,B.Name FROM ( SELECT COUNT(FK_Flow) as Num,FK_Flow FROM WF_GenerWorkFlow WHERE "
            + " SDTOfNode <=" + dbstr + "SDTOfNode AND WFState!=3 AND  WFState > 0 Group BY FK_Flow) A LEFT JOIN WF_Flow B ON A.FK_Flow=B.No"
            + "  ORDER BY A.Num DESC  ) WHERE ROWNUM<=5";
    }
    ps.Add("SDTOfNode", currDT);
    DataTable dtFlow = BP.DA.DBAccess.RunSQLReturnTable(ps);

    //求逾期部门
    ps = new BP.DA.Paras();
    if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MSSQL){
        ps.SQL = "SELECT Top 5 B.Name,A.Num FROM (SELECT COUNT(A.FK_Dept) Num ,A.FK_Dept FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0 GROUP By A.FK_Dept) A "
            + " LEFT JOIN Port_Dept B ON A.FK_Dept=B.No ORDER BY Num DESC";
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MySQL){
        ps.SQL = "SELECT B.Name,A.Num FROM (SELECT COUNT(A.FK_Dept) Num ,A.FK_Dept FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0 GROUP By A.FK_Dept) A "
            + " LEFT JOIN Port_Dept B ON A.FK_Dept=B.No ORDER BY Num DESC LIMIT 5 ";
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.Oracle){
        ps.SQL = "SELECT * FROM ("
            +" SELECT B.Name,A.Num FROM (SELECT COUNT(A.FK_Dept) Num ,A.FK_Dept FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0 GROUP By A.FK_Dept) A "
            + " LEFT JOIN Port_Dept B ON A.FK_Dept=B.No ORDER BY Num DESC ) WHERE ROWNUM<=5";
    }
    ps.Add("SDTOfNode", currDT);
    DataTable dtDept = BP.DA.DBAccess.RunSQLReturnTable(ps);

    //求逾期人员
    ps = new BP.DA.Paras();
    if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MSSQL){
        ps.SQL = "SELECT Top 5 B.Name,A.Num FROM (SELECT COUNT(FK_Emp) Num ,FK_Emp FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0  GROUP By FK_Emp) A"
            + " LEFT JOIN Port_Emp B ON A.FK_Emp=B.No ORDER BY Num DESC";
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.MySQL){
        ps.SQL = "SELECT B.Name,A.Num FROM (SELECT COUNT(FK_Emp) Num ,FK_Emp FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0  GROUP By FK_Emp) A"
            + " LEFT JOIN Port_Emp B ON A.FK_Emp=B.No ORDER BY Num DESC LIMIT 5";
    }else if (BP.Sys.SystemConfig.getAppCenterDBType() == BP.DA.DBType.Oracle){
        ps.SQL = "SELECT * FROM ("
            + "SELECT  B.Name,A.Num FROM (SELECT COUNT(FK_Emp) Num ,FK_Emp FROM WF_GenerWorkerlist A"
            + " LEFT JOIN WF_GenerWorkFlow B ON A.WorkID=B.WorkID AND A.FK_Node=B.FK_Node WHERE  B.SDTOfNode <=" + dbstr + "SDTOfNode AND  B.WFState!=3 AND  B.WFState > 0  GROUP By FK_Emp) A"
            + " LEFT JOIN Port_Emp B ON A.FK_Emp=B.No ORDER BY Num DESC ) WHERE ROWNUM<=5";
    }
    ps.Add("SDTOfNode", currDT);
    DataTable dtEmp = BP.DA.DBAccess.RunSQLReturnTable(ps);
 %>

<tr>
<td id="td_flow" style="width:33%">
<fieldset>
<legend>Top 5 逾期流程统计</legend>

<table>
<%
    if (dtFlow.Rows.size() > 0){
        for (DataRow row: dtFlow.Rows){
        %>
            <tr>
                <td><%=row.get("Name")%></td>
                <td><%=row.get("Num")%></td>
            </tr>
        <%
        }
    }else{ 
     %>   
        <tr>
            <td>都已完成</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    <%}
        if (5 > dtFlow.Rows.size()){
          int num = 5 - dtFlow.Rows.size();
          for (int i = 0; i < num; i++){
            %>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            <%
        } 
    }
     %>

</table>

</fieldset>


</td>

  <td id="td_dept" style="width:33%"> 
  <fieldset>
  <legend>Top 5 逾期部门名单</legend>

  <table>
</body>
<%
    if (dtDept.Rows.size() > 0){
        for(DataRow row: dtDept.Rows){
        %>
            <tr>
                <td><%=row.get("Name")%></td>
                <td><%=row.get("Num")%></td>
            </tr>
        <%
        }
    }else{ 
     %>   
        <tr>
            <td>都已完成</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    <%
    }
    
    if (5 > dtDept.Rows.size()){
        int num = 5 - dtDept.Rows.size();
        for (int i = 0; i < num; i++){
            %>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            <%
        } 
    }
     %>

</table>

</fieldset>
</td>
<td id="td_emp" style="width:33%">
<fieldset>
<legend>Top 5 逾期人员名单</legend>

<table>
<%
    if (dtEmp.Rows.size() > 0){
        for(DataRow row: dtEmp.Rows){
        %>
            <tr>
                <td><%=row.get("Name")%></td>
                <td><%=row.get("Num")%></td>
            </tr>
        <%
        }
    }else{ 
     %>   
        <tr>
            <td>都已完成</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
    <%
    }
        if (5 > dtEmp.Rows.size()){
        int num = 5 - dtEmp.Rows.size();
        for (int i = 0; i < num; i++){
            %>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
            <%
        } 
    }
     %>

</table>

</fieldset>


 </td>
</tr>
</table>
<br />
<table style="width:100%;">
<tr>
<th style="text-align:center"> 逾期信息统计 </th></tr>
</table>
<%
    StringBuilder sb = new StringBuilder();
    
    //获取逾期的流程统计信息
    int toTop = 0;
    int maxAvg = 0;
    for(DataRow it: dtFlow.Rows){ 
        //生成数据集
        sb.append("<set label='" + it.get("Name") + "' value='" + it.get("Num") + "' />");
       //System.out.println(it.get("Num"));
       /*  if(it.get("Num")!=null){
        	maxAvg = it.get("Num");
        	
        } */
        
        if (maxAvg > toTop)
            toTop = maxAvg; 
    }
    sb.append("</chart>");

    toTop += 10;//y轴显示的最高值为获取的最大值+10.
    //设置柱状图的整体样式
    sb.insert(0, "<chart baseFontSize='12' subcaption='Top 5 逾期流程统计' formatNumberScale='0' divLineAlpha='20'" +
                               " divLineColor='CC3300' alternateHGridColor='CC3300' shadowAlpha='40'" +
                               " numvdivlines='9'  bgColor='FFFFFF,CC3300' bgAngle='270' bgAlpha='10,10'" +
                               " alternateHGridAlpha='5'   yAxisMaxValue ='" + toTop + "'>");
    //将数据集存储在一个隐藏控件中，方便JS读取值                          
    String hdValue = "{rowsCount:\"" + dtFlow.Rows.size() + "\",chartData:\"" + sb.toString() + "\"}";

    //获取逾期的部门统计信息
     toTop = 0;
     maxAvg = 0;
     sb = new StringBuilder();
     for (DataRow it: dtDept.Rows){
        //生成数据集
        sb.append("<set label='" + it.get("Name")+ "' value='" + it.get("Num") + "' />");
        //maxAvg = Integer.parseInt(it.get("Num").getValue());
        if (maxAvg > toTop)
            toTop = maxAvg;
    }
    sb.append("</chart>");
    toTop += 5;//y轴显示的最高值为获取的最大值+5.
    //设置柱状图的整体样式
    sb.insert(0, "<chart baseFontSize='12' subcaption='Top 5 逾期部门统计' formatNumberScale='0' divLineAlpha='20'" +
                               " divLineColor='CC3300' alternateHGridColor='CC3300' shadowAlpha='40'" +
                               " numvdivlines='9'  bgColor='FFFFFF,CC3300' bgAngle='270' bgAlpha='10,10'" +
                               " alternateHGridAlpha='5'   yAxisMaxValue ='" + toTop + "'>");
    //将数据集存储在一个隐藏控件中，方便JS读取值                          
    String hddeptValue = "{rowsCount:\"" + dtDept.Rows.size() + "\",chartData:\"" + sb.toString() + "\"}";

    //获取逾期的人员统计信息
    toTop = 0;
    maxAvg = 0;
    sb = new StringBuilder();
    for (DataRow it: dtEmp.Rows){
        //生成数据集
        sb.append("<set label='" + it.get("Name") + "' value='" + it.get("Num") + "' />");
       // maxAvg = Integer.parseInt(it.get("Num").toString());
        if (maxAvg > toTop)
            toTop = maxAvg;
    }
    sb.append("</chart>");

    toTop += 5;//y轴显示的最高值为获取的最大值+5.
    //设置柱状图的整体样式
    sb.insert(0, "<chart baseFontSize='12' subcaption='Top 5 逾期人员统计' formatNumberScale='0' divLineAlpha='20'" +
                               " divLineColor='CC3300' alternateHGridColor='CC3300' shadowAlpha='40'" +
                               " numvdivlines='9'  bgColor='FFFFFF,CC3300' bgAngle='270' bgAlpha='10,10'" +
                               " alternateHGridAlpha='5'   yAxisMaxValue ='" + toTop + "'>");
    //将数据集存储在一个隐藏控件中，方便JS读取值
    String hdempValue = "{rowsCount:\"" + dtEmp.Rows.size() + "\",chartData:\"" + sb.toString() + "\"}";
     %>
     <table>
        <tr>
            <td>
                <div id="fcDiv" style="width:100%;">
                </div>
            </td>
            <td>
                <div id="fcdept" style="width:100%;">
                </div>
            </td>
            <td>
                <div id="fcemp" style="width:100%;">
                </div>
            </td>
        </tr>
     </table>
<input type="hidden" id="hd" value="<%=hdValue %>"/>
<input type="hidden" id="hddept" value="<%=hddeptValue %>"/>
<input type="hidden" id="hdemp" value="<%=hdempValue %>"/>
   <script type="text/javascript">
    <%--    //显示逾期流程统计信息
       $(function () {
           var chartData = $("#<%=hd.ClientID%>").val(); //获取生成的数据集
           var data = eval('(' + chartData + ')');
           var w = $("#td_flow").css("width"); //设置显示图的宽度
           var chart; //调用柱状图显示器
           var chart = new FusionCharts("../../Comm/Charts/swf/Column3D.swf", "CharZ", w, '350', '0', '0');
           chart.setDataXML(data.chartData);
           chart.render("fcDiv"); //显示柱状图
       });
       //显示逾期部门统计信息
       $(function () {
           var chartData = $("#<%=hddept.ClientID%>").val(); //获取生成的数据集
           var data = eval('(' + chartData + ')');
           var w = $("#td_dept").css("width"); //设置显示图的宽度
           var chart; //调用柱状图显示器
           var chart = new FusionCharts("../../Comm/Charts/swf/Column3D.swf", "CharZ", w, '350', '0', '0');
           chart.setDataXML(data.chartData);
           chart.render("fcdept"); //显示柱状图
       });
       //显示逾期人员统计信息
       $(function () {
           var chartData = $("#<%=hdemp.ClientID%>").val(); //获取生成的数据集
           var data = eval('(' + chartData + ')');
           var w = $("#td_emp").css("width"); //设置显示图的宽度
           var chart; //调用柱状图显示器
           var chart = new FusionCharts("../../Comm/Charts/swf/Column3D.swf", "CharZ", w, '350', '0', '0');
           chart.setDataXML(data.chartData);
           chart.render("fcemp"); //显示柱状图
       }); --%>
    </script>
