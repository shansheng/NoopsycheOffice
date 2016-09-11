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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办</title>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../Comm/JScript.js" type="text/javascript"></script>
<script language="JavaScript" src="../../Comm/JS/Calendar/WdatePicker.js" defer="defer" type="text/javascript"></script>
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
            var self = window.open(url, '_blank', "resizable=1,scrollbars=yes");
            self.moveTo(0, 0);
            self.resizeTo(screen.availWidth, screen.availHeight);
            self.focus();
            // var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
            // newWindow.focus();
            return;
        }
        
        function ExitAuth(fk_emp) {
        	alert(111);
            var url = '<%=Glo.getCCFlowAppPath() %>WF/Do.jsp?DoType=ExitAuth&FK_Emp=' + fk_emp;
            WinShowModalDialog(url, '');
            window.location.href = '<%=Glo.getCCFlowAppPath() %>WF/App/Classic/Todolist.jsp';
        }
        function NoSubmit(fk_emp) {
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
        String FK_Flow=request.getParameter("FK_Flow");

        String HungUp =request.getParameter("IsHungUp");
        boolean IsHungUp = true;
        if (StringHelper.isNullOrEmpty(HungUp))
            IsHungUp = false;

        String GroupBy =request.getParameter("GroupBy");

        String DoType= request.getParameter("DoType");
        if (StringHelper.isNullOrEmpty(GroupBy))
        {
            if (DoType == "CC")
                GroupBy = "Rec";
            else
                GroupBy = "FlowName";
        }

        DataTable dt = null;
        String timeKey;

        StringBuilder sBuilder = new StringBuilder();

        String empWorksHtml = "";

      
		timeKey = DataType.getCurrentDateByFormart("yyyyMMddHHmmss");
		
        
        if (IsHungUp)
            dt = Dev2Interface.DB_GenerHungUpList();
        else
        {
            if (StringHelper.isNullOrEmpty(FK_Flow))
                dt = Dev2Interface.DB_GenerEmpWorksOfDataTable();
            else
                dt = Dev2Interface.DB_GenerEmpWorksOfDataTable(WebUser.getNo(), FK_Flow);
        }

        String appPath = Glo.getCCFlowAppPath();//this.Request.ApplicationPath;
        String groupVals = "";
        for (DataRow dr : dt.Rows)
        {
            if (groupVals.contains("@" +dr.getValue(GroupBy).toString() + ","))
                continue;
            groupVals += "@" +dr.getValue(GroupBy).toString()+ ",";
        }

        int colspan = 10;

        sBuilder.append("<table width='100%'  cellspacing='0' cellpadding='0' align=left>");
        sBuilder.append("<Caption ><div class='CaptionMsg' >待办</div></Caption>");

        String extStr = "";
        if (IsHungUp)
            extStr = "&IsHungUp=1";

        sBuilder.append("<tr class='centerTitle'>");
        sBuilder.append("<th >ID</th>");
        sBuilder.append("<th class='Title' width=40% nowrap=true >标题</th>");

        if (!GroupBy.equals("FlowName"))
        {
            sBuilder.append("<th >" + "<a href='Todolist.jsp?GroupBy=FlowName" + extStr + "&T=" + timeKey + "' >流程</a>" + "</th>");
        }

        if (!GroupBy.equals("NodeName"))
        {
            sBuilder.append("<th >" + "<a href='Todolist.jsp?GroupBy=NodeName" + extStr + "&T=" + timeKey + "' >节点</a>" + "</th>");
        }

        if (!GroupBy.equals("StarterName"))
        {
            sBuilder.append("<th >" + "<a href='Todolist.jsp?GroupBy=StarterName" + extStr + "&T=" + timeKey + "' >发起人</a>" + "</th>");
        }

        sBuilder.append("<th >" + "<a href='Todolist.jsp?GroupBy=PRI" + extStr + "&T=" + timeKey + "' >优先级</a>" + "</th>");

        sBuilder.append("<th >发起日期</th>");
        sBuilder.append("<th >接受日期</th>");
        sBuilder.append("<th >应完成日期</th>");
        sBuilder.append("<th >状态</th>");
        sBuilder.append("<th >备注</th>");
        sBuilder.append("</tr>");

        int i = 0;
        boolean is1 = false;
        Calendar  cal = Calendar.getInstance();
		Date cdt = cal.getTime();
        
       
        String[] gVals = groupVals.split("@");
        int gIdx = 0;
        for (String g : gVals)
        {
            if (StringHelper.isNullOrEmpty(g))
                continue;
            gIdx++;
            sBuilder.append("<tr>");
            if (GroupBy == "Rec")
            {
                sBuilder.append("<td colspan=" + colspan + " class=TRSum onclick=\"GroupBarClick('" + appPath + "','" + gIdx + "')\" " + " >" + "<div style='text-align:left; float:left' ><img src='"+appPath+"WF/Img/Min.gif' alert='Min' id='Img" + gIdx + "'   border=0 />&nbsp;<b>" + g.replace(",", "") + "</b>" + "</td>");
            }
            else
            {
                sBuilder.append("<td colspan=" + colspan + " class=TRSum onclick=\"GroupBarClick('" + appPath + "','" + gIdx + "')\" " + " >" + "<div style='text-align:left; float:left' ><img src='"+appPath+"WF/Img/Min.gif' alert='Min' id='Img" + gIdx + "'   border=0 />&nbsp;<b>" + g.replace(",", "") + "</b>" + "</td>");
            }

            sBuilder.append("</tr>");

            for (DataRow dr : dt.Rows)
            {
                if (!(dr.getValue(GroupBy).toString()+",").equals(g))
                    continue;
                String sdt = dr.getValue("SDT").toString();
                String paras =dr.getValue("AtPara").toString();

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
                int isRead =Integer.parseInt(dr.getValue("IsRead").toString());

                sBuilder.append("<td class='Idx' nowrap>" + i + "</td>");
                if (Glo.getIsWinOpenEmpWorks())
                {
                    if (isRead == 0)
                    {
                        sBuilder.append("<td onclick=\"SetImg('" + appPath + "','I" + gIdx + "_" + i + "')\"" + " >" + "<a href=\"javascript:WinOpenIt('"+appPath+"/WF/MyFlow.jsp?FK_Flow=" + dr.getValue("FK_Flow") + "&FK_Node=" +dr.getValue("FK_Node") + "&FID=" +dr.getValue("FID")  + "&WorkID=" +dr.getValue("WorkID") + "&IsRead=0&T=" + timeKey + "&Paras=" + paras + "');\" ><img class=Icon align='middle'  src='"+appPath+"WF/Img/Mail_UnRead.png' id='I" + gIdx + "_" + i + "' />" +dr.getValue("Title").toString() + "</a>" + "</td>");
                    }
                    else
                    {
                        sBuilder.append("<td  nowrap >" + "<a href=\"javascript:WinOpenIt('"+appPath+"/WF/MyFlow.jsp?FK_Flow=" + dr.getValue("FK_Flow") + "&FK_Node=" + dr.getValue("FK_Node") + "&FID=" + dr.getValue("FID") + "&WorkID=" + dr.getValue("WorkID") + "&Paras=" + paras + "&T=" + timeKey + "');\"  ><img src='"+appPath+"WF/Img/Mail_Read.png' id='I" + gIdx + "_" + i + "' class=Icon align='middle'  />" + dr.getValue("Title").toString() + "</a>" + "</td>");
                    }
                }
                else
                {
                    if (isRead == 0)
                    {
                        sBuilder.append("<td onclick=\"SetImg('" + appPath + "','I" + gIdx + "_" + i + "')\" " + " >" + "<a href=\""+appPath+"/WF/MyFlow.jsp?FK_Flow=" + dr.getValue("FK_Flow")+ "&FK_Node=" + dr.getValue("FK_Node")+ "&FID=" +  "&FID=" +dr.getValue("FID") + "&WorkID=" + dr.getValue("WorkID") + "&IsRead=0&Paras=" + paras + "&T=" + timeKey + "\" ><img class=Icon src='"+appPath+"WF/Img/Mail_UnRead.png' align='middle'  id='I" + gIdx + "_" + i + "' />" + dr.getValue("Title").toString() + "</a>" + "</td>");
                    }
                    else
                    {
                        sBuilder.append("<td  nowrap >" + "<a href=\""+appPath+"/WF/MyFlow.jsp?FK_Flow=" +dr.getValue("FK_Flow")+ "&FK_Node=" +  dr.getValue("FK_Node")+ "&FID=" +dr.getValue("FID") + "&WorkID=" +  dr.getValue("WorkID") + "&Paras=" + paras + "&T=" + timeKey + "\" ><img class=Icon src='"+appPath+"WF/Img/Mail_Read.png' align='middle'  id='I" + gIdx + "_" + i + "' />" + dr.getValue("Title").toString() + "</a>" + "</td>");
                    }
                }

                if (!GroupBy.equals("FlowName"))
                {
                    sBuilder.append("<td  nowrap >" +dr.getValue("FlowName").toString()  + "</td>");
                }
                if (!GroupBy.equals("NodeName"))
                {
                    sBuilder.append("<td  nowrap >" +dr.getValue("NodeName").toString()  + "</td>");
                }
                if (!GroupBy.equals("StarterName"))
                {
                    sBuilder.append("<td  nowrap >" + BP.WF.Glo.GenerUserImgSmallerHtml(dr.getValue("Starter").toString(),dr.getValue("StarterName").toString()) + "</td>");
                }
                sBuilder.append("<td  nowrap >" + "<img class=Icon src='"+appPath+"WF/Img/PRI/" +dr.getValue("PRI").toString()+ ".png' class=Icon />" + "</td>");

                sBuilder.append("<td  nowrap class='TBDate' >" +dr.getValue("RDT").toString().substring(5) + "</td>");
                sBuilder.append("<td  nowrap class='TBDate' >" +dr.getValue("ADT").toString().substring(5) + "</td>");
                sBuilder.append("<td  nowrap class='TBDate' >" +dr.getValue("SDT").toString().substring(5) + "</td>");

                Date  mysdt =  BP.DA.DataType.ParseSysDate2DateTime(sdt);
                
                if (cdt.compareTo(mysdt)>0)
                {
                	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    if (dateFormat.format(cdt).equals(dateFormat.format(mysdt)))
                    {
                        sBuilder.append("<td align=center nowrap >" + "<img src='"+appPath+"WF/Img/PRI/0.png' class='Icon'/><font color=green>正常</font>" + "</td>");
                    }
                    else
                    {
                        sBuilder.append("<td align=center nowrap >" + "<img src='"+appPath+"WF/Img/PRI/2.png' class='Icon'/><font color=red>逾期</font>" + "</td>");
                    }
                }
                else
                {
                    sBuilder.append("<td align=center nowrap >" + "<img src='"+appPath+"WF/Img/PRI/0.png'class='Icon'/>&nbsp;<font color=green>正常</font>" + "</td>");
                }

                sBuilder.append("<td  nowrap >" + dr.getValue("FlowNote").toString() + "</td>");
                sBuilder.append("</tr>");
            }
        }
        sBuilder.append("</table>");
        if (BP.Web.WebUser.getIsAuthorize()== true)
        {
        	sBuilder.append("<br><br><br><div style='float:right;' ><a href=\"javascript:ExitAuth('" + BP.Web.WebUser.getNo() + "')\" >退出授权登录模式返回(" + BP.Web.WebUser.getAuth() + ")的待办</a></div>");
        }
        else
        {
        	sBuilder.append("<br><br><br><div style='float:right;' ><a href=\"autotodolist.jsp\" >查看授权人的待办工作</a></div>");
        }
           
        empWorksHtml = sBuilder.toString();
    %>
    <%=empWorksHtml %>
</body>
</html>