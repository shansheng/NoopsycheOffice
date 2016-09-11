<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="BP.WF.Template.*"%>
<%@page import="BP.WF.*"%>
<%@page import="BP.DA.*"%>
<%@include file  = "/WF/head/head1.jsp" %>
<head>
</head>
<body>
<%
        String flowNo = request.getParameter("FK_Flow");
        BP.Sys.Frm.MapAttrs attrs = new BP.Sys.Frm.MapAttrs("ND" + Integer.parseInt(flowNo) + "Rpt");
    %>

    <table style="width: 100%">
        <caption>流程数据字段视图</caption>
        <tr>
            <th>序</th>
            <th>字段名</th>
            <th>字段中文名称</th>
            <th>最小长度</th>
            <th>最大长度</th>
            <th>业务类型</th>
            <th>其他</th>
        </tr>

        <tr>
            <th colspan="7">流程系统字段</th>
        </tr>

        <% 
        int idx1 = 0;
		for (BP.Sys.Frm.MapAttr item : attrs.ToJavaList())
		{
			if (item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.OID))
			{
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.AtPara)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.AtPara)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.BillNo)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FID)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FK_Dept)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FK_NY)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowDaySpan)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowEmps)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowEnder)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowEnderRDT)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowEndNode)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowNote)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowStarter)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.FlowStartRDT)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.GuestName)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.GuestNo)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.GUID)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.MyNum)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PEmp)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PFID)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PFlowNo)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PNodeID)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PrjName)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PrjNo)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.PWorkID)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.Title)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.WFSta)){
				idx1++;
			}else if(item.getKeyOfEn().equals(BP.WF.Data.GERptAttr.WFState)){
				idx1++;
			}else{
				continue;
			}
			//idx1++;
        %>
        <tr>
            <td class="Idx"><%=idx1 %> </td>
            <td><%=item.getKeyOfEn() %> </td>
            <td><%=item.getName() %>   </td>
            <td><%=item.getMinLen() %> </td>
            <td><%=item.getMaxLen() %> </td>
            <td><%=item.getMyDataTypeStr() %> </td>
            <td><%=item.getUIBindKey() %> </td>
        </tr>

        <%   
    }
        %>
        <tr>
        </tr>
        <tr>
            <th colspan="7">业务字段-普通字段</th>
        </tr>

        <% 
	        int idx2 = 0;
			for (BP.Sys.Frm.MapAttr item : attrs.ToJavaList())
			{
				if (item.getLGType().equals(BP.En.FieldTypeS.Normal))
				{
					idx2++;
				}else{
					continue;
				}
				//idx2++;
        %>
        <tr>
            <td class="Idx"><%=idx2 %> </td>
            <td><%=item.getKeyOfEn() %> </td>
            <td><%=item.getName() %>   </td>
            <td><%=item.getMinLen() %> </td>
            <td><%=item.getMaxLen() %> </td>
            <td><%=item.getMyDataTypeStr() %> </td>
            <td><%=item.getUIBindKey() %> </td>
        </tr>

        <%   
    }
        %>
        <tr>
        </tr>
        <tr>
            <th colspan="7">业务字段-枚举字段</th>
        </tr>

        <% 
	        int idx3 = 0;
			for (BP.Sys.Frm.MapAttr item : attrs.ToJavaList())
			{
				if (item.getLGType().equals(BP.En.FieldTypeS.Enum))
				{
					idx3++;
				}else{
					continue;
				}
				//idx3++;
        %>

        <tr>
            <td class="Idx"><%=idx3 %> </td>
            <td><%=item.getKeyOfEn() %> </td>
            <td><%=item.getName() %>   </td>
            <td><%=item.getMinLen() %> </td>
            <td><%=item.getMaxLen() %> </td>
            <td><%=item.getMyDataTypeStr() %> </td>
            <td><%=item.getUIBindKey() %> </td>
        </tr>

        <%   
    }
        %>
        <tr>
        </tr>


        <tr>
            <th colspan="7">业务字段-外键字段</th>
        </tr>

        <% 
	        int idx4 = 0;
			for (BP.Sys.Frm.MapAttr item : attrs.ToJavaList())
			{
				if (item.getLGType().equals(BP.En.FieldTypeS.FK))
				{
					idx4++;
				}else{
					continue;
				}
				//idx4++;
               
        %>

        <tr>
            <td class="Idx"><%=idx4 %> </td>
            <td><%=item.getKeyOfEn() %> </td>
            <td><%=item.getName() %>   </td>
            <td><%=item.getMinLen() %> </td>
            <td><%=item.getMaxLen() %> </td>
            <td><%=item.getMyDataTypeStr() %> </td>
            <td><%=item.getUIBindKey() %> </td>
        </tr>

        <%   
    }
        %>
        <tr>
        </tr>


        <tr>
            <th colspan="7">
                <div style="float: right">如果您想把该表的数据实时的同步到您指定的表，请执行【<a href="DTSBTable.jsp?FK_Flow=<%=flowNo %>">与业务数据表同步</a>】</div>
            </th>
        </tr>

    </table>
</body>