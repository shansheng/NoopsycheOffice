<%@page import="java.util.Date"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.Tools.StringHelper"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%><html>
<head>
<title>草稿</title>
<script type="text/javascript">
        var NS4 = (document.layers);
        var IE4 = (document.all);
        var win = window;
        var n = 0;
        function findInPage(str) {

            alert(document.getElementById('string1'));
            str = document.getElementById('string1').value;
            //    alert(str);
            var txt, i, found;
            if (str == "")
                return false;
            if (NS4) {
                if (!win.find(str))
                    while (win.find(str, false, true))
                        n++;
                else
                    n++;
                if (n == 0)
                    alert("对不起！没有你要找的内容。");
            }
            if (IE4) {
                txt = win.document.body.createTextRange();
                for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) {
                    txt.moveStart("character", 1);
                    txt.moveEnd("textedit");
                }
                if (found) {
                    txt.moveStart("character", -1);
                    txt.findText(str);
                    txt.select();
                    txt.scrollIntoView();
                    n++;
                }
                else {
                    if (n > 0) {
                        n = 0;
                        findInPage(str);
                    }
                    else
                        alert("对不起！没有你要找的内容。");
                }
            }
            return false;
        }

        function SetImg(appPath, id) {
            document.getElementById(id).src = appPath + 'WF/Img/Mail_Read.png';
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
            var i = 0
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
        function WinOpenIt(url) {
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
    </script>
    <style type="text/css">
        table
        {
            font: 12px 宋体, Arial, Verdana;
        }
        .TRSum
        {
            font: 12px 宋体, Arial, Verdana;
        }
        .centerTitle th
        {
            text-align: center;
        }
        .Idx
        {
            font-size: 16px;
            font-family: Vijaya;
        }
    </style>
</head>
<body>
	<%
		String FK_Flow=request.getParameter("FK_Flow");
		String GroupBy =request.getParameter("GroupBy");
        GroupBy = "FlowName";

        DataTable dt = null;
        String timeKey;

        StringBuilder sBuilder = new StringBuilder();

        String empWorksHtml = "";

        timeKey = DataType.getCurrentDateByFormart("yyyyMMddHHmmss");
        FK_Flow=request.getParameter("FK_Flow");
        dt = BP.WF.Dev2Interface.DB_GenerDraftDataTable();

        String appPath = BP.WF.Glo.getCCFlowAppPath();//this.Request.ApplicationPath;
        String groupVals = "";
        for (DataRow dr : dt.Rows)
        {
            if (groupVals.contains("@" + dr.getValue(GroupBy).toString() + ","))
                continue;
            groupVals += "@" + dr.getValue(GroupBy).toString() + ",";
        }

        int colspan = 10;

        sBuilder.append("<table width='100%'  cellspacing='0' cellpadding='0' align=left>");
        sBuilder.append("<Caption ><div class='CaptionMsg' >草稿</div></Caption>");

        String extStr = "";

        sBuilder.append("<tr class='centerTitle'>");
        sBuilder.append("<th >ID</th>");
        sBuilder.append("<th class='Title' width=40% nowrap=true >标题</th>");
        sBuilder.append("<th  >流程</th>");
        sBuilder.append("<th >日期</th>");
        sBuilder.append("<th >备注</th>");
        sBuilder.append("</tr>");

        int i = 0;
        boolean is1 = false;
        Calendar cal = Calendar.getInstance();
        Date cdt = cal.getTime();
        String[] gVals = groupVals.split("@");
        int gIdx = 0;
        for (String g : gVals)
        {
            if (StringHelper.isNullOrEmpty(g))
                continue;
            gIdx++;
            sBuilder.append("<tr>");
            if ("Rec".equals(GroupBy))
            {
                sBuilder.append("<td colspan=" + colspan + " class=TRSum onclick=\"GroupBarClick('" + appPath + "','" + gIdx + "')\" " + " >" + "<div style='text-align:left; float:left' ><img src='../../Style/Min.gif' alert='Min' id='Img" + gIdx + "'   border=0 />&nbsp;<b>" + g.replace(",", "") + "</b>" + "</td>");
            }
            else
            {
                sBuilder.append("<td colspan=" + colspan + " class=TRSum onclick=\"GroupBarClick('" + appPath + "','" + gIdx + "')\" " + " >" + "<div style='text-align:left; float:left' ><img src='../../MapDef/Style/Min.gif' alert='Min' id='Img" + gIdx + "'   border=0 />&nbsp;<b>" + g.replace(",", "") + "</b>" + "</td>");
            }

            sBuilder.append("</tr>");

            for (DataRow dr : dt.Rows)
            {
                if (!(dr.getValue(GroupBy).toString() + ",").equals(g))
                    continue;

                if (is1)
                {
                    sBuilder.append("<tr bgcolor=AliceBlue " + "ID='" + gIdx + "_" + i + "'" + " >");
                }
                else
                {
                    sBuilder.append("<tr bgcolor=white " + "ID='" + gIdx + "_" + i + "'" + " class=TR>");
                }

                is1 = !is1;
                i++;

                sBuilder.append("<td class='Idx' nowrap>" + i + "</td>");
                if (BP.WF.Glo.getIsWinOpenEmpWorks())
                {
                    sBuilder.append("<td onclick=\"SetImg('" + appPath + "','I" + gIdx + "_" + i + "')\"" + " >" + "<a href=\"javascript:WinOpenIt('../../MyFlow.jsp?FK_Flow=" + dr.getValue("FK_Flow") + "&FID=0&WorkID=" + dr.getValue("WorkID") + "&IsRead=0&T=" + timeKey + "');\" ><img class=Icon align='middle'  src='../../Img/Mail_UnRead.png' id='I" + gIdx + "_" + i + "' />" + dr.getValue("Title").toString() + "</a>" + "</td>");
                }

                sBuilder.append("<td  nowrap >" + dr.getValue("FlowName").toString() + "</td>");

                sBuilder.append("<td  nowrap class='TBDate' >" + BP.DA.DataType.ParseSysDate2DateTimeFriendly(dr.getValue("RDT").toString()) + "</td>");

                sBuilder.append("<td  nowrap >" + dr.getValue("FlowNote").toString() + "</td>");
                sBuilder.append("</tr>");
            }
        }
        sBuilder.append("</table>");
        empWorksHtml = sBuilder.toString();
%>
    <%=empWorksHtml %>
</body>
</html>