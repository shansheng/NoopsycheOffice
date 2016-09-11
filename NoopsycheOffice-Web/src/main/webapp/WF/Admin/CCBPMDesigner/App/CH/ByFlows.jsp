<%@page import="java.math.BigDecimal"%>
<%@page import="org.apache.commons.beanutils.converters.BigDecimalConverter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="BP.DA.*"%>
<%@ include file="/WF/head/head1.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link href="../../../../Scripts/jquery/themes/default/easyui.css" rel="stylesheet"
        type="text/css" />
    <link href="../../../../Scripts/jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../../../../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../../../../Scripts/jquery/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../../../../Scripts/CommonUnite.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
        }
        .center
        {
            text-align: center;
        }
        .flowTitle div
        {
            cursor: pointer;
            width: 200px;
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
</head>
<body>
 <table style="width: 100%;">
        <caption>
            按流程分析</caption>
        <tr>
            <th class="GroupTitle" rowspan="2">
                IDX
            </th>
            <th rowspan="2">
                流程名称
            </th>
            <th rowspan="2">
                发起总数
            </th>
            <th colspan="2">
                时效统计(单位:分钟)
            </th>
            <th colspan="5">
                状态分布
            </th>
            <th colspan="3">
                上月
            </th>
            <th colspan="3">
                本月
            </th>
            <th rowspan="2">
                详细
            </th>
        </tr>
        <tr>
            <th>
                节省
            </th>
            <th>
                逾期时间
            </th>
            <th>
                及时
            </th>
            <th>
                按期
            </th>
            <th>
                逾期
            </th>
            <th>
                超期
            </th>
            <th>
                按期办结率
            </th>

            <th>按期</th>
            <th>逾期</th>
            <th>按期办结率</th>


            <th>按期</th>
            <th>逾期</th>
            <th>按期办结率</th>

        </tr>
        <%
            //类别.
            BP.WF.Template.FlowSorts flowSorts = new BP.WF.Template.FlowSorts();
            flowSorts.RetrieveAll();

            //流程.
            BP.WF.Flows flows = new BP.WF.Flows();
            flows.RetrieveAll();

            // 获得流程总量.
            BP.DA.DataTable dt
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow, COUNT(WorkID) as Num FROM WF_GenerWorkFlow WHERE WFState!=0 GROUP BY FK_Flow ");


            // 获得节省时间
           BP.DA.DataTable dtSaveTimeMin
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow, SUM(OverMinutes) AS OverMinutes FROM WF_CH WHERE OverMinutes <0 GROUP BY FK_Flow ");

            // 获得超期时间
            BP.DA.DataTable dtOverTimeMin
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow, SUM(OverMinutes) AS OverMinutes FROM WF_CH WHERE OverMinutes > 0 GROUP BY FK_Flow  ");

            //及时完成
           BP.DA.DataTable dtInTimeCount
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE CHSta='" +
                     							BP.WF.Data.CHSta.JiShi.getValue() + "' GROUP BY FK_Flow ");

            //按期完成
            BP.DA.DataTable dtOnTimeCount
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE CHSta='" +
                                               BP.WF.Data.CHSta.AnQi.getValue() + "' GROUP BY FK_Flow ");
           
            // 获得逾期的工作数量.
            BP.DA.DataTable dtOverTimeCount
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE CHSta='" +
                                               BP.WF.Data.CHSta.YuQi.getValue() + "' GROUP BY FK_Flow ");

            // 获得超期的工作数量.
            BP.DA.DataTable dtCqTimeCount
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE CHSta='" +
                                               BP.WF.Data.CHSta.ChaoQi.getValue() + "' GROUP BY FK_Flow  ");

            //上月办结率
            DataType dTime = new DataType();
            //总数
           BP.DA.DataTable dtLastMouthTotal = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT(distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
              	String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM") + "' GROUP BY FK_Flow ");

            //按时
            BP.DA.DataTable dtLastMouthBJ = BP.DA.DBAccess.RunSQLReturnTable("SELECT  FK_Flow,COUNT(distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
                String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM")+ "' AND CHSta IN(0,1) GROUP BY FK_Flow ");
           // #region //上月按期完成/预期完成

            //上月按期完成
            BP.DA.DataTable dtListOnTimeCount
          
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            	String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM") + "'AND  CHSta='" +
                                               BP.WF.Data.CHSta.AnQi.getValue() + "' GROUP BY FK_Flow ");
          //上月预期
            BP.DA.DataTable dtListOverTimeCount
             = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            		 String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM") + "' AND CHSta='" +
                                               BP.WF.Data.CHSta.YuQi.getValue() + "' GROUP BY FK_Flow ");
                                               
         //本月按期完成
            BP.DA.DataTable dtThisOnTimeCount
               = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            		 String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM")+ "'AND  CHSta='" +
                                                 BP.WF.Data.CHSta.AnQi.getValue() + "' GROUP BY FK_Flow ");
         //本月预期完成
            BP.DA.DataTable dtThisOverTimeCount
               = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT( distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            		  String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM")+ " 'AND CHSta='" +
                                                 BP.WF.Data.CHSta.YuQi.getValue() + "' GROUP BY FK_Flow ");
         
            //本月办结率
            //总数
            BP.DA.DataTable dtThisMouthTotal = BP.DA.DBAccess.RunSQLReturnTable("SELECT FK_Flow,COUNT(distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            		String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM") + "' GROUP BY FK_Flow ");

            //按时
            BP.DA.DataTable dtThisMouthBJ = BP.DA.DBAccess.RunSQLReturnTable("SELECT  FK_Flow,COUNT(distinct WorkID) Num FROM WF_CH WHERE FK_NY ='" +
            		String.format(dTime.getCurrentNYOfPrevious(), "yyyy-MM") + "' AND CHSta IN(0,1) GROUP BY FK_Flow ");


            for(BP.WF.Template.FlowSort flowSort : flowSorts.ToJavaListFs())
            {
        %>
        <tr>
            <th>
            </th>
            <th class="GroupField" colspan="23">
                <%=flowSort.getName()%>
            </th>
        </tr>
        <% int idx = 0;
           for(BP.WF.Flow flow : flows.ToJavaList())
           {   
               if (flow.getFK_FlowSort().equals(flowSort.getNo()))
            	   idx += 1;
               else{
                   continue; //非该类别下的流程.
                   }
               
               //求发起总数.
               int relNum = 0;
               for(BP.DA.DataRow dr : dt.Rows)
               {    
            	   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {     
	                       relNum = Integer.parseInt(dr.getValue(1).toString());
	                       break;
                   }
               }
               

               //求提前完成的分钟数.
               long saveMinte = 0;
               for(BP.DA.DataRow dr:dtSaveTimeMin.Rows)
               {           	  
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                       saveMinte = Integer.parseInt(dr.getValue(1).toString());
	                    else{
	                    	break; 
	                   }
	                   
               }
            	   
               


               //求提 逾期的 分钟数.
               long overMinte = 0;
               for(BP.DA.DataRow dr:dtOverTimeMin.Rows)
               {
                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
                   {
                       overMinte = Long.parseLong(dr.getValue(1).toString());}
                   else{
	                  break; 
	                   }
            	  
               }

               //及时
               int inTimeCount = 0;
               for(BP.DA.DataRow dr:dtInTimeCount.Rows)
               {           	
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       inTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }
                   
               }

               //按时
               int onTimeCount = 0;
               for(BP.DA.DataRow dr:dtOnTimeCount.Rows)
               {  
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       onTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }
               }


               //上月按时
               int onListTimeCount = 0;
               for(BP.DA.DataRow dr:dtListOnTimeCount.Rows)
               {            	   
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       onListTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }                  
               }
               
               //本月按时
               int onThisTimeCount = 0;
               for(BP.DA.DataRow dr:dtThisOnTimeCount.Rows)
               {
            	   if(null!=dr.getValue("FK_Flow")){
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       onThisTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }
                   }
               }

               //逾期
               int yqTimeCount = 0;
               for(BP.DA.DataRow dr:dtOverTimeCount.Rows)
               {   	 
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       yqTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   } 
               }
               //本月逾期
               int yqThisTimeCount = 0;
               for(BP.DA.DataRow dr:dtThisOverTimeCount.Rows)
               { 	   
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       yqThisTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }
                   
               }

              //上月预期

               int yqListTimeCount = 0;
               for(BP.DA.DataRow dr:dtListOverTimeCount.Rows)
               {
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       yqListTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   } 
               }
               
               //超期
               int cqTimeCount = 0;
               for(BP.DA.DataRow dr:dtCqTimeCount.Rows)
               {
	                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
	                   {
	                       cqTimeCount = Integer.parseInt(dr.getValue(1).toString());
	                   }
               }

               //按期办结率
               int totalCount = inTimeCount + onTimeCount + yqTimeCount + cqTimeCount;
               long bjl = 0;
               if (totalCount != 0)
                   bjl = (inTimeCount + onTimeCount) * 100 / totalCount;


               //上月按时办结率
               long lastMouthBJL = 0;
               int lastMouthBJCount = 0;//办结
               int lastMouthTotalCount = 0;//总量

               for(BP.DA.DataRow dr:dtLastMouthBJ.Rows)
               {
                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
                   {
                       lastMouthBJCount = Integer.parseInt(dr.getValue(1).toString());
                       }
                   
               }

               for(BP.DA.DataRow dr:dtLastMouthTotal.Rows)
               {
                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
                   {
                       lastMouthTotalCount = Integer.parseInt(dr.getValue(1).toString());
                   }   
               }

               if (lastMouthTotalCount != 0)
               {
                   lastMouthBJL = lastMouthBJCount * 100 / lastMouthTotalCount;
               }
               
              
                   
               
               //本月按时办结率
               long thisMouthBJL = 0;
               int thisMouthBJCount = 0;//办结
               int thisMouthTotalCount = 0;//总量

               for(BP.DA.DataRow dr:dtThisMouthBJ.Rows)
               {
                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()))
                   {
                       thisMouthBJCount = Integer.parseInt(dr.getValue(1).toString());
			       }
                   
               }

               for(BP.DA.DataRow dr:dtThisMouthTotal.Rows)
               {
                   if (dr.getValue("FK_Flow").toString().equals(flow.getNo()));
                   {
                       thisMouthTotalCount = Integer.parseInt(dr.getValue(1).toString());
                   }
               }

               if (thisMouthTotalCount != 0)
                   thisMouthBJL = thisMouthBJCount * 100 / thisMouthTotalCount;
        %>
        <tr>
            <td class="Idx">
                <%=idx %>
            </td>
            <td >
            <a href="" >
                    <%=flow.getName()%> 
                    </a>
            </td>
            <td class="center">
                <%=relNum %>
            </td>
            <td class="center">
                <%=saveMinte%>
            </td>
            <td class="center">
                <%=overMinte%>
            </td>
            <td class="center">
                <%=inTimeCount%>
            </td>
            <td class="center">
                <%=onTimeCount%>
            </td>
            <td class="center">
                <%=yqTimeCount%>
            </td>
            <td class="center">
                <%=cqTimeCount%>
            </td>
            <td class="center">
                <%=bjl%>
            </td>

             <td class="center">
                <%=onListTimeCount %>
            </td>
            <td class="center">
                 <%=yqListTimeCount%>
            </td>
                <td class="center">
                  <%=thisMouthBJL%>
            </td>

            <td class="center" >
               <%=onThisTimeCount %>
            </td>
            <td  class="center"> <%=yqThisTimeCount %> </td>
            <td class="center">
                <%=lastMouthBJL%>
            </td>
        
            <!-- 链接到详细 -->
            <td class="center">
                <a href="../OneFlow/Nodes.jsp?FK_Flow=<%=flow.getNo() %>">详细</a>
            </td>
            </tr>

                <%
                }
            } 
            
                %>
        <%
            
            // 所有流程发起总数Total
            int relTotal = 0;
            for(BP.DA.DataRow dr: dt.Rows)
            {      
                    relTotal = Integer.parseInt(dr.getValue(1).toString());
                    break;
            }
            //求提前完成的分钟数Total.
            long saveMinteTotal = 0;
            for(BP.DA.DataRow dr : dtSaveTimeMin.Rows)
            {
                saveMinteTotal = Integer.parseInt(dr.getValue(1).toString());
                    break;
            }
            //求提 逾期的 分钟数Total.
            long overMinteTotal = 0;
            for(BP.DA.DataRow dr:dtOverTimeMin.Rows)
            {
            	overMinteTotal = Long.parseLong(dr.getValue(1).toString());
                    break;
                
            }
            //及时Total
            int inTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtCqTimeCount.Rows)
            {
                
                    inTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
              
            }

            //按时Total
            int onTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtOnTimeCount.Rows)
            {
                    onTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }


            //上月按时Total
            int onListTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtListOnTimeCount.Rows)
            {
                        
                    onListTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            //本月按时Total
            int onThisTimeCountTotal= 0;
            for(BP.DA.DataRow dr:dtThisOnTimeCount.Rows)
            {
              
                    onThisTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());

            }

            //逾期Total
            int yqTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtOverTimeCount.Rows)
            {
             
                    yqTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }
            //本月逾期Total
            int yqThisTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtThisOverTimeCount.Rows)
            {
               
                    yqThisTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            //上月预期Total

            int yqListTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtListOverTimeCount.Rows)
            {
               
                    yqListTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            //超期Total
            int cqTimeCountTotal = 0;
            for(BP.DA.DataRow dr:dtCqTimeCount.Rows)
            {
                    cqTimeCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            //按期办结率Total
            int totalCountTotal = inTimeCountTotal + onTimeCountTotal + yqTimeCountTotal + cqTimeCountTotal;
            long bjltotal = 0;
            if (totalCountTotal != 0)
                bjltotal = (inTimeCountTotal + onTimeCountTotal) * 100 / totalCountTotal;


            //上月按时办结率Total
            long lastMouthBJLTotal = 0;
            int lastMouthBJCountTotal = 0;//办结
            int lastMouthTotalCountTotal = 0;//总量

            for(BP.DA.DataRow dr:dtLastMouthBJ.Rows)
            {
               
                    lastMouthBJCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            for(BP.DA.DataRow dr:dtLastMouthTotal.Rows)
            {
                    lastMouthTotalCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            if (lastMouthTotalCountTotal != 0)
            {
                lastMouthBJLTotal = lastMouthBJCountTotal * 100 / lastMouthTotalCountTotal;
            }




            //本月按时办结率Total
            long thisMouthBJLTotal = 0;
            int thisMouthBJCountTotal = 0;//办结
            int thisMouthTotalCountTotal = 0;//总量

            for(BP.DA.DataRow dr:dtThisMouthBJ.Rows)
            {
   
                    thisMouthBJCountTotal = Integer.parseInt(dr.getValue(1).toString());

            }

            for(BP.DA.DataRow dr:dtThisMouthTotal.Rows)
            {
              
                    thisMouthTotalCountTotal = Integer.parseInt(dr.getValue(1).toString());
            }

            if (thisMouthTotalCountTotal != 0)
                thisMouthBJLTotal = thisMouthBJCountTotal * 100 / thisMouthTotalCountTotal;
            
              
        %>
          <tr class="flowTitle"  >
               <td class="center" colspan="2"   style=" font-size:15px; color:green" >合计 </td>
               <td class="center"><%=relTotal %></td>
              <td class="center"> <%=saveMinteTotal %> </td>
              <td class="center"> <%=overMinteTotal %> </td>
               <td class="center"> <%=inTimeCountTotal %> </td>
              <td class="center"> <%=onTimeCountTotal %> </td>
              <td class="center"> <%=yqTimeCountTotal %> </td>
              <td class="center"> <%=cqTimeCountTotal %> </td>
              <td class="center"> <%=totalCountTotal %></td>
              <td class="center"> <%=onListTimeCountTotal%> </td>
              <td class="center"> <%=yqListTimeCountTotal%> </td>
              <td class="center"> <%=lastMouthBJLTotal %> </td>
              <td class="center"> <%=onThisTimeCountTotal%> </td>
              <td class="center"> <%=yqThisTimeCountTotal%> </td>
              <td class="center"> <%=thisMouthBJLTotal%> </td>
                </tr>
       
          
    </table>
</body>
</html>