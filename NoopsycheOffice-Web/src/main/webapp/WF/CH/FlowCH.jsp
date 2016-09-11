<%@page import="java.text.SimpleDateFormat"%>
<%@page import="BP.Tools.StringHelper"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="cn.jflow.model.ch.FlowCHModel"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%  FlowCHModel flowCHModel = new FlowCHModel(request, response);
	String empChartStr = flowCHModel.empChart();
	String deptChartStr = flowCHModel.deptChart();
	String allDeptChartStr = flowCHModel.allDeptChart();
%>
<!DOCTYPE HTML>
<html >
<head >
    <title>流程考核</title>
    <link href="../Scripts/jquery/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../Scripts/jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <link href="../Comm/Charts/css/style_3.css" rel="stylesheet" type="text/css" />
    <link href="../Comm/Charts/css/prettify.css" rel="stylesheet" type="text/css" />
    <link href="../Comm/Charts/css/Style.css" rel="stylesheet" type="text/css" />
    <script src="../Comm/Charts/js/json2_3.js" type="text/javascript"></script>
    <script src="../Comm/Charts/js/FusionCharts.js" type="text/javascript"></script>
    <link href="css/flowch.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            //加载图形
            loadEmpChart();
            loadDeptChart();
            loadAllDeptChart();
        });
        //加载我的工作第一个图形
        function loadEmpChart() {
		    	var pushData=<%=empChartStr%>;
                var chart = new FusionCharts("../Comm/Charts/MSLine.swf", "CharZ", '850', '350', '0', '0');
                chart.setDataXML(pushData.set_XML[0]);
                chart.render("empChart");
        }
        //我部门
        function loadDeptChart() {
                var pushData = pushData=<%=deptChartStr%>;
                var chart = new FusionCharts("../Comm/Charts/MSLine.swf", "CharZ", '850', '350', '0', '0');
                chart.setDataXML(pushData.set_XML[0]);
                chart.render("deptChart");
        }
        //全单位
        function loadAllDeptChart() {
        	    var pushData = pushData=<%=allDeptChartStr%>;
                var chart = new FusionCharts("../Comm/Charts/MSLine.swf", "CharZ", '850', '350', '0', '0');
                chart.setDataXML(pushData.set_XML[0]);
                chart.render("allDeptChart");
        }
    </script>
