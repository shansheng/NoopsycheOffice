<%@page import="BP.WF.Glo"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Template.FlowSorts"%>
<%@page import="BP.WF.Template.FlowSort"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@include file  = "/WF/head/head1.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发起</title>
<script type="text/javascript">
        function WinOpen(url) {
            var newWindow = window.open(url, 'z',
             'scroll:1;status:1;help:1;resizable:1;dialogWidth:680px;dialogHeight:420px');
            newWindow.focus();
            return;
        }
    </script>
</head>
<body>
	<form id="form1" runat="server">
    <table width='90%' align=left >
    <caption>
    <div style='float:left'><img src='/WF/Img/Search.gif' />流程查询/分析</div>
    <div style='float:right'><a href="javascript:WinOpen('<%=Glo.getCCFlowAppPath() %>WF/KeySearch.jsp',900,900);">关键字查询</a>
    <a href="javascript:WinOpen('<%=Glo.getCCFlowAppPath() %>WF/Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews',900,900);">综合查询</a>|
    <a href="javascript:WinOpen('<%=Glo.getCCFlowAppPath() %>WF/Rpt/Group.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews',900,900); ">综合分析</a>|
    <a href="javascript:WinOpen('<%=Glo.getCCFlowAppPath() %>WF/Comm/Search.jsp?EnsName=BP.WF.WorkFlowDeleteLogs',900,900); ">删除日志</a></div>
    
    </caption>
    <tr>
    <th>序</th>
    <th>流程名称</th>
    <th>流程查询-分析</th>
    </tr>
<%
            int colspan = 5;
            String sql = "";
            BP.WF.Flows fls = new BP.WF.Flows();
            fls.RetrieveAll();
            BP.WF.Template.FlowSorts fss = new BP.WF.Template.FlowSorts();
            fss.RetrieveAll();
            int idx = 0;
            int gIdx = 0;
            
            for(FlowSort fs : fss.ToJavaListFs())
            {
                if (fs.getParentNo() == "0" 
                    || fs.getParentNo()=="" 
                    || fs.getNo()=="0" )
                    continue;
                gIdx++;
                
            %>
            <tr>
            <th colspan=5><%=fs.getName() %></th>
            </tr>
            <%
            for(Flow fl : fls.ToJavaList())
                {
            	if (!fl.getFK_FlowSort().equals( fs.getNo()))
                        continue;
                    idx++;
                        %>
                        <tr>
                         <td class="Idx"> <%=idx %></td> 
                         <td ><%=fl.getName() %></td> 

                         <td>
                    <%
                    String src2 = BP.WF.Glo.getCCFlowAppPath() + "WF/Rpt/Search.jsp?RptNo=ND" + Integer.parseInt(fl.getNo()) + "MyRpt&FK_Flow=" + fl.getNo();
                    
                    %>
                    <a href="javascript:WinOpen('<%=src2%>');" >查询</a>
                    <%    src2 = BP.WF.Glo.getCCFlowAppPath() + "WF/Rpt/Group.jsp?FK_Flow=" + fl.getNo() + "&DoType=Dept";
                    %>
                     <a href="javascript:WinOpen('<%=src2 %>');" >分析</a>
                     </td>
                     </tr>
                   <%
                }
            }
            %>
    </table>
</body>
</html>