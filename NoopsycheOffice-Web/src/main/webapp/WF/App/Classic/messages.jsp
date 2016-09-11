<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="BP.WF.XML.MsgType" %>
<%@page import="BP.WF.XML.MsgTypes" %>
<%@page import="BP.WF.SMSs" %>
<%@page import="BP.WF.SMS" %>
<%@page import="BP.WF.SMSAttr" %>
<%@ include file="/WF/head/head1.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link href="<%=Glo.getCCFlowAppPath() %>Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="<%=Glo.getCCFlowAppPath() %>Scripts/easyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="<%=Glo.getCCFlowAppPath() %>Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="<%=Glo.getCCFlowAppPath() %>Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="<%=Glo.getCCFlowAppPath() %>Scripts/CommonUnite.js" type="text/javascript"></script>
	<style type="text/css">
        table
        {
            border: none;
        }
        tr
        {
            border: none;
        }
        td
        {
            border: none;
        }
        .eachMsg
        {
            border-top: 1px #CDCDCD dashed;
        }
        .link
        {
            font-size: 15px;
            color: #69708D;
        }
        .sec
        {
            font-size: 15px;
            background-color: #037FCC;
            color: #F7EEAA;
        }
        .MsgDoc
        {
            padding:10px;
        }
    </style>
    <script  type="text/javascript">
        function Del(pk) {
            if (confirm('确定要删除吗?')) {
                window.location.href = '?OP=' + pk;
            }
        }
        function Rel(reTo, pk) {
            var url = 'messagesreplay.jsp?RE=' + reTo + '&MyPK=' + pk;
            WinOpen(url);
        }
    </script>
</head>
<body>
<table width='100%' cellspacing='0' cellpadding='0' align="left">
        <caption> <div class='CaptionMsg'>消息</div>  </caption>
        <%-- 加载类型--%>
        <script type="text/javascript">
            $(function () {
                document.getElementById("disThis").style.backgroundColor = "#7699CB";
                document.getElementById("disThis").style.color = "#F7EEAA";
                $('#win').window('close');
            });
            function replay(sendTo, id) {
                //                alert(sendTo + "---" + id);
                window.open('messagesreplay.jsp?RE=' + sendTo + '&MyPK=' + id + '&', '', 'height=400, width=600, top=0, left=0, toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
            }
        </script>
        <%
            MsgTypes tps = new MsgTypes();
            tps.RetrieveAll();
            String link = "";
            for (MsgType tp : tps.toJavaList())
            {
                String str = "";
                if (StringHelper.isNullOrEmpty(request.getParameter("MsgType")) || request.getParameter("MsgType").equals(tp.getNo()))
                    str = " id='disThis' ";

                link += "<a class='link' " + str + " href='?MsgType=" + tp.getNo() + "'>" + tp.getName() + "</a>&nbsp;&nbsp;";
            }
       
        %>
        <tr>
            <th colspan="3" style="padding-left: 10%;">
               <div  style=" float:left"><%=link %> </div>

                <div style=" float:right">
                <a class="sec" href="javascript:if (confirm('确定要删除全部吗?')) { window.location.href = 'messages.jsp?OP=delAll';}" >
                    清空所有</a>
                    &nbsp;&nbsp;&nbsp;
                <a class="sec" target="_self" href="messagesreplay.jsp">新建消息</a>
                </div>
            </th>
        </tr>
     
                <%
                    SMSs sms = null;
                    //执行删除
                    String op = request.getParameter("OP");
                    if (!StringHelper.isNullOrEmpty(op))
                    {
                        if ("delAll".equals(op))
                        {
                            sms = new SMSs();
                            sms.Delete(SMSAttr.SendTo, WebUser.getNo());
                        }
                        else
                        {
                            sms = new SMSs();
                            sms.Delete(SMSAttr.MyPK, op);
                        }
                    }

                    String msgType = request.getParameter("MsgType");
                    if (msgType == null)
                        msgType = "All";

                    int pageSize = 6;

                    String pageIdxStr = request.getParameter("PageIdx");
                    if (StringHelper.isNullOrEmpty(pageIdxStr))
                    {
                        pageIdxStr = "1";
                    }
                    int pageIdx = Integer.parseInt(pageIdxStr);

                    //实体查询.
                    sms = new SMSs();
                    BP.En.QueryObject qo = new BP.En.QueryObject(sms);

                    if ("All".equals(msgType))
                    {
                        qo.AddWhere(SMSAttr.SendTo, WebUser.getNo());
                    }
                    else
                    {
                        qo.AddWhere(SMSAttr.SendTo, WebUser.getNo());
                        qo.addAnd();
                        qo.AddWhere(SMSAttr.MsgFlag, msgType); // 设置查询条件.
                    }
                    int allNum = qo.GetCount();
                    qo.DoQuery(SMSAttr.MyPK, pageSize, pageIdx);
                    int idx = 0;
                    for (SMS msg : sms.ToJavaList())//循环输出信息 单个table
                    {
                        idx++;
                        %>
                        <tr class=" GroupField">
                        <td><img src='<%=basePath %>WF/Img/Msg.png' /> 第<%=idx %>条； <%=msg.getTitle() %> </td>
                        <td>来自:<%= Glo.GenerUserImgSmallerHtml(msg.getSender(), msg.getSender()) %> </td>
                        <td> <%= DataType.ParseSysDate2DateTimeFriendly( msg.getRDT()) %> | <a href="javascript:Rel('<%=msg.getSender() %>','<%=msg.getMyPK() %>')"> <img src='<%=basePath %>WF/Img/Btn/Reply.gif' /> 回复</a>  <a href="javascript:Del('<%=msg.getMyPK() %>')"><img src='<%=basePath %>WF/Img/Btn/Delete.gif' />删除</a></td>
                        </tr>

                        <tr>
                           <td colspan="3" valign="top" class="MsgDoc"  >
                                                    <%=msg.getDoc()%>
   
                                    </td>
                        </tr>
                <%  
                    }
                %>
        
    </table>

                <%
                    //绑定分页
                    StringBuilder strBuilder = new StringBuilder();
                    BaseModel.BindPageIdx(strBuilder,allNum, pageSize, pageIdx, "messages.jsp?MsgType=" + msgType); 
                    %>
                   <%=strBuilder%>  
                    
</body>
</html>