</head>
<body>
    <div class="main">
        <div class="main_top_left">
            <div class="main_top_left_info"> 我的总体工作效率</div>
            <ul>
                <%
                   String sql = "";
                   BP.DA.DataTable dt = new BP.DA.DataTable();
                    
                    sql = "SELECT * FROM V_TOTALCH WHERE FK_Emp='" + WebUser.getNo() + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);
                    int totalGzzs = 0;   //总数.
                    int totalAswc = 0;   //按时完成
                    int totalCswc = 0;   //超时完成(逾期和超期之和)
                    if (dt.Rows.size() != 0)
                    {
                        totalGzzs = Integer.parseInt(dt.Rows.get(0).getValue("AllNum").toString());
                        totalAswc = Integer.parseInt(dt.Rows.get(0).getValue("ASNum").toString());
                        totalCswc = Integer.parseInt(dt.Rows.get(0).getValue("CSNum").toString());
                    }

                    //求按时完率.
                    double totalAswcl = 0;
                    double totalAswclStr = 0;
                    if (totalGzzs != 0)
                    {
                        totalAswcl = (double)totalAswc / totalGzzs * 100;//按时完成率
                        BigDecimal b = new BigDecimal(totalAswcl);  
                        totalAswclStr   =   b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();  
                    }

                    sql = "select * from V_TOTALCH	 ORDER BY WCRate desc";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    //根据按时(及时和按期)完成率计算排名，考虑按时完成率相同
                    int myTotalPm = 0;//默认排名
                    for(DataRow dr :dt.Rows)
                    {
                        myTotalPm += 1;
                        if (dr.getValue("FK_Emp").toString().equals(WebUser.getNo()))
                            break;
                    }

                    //OverMinutes小于0表明提前 
                    sql = "select sum(OverMinutes) from wf_ch where fk_emp='" + WebUser.getNo() + "' and OverMinutes <0";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    int totalZttq = 0;//总体提前
                    try
                    {
                        if (!StringHelper.isNullOrEmpty(dt.Rows.get(0).getValue(0).toString()))
                            totalZttq = -Integer.parseInt(dt.Rows.get(0).getValue(0).toString());
                    }
                    catch (Exception ex)
                    {
                    }

                    //OverMinutes大于0表明逾期
                    int totalZtyq = 0;
                    sql = "select sum(OverMinutes) from wf_ch where fk_emp='" + WebUser.getNo() + "' and OverMinutes >0";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    try
                    {
                        if (!StringHelper.isNullOrEmpty(dt.Rows.get(0).getValue(0).toString()))
                            totalZtyq = Integer.parseInt(dt.Rows.get(0).getValue(0).toString());
                    }
                    catch (Exception ex)
                    {
                    }

                    String totalJswc = "0";
                    String totalAqwc = "0";
                    String totalYqwc = "0";
                    String totalCqwc = "0";

                    sql = "SELECT JiShi,AnQi,YuQi,ChaoQi FROM V_TOTALCH WHERE FK_EMP='" + WebUser.getNo() + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    if (dt.Rows.size() != 0)
                    {
                        totalJswc =dt.Rows.get(0).getValue("JiShi").toString();
                        totalAqwc =dt.Rows.get(0).getValue("AnQi").toString();
                        totalYqwc =dt.Rows.get(0).getValue("YuQi").toString();
                        totalCqwc = dt.Rows.get(0).getValue("ChaoQi").toString();
                    }
                %>
                <li>工作总数<font class="greenFont"><%=totalGzzs%></font>,按时完成<font class="greenFont"><%=totalAswc%></font>个,</li>
                <li style="list-style: none;">超时完成<font class="redFont"><%=totalCswc%></font>个,按时完成率:<font class="redFont"><%=totalAswclStr%>%</font></li>
                <li>总体排名:第<font class="redFont"><%=myTotalPm %></font>名</li>
                <li>总体提前:<font class="greenFont"><%=totalZttq %></font>分钟</li>
                <li>总体逾期:<font class="redFont"><%=totalZtyq%></font>分钟</li>
                <li>及时完成<font class="greenFont"><%=totalJswc %></font>条</li>
                <li>按期完成<font class="greenFont"><%=totalAqwc%></font>条</li>
                <li>逾期完成<font class="redFont"><%=totalYqwc%></font>条</li>
                <li>超期完成<font class="redFont"><%=totalCqwc%></font>条</li>
            </ul>
        </div>
        <div class="main_top_right">
            <div class="main_top_right_info">
                我的上周工作效率
            </div>
            <ul>
                <%
                    Calendar cal=Calendar.getInstance();
				    cal.add(Calendar.WEEK_OF_YEAR,-1);
				 
                    //上一星期在本年的第几周
                    int lastWeekIndex = cal.get(Calendar.WEEK_OF_YEAR);
                    //上一星期隶属的年月
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                    
                    String lastFK_NY = sdf.format(cal.getTime());  

                    sql = "SELECT * FROM V_TOTALCHWeek WHERE FK_NY='" + lastFK_NY +
                         "' AND FK_Emp='" + WebUser.getNo() + "' AND WeekNum=" + lastWeekIndex;
                    dt = new BP.DA.DataTable();

                    int lastWeekGzzs = 0; //上周工作总数
                    int lastWeekAswc = 0;//按时完成
                    int lastWeekCswc = 0;//超时完成
                    if (dt.Rows.size() != 0)
                    {
                        lastWeekGzzs =Integer.parseInt(dt.Rows.get(0).getValue("AllNum").toString());
                        lastWeekAswc =Integer.parseInt(dt.Rows.get(0).getValue("ASNum").toString());
                        lastWeekCswc =Integer.parseInt(dt.Rows.get(0).getValue("CSNum").toString()); 
                    }

                    double lastWeekAswcl = 0;//按时完成率
                    double lastWeekAswclStr = 0;
                    if (lastWeekGzzs != 0)
                    {
                    	lastWeekAswcl = (double)lastWeekAswc / lastWeekGzzs * 100;//按时完成率
                        BigDecimal b = new BigDecimal(lastWeekAswcl);  
                        lastWeekAswclStr   =   b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                    }

                    //根据按时(及时,按期之和)完成率计算排名，考虑按时完成率相同
                    int lastWeekMypm = 0;//默认排名
                    sql = "SELECT * FROM V_TOTALCHWeek WHERE FK_NY='" + lastFK_NY +
                        "' AND  WeekNum=" + lastWeekIndex + " ORDER BY WCRate desc";

                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);
                    if(dt!=null)
                    {
                    for(DataRow weekDr :dt.Rows) 
                    {
                        lastWeekMypm += 1;
                        if (weekDr.getValue("FK_Emp").toString().equals( WebUser.getNo()))
                            break;
                    }
                    }

                    int lastWeekZttq = 0; //上周总体提前
                    sql = "select  sum(OverMinutes) from WF_CH where FK_Emp='" + WebUser.getNo()
                    + "' and WeekNum='" + lastWeekIndex + "' and OverMinutes<0 and FK_NY='" + lastFK_NY + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    try
                    {
                        if (!StringHelper.isNullOrEmpty(dt.Rows.get(0).getValue(0).toString()))
                            lastWeekZttq = -Integer.parseInt(dt.Rows.get(0).getValue(0).toString());
                    }
                    catch (Exception ex)
                    {
                    }


                    int lastWeekZtyq = 0;//上周总体逾期
                    sql = "select  sum(OverMinutes) from WF_CH where FK_Emp='" + WebUser.getNo()
                   + "' and WeekNum='" + lastWeekIndex + "' and OverMinutes>0 and FK_NY='" + lastFK_NY + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    try
                    {
                        if (!StringHelper.isNullOrEmpty(dt.Rows.get(0).getValue(0).toString()))
                            lastWeekZtyq = Integer.parseInt(dt.Rows.get(0).getValue(0).toString());
                    }
                    catch (Exception ex)
                    {
                    }

                    sql = "SELECT JiShi,AnQi,YuQi,ChaoQi FROM V_TOTALCHWeek WHERE FK_NY='" + lastFK_NY +
                        "' AND FK_Emp='" + WebUser.getNo() + "' AND WeekNum=" + lastWeekIndex;
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    String lastWeekJswc = "0";//及时完成
                    String lastWeekAqwc = "0";//按期完成
                    String lastWeekYqwc = "0";//逾期完成
                    String lastWeekCqwc = "0";//超期完成

                    if (dt.Rows.size() != 0)
                    {
                        lastWeekJswc = dt.Rows.get(0).getValue("JiShi").toString();
                        lastWeekAqwc = dt.Rows.get(0).getValue("AnQi").toString();
                        lastWeekYqwc = dt.Rows.get(0).getValue("YuQi").toString();
                        lastWeekCqwc = dt.Rows.get(0).getValue("ChaoQi").toString();
                    }
                %>
                <li>工作总数<font class="greenFont"><%=lastWeekGzzs%></font>,按时完成<font class="greenFont"><%=lastWeekAswc%></font>个,</li>
                <li style="list-style: none;">超时完成<font class="redFont"><%=lastWeekCswc%></font>个,按时完成率:<font class="redFont"><%=lastWeekAswclStr%>%</font></li>
                <li>总体排名:第<font class="redFont"><%=lastWeekMypm %></font>名</li>
                <li>提前完成时间:<font class="greenFont"><%=lastWeekZttq %></font>分钟</li>
                <li>逾期完成时间:<font class="redFont"><%=lastWeekZtyq%></font>分钟</li>
                <li>及时完成<font class="greenFont"><%=lastWeekJswc %></font>条</li>
                <li>按期完成<font class="greenFont"><%=lastWeekAqwc%></font>条</li>
                <li>逾期完成<font class="redFont"><%=lastWeekYqwc%></font>条</li>
                <li>超期完成<font class="redFont"><%=lastWeekCqwc%></font>条</li>
            </ul>
        </div>
        <div class="main_center_left">
            <div class="main_center_left_info">
                我的上月工作效率
            </div>
            <ul>
                <%
                    cal=Calendar.getInstance();
                
                    cal.add(Calendar.MONTH,-1);//上个月
                    
                    sdf = new SimpleDateFormat("yyyy-MM");
    				String lastMonthFK_NY=sdf.format(cal.getTime());    

                    
                    sql = "SELECT * FROM V_TOTALCHYF WHERE FK_Emp='" + WebUser.getNo() + "' AND FK_NY='" + lastMonthFK_NY + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    int lastMouthGzzs = 0;//上月总的工作
                    int lastMouthAswc = 0;//按时完成
                    int lastMouthCswc = 0;//超时完成
                    if (dt.Rows.size() != 0)
                    {
                        lastMouthGzzs =Integer.parseInt(dt.Rows.get(0).getValue("AllNum").toString());
                        lastMouthAswc =Integer.parseInt(dt.Rows.get(0).getValue("ASNum").toString());
                        lastMouthCswc =Integer.parseInt(dt.Rows.get(0).getValue("CSNum").toString());
                    }

                    double lastMouthAswcl = 0;
                    double lastMouthAswclStr = 0;
                    try
                    {
                        if (lastMouthGzzs != 0)
                        { 
                        	lastMouthAswcl = (double)lastMouthAswc / lastMouthGzzs * 100;//按时完成率
                            BigDecimal b = new BigDecimal(lastMouthAswcl);  
                            lastMouthAswclStr   =   b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                        }
                    }
                    catch (Exception ex)
                    {
                    }


                    //计算总体排名
                    sql = "select  FK_Emp from V_TOTALCHYF where "
                      + " FK_NY='" + lastFK_NY + "' ORDER BY WCRate desc";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    int lastMouthMypm = 0;//默认为第一名

                    for (DataRow mouthDr : dt.Rows)
                    {
                        lastMouthMypm += 1;
                        if (mouthDr.getValue("FK_Emp").equals(WebUser.getNo()))
                            break;
                    }

                    sql = "select  sum(OverMinutes) from WF_CH where FK_Emp='" + WebUser.getNo()
                        + "' and FK_NY='" + lastFK_NY + "' and OverMinutes<0";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    int lastMouthZttq = 0;//上月提前完成
                    try
                    {
                        lastMouthZttq = -Integer.parseInt(dt.Rows.get(0).getValue(0).toString());
                    }
                    catch (Exception ex)
                    {
                    }

                    sql = "select  sum(OverMinutes) from WF_CH where FK_Emp='" + WebUser.getNo()
                       + "' and FK_NY='" + lastFK_NY + "' and OverMinutes>0";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    int lastMouthZtyq = 0; //上月逾期完成

                    try
                    {
                        lastMouthZtyq =Integer.parseInt(dt.Rows.get(0).getValue(0).toString()) ;
                    }
                    catch (Exception ex)
                    {
                    }

                    sql = "SELECT JiShi,AnQi,YuQi,ChaoQi FROM V_TOTALCHYF WHERE FK_Emp='" + WebUser.getNo() + "' AND FK_NY='" + lastFK_NY + "'";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    String lastMouthJswc = "0";//上月及时完成
                    String lastMouthAqwc = "0";//上月按期完成
                    String lastMouthYqwc = "0";//上月逾期完成
                    String lastMouthCqwc = "0";//上月超期完成

                    if (dt.Rows.size() != 0)
                    {
                        lastMouthJswc = dt.Rows.get(0).getValue("JiShi").toString();
                        lastMouthAqwc = dt.Rows.get(0).getValue("AnQi").toString() ;
                        lastMouthYqwc = dt.Rows.get(0).getValue("YuQi").toString();
                        lastMouthCqwc = dt.Rows.get(0).getValue("ChaoQi").toString();
                    }
                %>
                <li>工作总数<font class="greenFont"><%=lastMouthGzzs%></font>,按时完成<font class="greenFont"><%=lastMouthAswc%></font>个,</li>
                <li style="list-style: none;">超时完成<font class="redFont"><%=lastMouthCswc%></font>个,按时完成率:<font class="redFont"><%=lastMouthAswclStr%>%</font></li>
                <li>总体排名:第<font class="redFont"><%=lastMouthMypm %></font>名</li>
                <li>提前完成时间:<font class="greenFont"><%=lastMouthZttq %></font>分钟</li>
                <li>逾期完成时间:<font class="redFont"><%=lastMouthZtyq%></font>分钟</li>
                <li>及时完成<font class="greenFont"><%=lastMouthJswc %></font>条</li>
                <li>按期完成<font class="greenFont"><%=lastMouthAqwc%></font>条</li>
                <li>逾期完成<font class="redFont"><%=lastMouthYqwc%></font>条</li>
                <li>超期完成<font class="redFont"><%=lastMouthCqwc%></font>条</li>
            </ul>
        </div>
        <div class="main_center_right">
            <div class="main_center_right_info">
                按期完成率总体排名
            </div>
            <ul>
                <%
                    sql = "SELECT FK_Emp FROM V_TOTALCH ORDER BY WCRate DESC";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    String totalHtml = "";
                    int rowCount = 0;
                    for (int i = 0; i < dt.Rows.size(); i++)
                    {

                        BP.GPM.Emp e = new BP.GPM.Emp(dt.Rows.get(i).getValue("FK_Emp").toString());

                        int num = i + 1;
                        if (i == 8)
                            break;
                        if (num <= 3)
                        {
                            totalHtml += "<li>第<font style='font-size:25px;color:Red;font-family:Vijaya;'>" + num + "</font>名:" + e.getName() + "</li>";
                        }
                        else
                        {
                            totalHtml += "<li>第" + num + "名:" + e.getName() + "</li>";
                        }
                        rowCount += 1;
                    }

                    for (int i = 1; i <= 8 - rowCount; i++)
                    {
                        totalHtml += "<li></li>";
                    }

                %>
                <%=totalHtml %>
            </ul>
        </div>
        <div class="main_bottom_left">
            <div class="main_bottom_left_info">
                按期完成率上周总体排名
            </div>
            <ul>
                <%
                    sql = "SELECT * FROM V_TOTALCHWeek WHERE FK_NY='" + lastFK_NY +
                         "' AND  WeekNum=" + lastWeekIndex + " ORDER BY WCRate DESC";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    cal=Calendar.getInstance();
    			    
    				cal.add(Calendar.WEEK_OF_YEAR,-2);//上上周
    				
    				sdf = new SimpleDateFormat("yyyy-MM-dd");
    				String llWeek=sdf.format(cal.getTime());


                    rowCount = 0;
                    String lastWeekHtml = "";
                    for (int i = 0; i < dt.Rows.size(); i++)
                    {
                        if (rowCount == 8)
                            break;

                        BP.GPM.Emp e = new BP.GPM.Emp(dt.Rows.get(i).getValue("FK_Emp").toString());

                        String str = "同比<img style='margin:0px 10px;' src='images/down.png' />";//下降


                        int llWeekIndex = cal.get(Calendar.WEEK_OF_YEAR);
                        
                        sdf = new SimpleDateFormat("yyyy-MM");
        				String llFK_NY=sdf.format(cal.getTime());  
                        
                        sql = "SELECT * FROM V_TOTALCHWeek WHERE FK_NY='" + llFK_NY +
                   "' AND  WeekNum=" + llWeekIndex + " AND FK_Emp='" + e.getNo() + "'";

                       BP.DA.DataTable llDt = new BP.DA.DataTable();

                        llDt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                        float lWCRate = 0;
                        float tb = 0;
                        String tbStr = "";
                        try
                        {
                            lWCRate =  Float.parseFloat(dt.Rows.get(i).getValue("WCRate").toString());
                            tb = (Float.parseFloat(dt.Rows.get(0).getValue("ASNum").toString())  - Float.parseFloat(llDt.Rows.get(0).getValue("ASNum").toString())) / 
                            		Float.parseFloat(llDt.Rows.get(0).getValue("AllNum").toString()) * 100;
                        }
                        catch (Exception ex)
                        {
                        }
                        
                        		
                        tbStr =  Math.abs(tb) + "%";

                        if (tb > 0)//上升   
                        {
                            str = "同比<img style='margin:0px 10px;' src='images/up.png' />";
                            tbStr =  tb + "%";
                        }

                        if (tb == 0)
                        {
                            str = "";
                            tbStr = "-幅度不变";
                        }

                        lastWeekHtml += "<li>" + e.getName() + "-" + lWCRate + "%" + str + tbStr + "</li>";
                        rowCount += 1;
                    }

                    for (int i = 1; i <= 8 - rowCount; i++)
                    {
                        lastWeekHtml += "<li></li>";
                    }
                %>
                <%=lastWeekHtml%>
            </ul>
        </div>
        <div class="main_bottom_right">
            <div class="main_bottom_right_info">
                按期完成率上月总体排名
            </div>
            <ul>
                <%
                    cal=Calendar.getInstance();
                
                    cal.add(Calendar.MONTH,-2);//上个月
                
                    sdf = new SimpleDateFormat("yyyy-MM");
				    String llFK_NY=sdf.format(cal.getTime());  
				    
                  
                    sql = "SELECT * FROM V_TOTALCHYF WHERE FK_NY='" + lastFK_NY +
                              "'  ORDER BY WCRate DESC";
                    dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                    rowCount = 0;
                    String lastMouthHtml = "";
                    for (int i = 0; i < dt.Rows.size(); i++)
                    {
                        if (rowCount == 8)
                            break;

                        BP.GPM.Emp e = new BP.GPM.Emp(dt.Rows.get(i).getValue("FK_Emp").toString());

                        sql = "SELECT * FROM V_TOTALCHWeek WHERE FK_NY='" + llFK_NY +
                   "' AND  FK_Emp='" + e.getNo() + "'";

                        BP.DA.DataTable llDt = new BP.DA.DataTable();

                        llDt = BP.DA.DBAccess.RunSQLReturnTable(sql);

                        float lWCRate = 0;
                        float tb = 0;
                        String tbStr = "";
                        try
                        {
                        	lWCRate =  Float.parseFloat(dt.Rows.get(i).getValue("WCRate").toString());
                             tb = (Float.parseFloat(dt.Rows.get(0).getValue("ASNum").toString())  - Float.parseFloat(llDt.Rows.get(0).getValue("ASNum").toString())) / 
                             		Float.parseFloat(llDt.Rows.get(0).getValue("AllNum").toString()) * 100;
                        }
                        catch (Exception ex)
                        {
                        }

                        String str = "同比<img style='margin:0px 10px;' src='images/down.png' />";//下降

                        tbStr = Math.abs(tb) + "%";
                        
                        if (tb > 0)//上升   
                        {
                            str = "同比<img style='margin:0px 10px;' src='images/up.png' />";
                            tbStr = tb + "%";
                        }

                        if (tb == 0)
                        {
                            str = "";
                            tbStr = "-幅度不变";
                        }

                        lastMouthHtml += "<li>" + e.getName() + "-" + lWCRate + "%" + str + tbStr + "</li>";
                        rowCount += 1;
                    }

                    for (int i = 1; i <= 8 - rowCount; i++)
                    {
                        lastMouthHtml += "<li></li>";
                    }
                    
                %>
                <%=lastMouthHtml %>
            </ul>
        </div>
        <div class="myworkbgPho">
            <div class="myworkmaintitle">
                我的工作(最近一个月)
            </div>
        </div>
        <div class="mywork_top">
            <div class="mywork_top_info">
                趋势图(按数量)
            </div>
            <div class="mywork_top_chart" id="empChart">
            </div>
        </div>
        <div class="deptworkbgPho">
            <div class="deptworktitle">
                我部门(最近一个月)
            </div>
        </div>
        <div class="deptwork_top">
            <div class="deptwork_top_info">
                趋势图(按数量)
            </div>
            <div class="deptwork_top_chart" id="deptChart">
            </div>
        </div>
        <div class="alldeptbgPho">
            <div class="alldeptworktitle">
                全单位(最近一个月)
            </div>
        </div>
        <div class="alldeptwork_top">
            <div class="alldeptwork_top_info">
                趋势图(按数量)
            </div>
            <div class="alldeptwork_top_chart" id="allDeptChart">
            </div>
        </div>
    </div>
</body>
</html>
