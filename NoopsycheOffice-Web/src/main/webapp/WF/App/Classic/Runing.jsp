<%@page import="BP.Tools.StringHelper"%>
<%@page import="BP.WF.Entity.GenerWorkFlowAttr"%>
<%@page import="BP.WF.WFState"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.DA.DataTable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在途</title>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./Comm/JScript.js"></script>
    <script type="text/javascript" >
        function Do(warning, url) {
            if (window.confirm(warning) == false)
                return;

            window.location.href = url;
            // WinOpen(url);
        }
        function WinOpen(url) {
            //窗口最大化e
            var scrWidth = screen.availWidth;
            var scrHeight = screen.availHeight;
            var self = window.open(url, '_blank', "resizable=1,scrollbars=yes");
            self.moveTo(0, 0);
            self.resizeTo(scrWidth, scrHeight);
            self.focus();
            // var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
            // newWindow.focus();
            return;
        }
        // 撤销。
        function UnSend(appPath, pageID, fid, workid, fk_flow) {
            if (window.confirm('您确定要撤销本次发送吗？') == false)
                return;
            var url = appPath + 'WF/Do.jsp?DoType=UnSend&FID=' + fid + '&WorkID=' + workid + '&FK_Flow=' + fk_flow + '&PageID=' + pageID;
            window.location.href = url;
            return;
        }
        function Press(appPath, fid, workid, fk_flow) {
            var url = appPath + 'WF/WorkOpt/Press.jsp?FID=' + fid + '&WorkID=' + workid + '&FK_Flow=' + fk_flow;
            var v = window.showModalDialog(url, 'sd', 'dialogHeight: 200px; dialogWidth: 350px;center: yes; help: no');
        }

        function GroupBarClick(appPath, rowIdx) {
            var alt = document.getElementById('Img' + rowIdx).alert;
            var sta = 'block';
            if (alt == 'Max') {
                sta = 'block';
                alt = 'Min';
            } else {
                sta = 'none';
                alt = 'Max';
            }

            document.getElementById('Img' + rowIdx).src = appPath + 'WF/Img/' + alt + '.gif';
            document.getElementById('Img' + rowIdx).alert = alt;
            var i = 0;
            for (i = 0; i <= 5000; i++) {
                if (document.getElementById(rowIdx + '_' + i) == null)
                    continue;
                if (sta == 'block') {
                    document.getElementById(rowIdx + '_' + i).style.display = '';
                } else {
                    document.getElementById(rowIdx + '_' + i).style.display = sta;
                }

            }
        }
    </script>
     <style type="text/css">
         table{ font: 12px 宋体, Arial, Verdana;}
        .TRSum{font: 12px 宋体, Arial, Verdana;}
        .centerTitle th{text-align:center;}
        .Idx{font-size: 16px;font-family: Vijaya;}
    </style>
</head>
<body>
 <%
        String GroupBy=request.getParameter("GroupBy");
        if(StringHelper.isNullOrEmpty(GroupBy))
        	GroupBy="FlowName";	      
 
        StringBuilder sBuilder = new StringBuilder();
        String runingHtml = "";
        DataTable dt;

        
        String fk_flow = request.getParameter("FK_Flow");
        
        if (StringHelper.isNullOrEmpty(fk_flow))
            dt = BP.WF.Dev2Interface.DB_GenerRuning();
        else
            dt = BP.WF.Dev2Interface.DB_GenerRuning(WebUser.getNo(), fk_flow);

        String appPath = Glo.getCCFlowAppPath();

        int colspan = 6;
        sBuilder.append("<table border=1px align=center width='100%'>");

        if (WebUser.getIsWap())
        {
            sBuilder.append("<Caption ><div class='CaptionMsg' >" + "<a href='Home.jsp' >Home</a>-<img src='"+appPath+"WF/Img/EmpWorks.gif' >在途工作" + "</div></Caption>");
        }
        else
        {
            sBuilder.append("<Caption ><div class='CaptionMsg' >在途工作</div></Caption>");
        }

        sBuilder.append("<tr class='centerTitle'>");
        sBuilder.append("<th class='Title'  nowrap=true >序</th>");
        sBuilder.append("<th class='Title'  nowrap=true width='40%'>标题</th>");

        if (!GroupBy.equals("FlowName"))
        {
            sBuilder.append("<th>" + "<a href='Runing.jsp?GroupBy=FlowName&FK_Flow=" + fk_flow + "' >流程</a>" + "</th>");
        }
        if (!GroupBy.equals("NodeName"))
        {
            sBuilder.append("<th>" + "<a href='Runing.jsp?GroupBy=NodeName&FK_Flow=" + fk_flow + "' >当前节点</a>" + "</th>");
        }

        if (!GroupBy.equals(GenerWorkFlowAttr.StarterName))
        {
            sBuilder.append("<th>" + "<a href='Runing.jsp?GroupBy=StarterName&FK_Flow=" + fk_flow + "' >发起人</a>" + "</th>");
        }

        sBuilder.append("<th class='Title'  nowrap=true >发起日期</th>");
        sBuilder.append("<th class='Title'  nowrap=true >操作</th>");
        sBuilder.append("</tr>");

        String groupVals = "";
        for (DataRow dr : dt.Rows)
        {
            if (groupVals.contains("@" +dr.getValue(GroupBy).toString()))
                continue;
            groupVals += "@" + dr.getValue(GroupBy);
        }

        int i = 0;
        boolean is1 = false;
        String title = null;
        String workid = null;
        fk_flow = null;
        int gIdx = 0;
        String[] gVals = groupVals.split("@");
        for (String g : gVals)
        {
            if (g.equals(""))
                continue;

            gIdx++;

            sBuilder.append("<tr>");
            sBuilder.append("<td " + "colspan=" + colspan + " class=TRSum onclick=\"GroupBarClick('" + appPath + "','" + gIdx + "')\" " + "><div style='text-align:left; float:left' ><img src='"+appPath+"WF/Img/Min.gif' alert='Min' id='Img" + gIdx + "'   border=0 />&nbsp;<b>" + g + "</b></td>");
            sBuilder.append("</tr>");

            for (DataRow dr : dt.Rows)
            {
                if (!dr.getValue(GroupBy).toString().equals(g))
                    continue;
                i++;

                if (is1)
                {
                    sBuilder.append("<TR bgcolor=AliceBlue " + "ID='" + gIdx + "_" + i + "'" + " >");
                }
                else
                {
                    sBuilder.append("<TR bgcolor=white " + "ID='" + gIdx + "_" + i + "'" + " class=TR>");
                }

                is1 = !is1;
                sBuilder.append("<td class='Idx' nowrap>" + i + "</td>");

                int wfstate = Integer.parseInt(dr.getValue("WFState").toString());
                title = "<img src='"+appPath+"WF/Img/PRI/" + wfstate + ".png' class='Icon' />" + dr.getValue("Title").toString();

                workid =dr.getValue("WorkID").toString();
                fk_flow =dr.getValue("FK_Flow").toString();

                sBuilder.append("<td class=TTD><a href=\"javascript:WinOpen('"+appPath+"WF/WFRpt.jsp?WorkID=" + workid + "&FK_Flow=" + fk_flow + "&FID=" +dr.getValue("FID") + "')\" >" + title + "</a></td>");
                if (!GroupBy.equals("FlowName"))
                {
                    sBuilder.append("<td  nowrap >" +dr.getValue("FlowName").toString() + "</td>");
                }

                if (!GroupBy.equals("NodeName"))
                {
                    sBuilder.append("<td  nowrap >" +dr.getValue("NodeName").toString()+ "</td>");
                }

                if (!GroupBy.equals(GenerWorkFlowAttr.StarterName))
                {
                    sBuilder.append("<td  nowrap >" +dr.getValue(GenerWorkFlowAttr.StarterName).toString()  + "</td>");
                }

                sBuilder.append("<td  nowrap >" +dr.getValue("RDT").toString() + "</td>");
                sBuilder.append("<td valign=top nowrap >");
                sBuilder.append("<a href=\"javascript:UnSend('" + appPath + "','','" +dr.getValue("FID") + "','" + workid + "','" + fk_flow + "');\" ><img src='"+appPath+"WF/Img/Action/UnSend.png' border=0 class=Icon />撤消</a>");
                sBuilder.append("&nbsp;&nbsp;<a href=\"javascript:Press('" + appPath + "','" + dr.getValue("FID") + "','" + workid + "','" + fk_flow + "');\" ><img src='"+appPath+"WF/Img/Action/Press.png' border=0 class=Icon />催办</a>");

                sBuilder.append("</td>");
                sBuilder.append("</tr>");
            }
        }
        sBuilder.append("</table>");
        runingHtml = sBuilder.toString();
    %>
    <%=runingHtml %>
</body>
</html>