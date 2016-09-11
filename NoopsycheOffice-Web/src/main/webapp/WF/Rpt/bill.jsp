<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@page import="cn.jflow.common.model.BillPrintModel"%><html>
<head>
<%
	BillPrintModel bpm = new BillPrintModel(request,response);
	bpm.pageLoad();
%>
<title>Insert title here</title>
<script language="JavaScript" src="../Comm/JScript.js"></script>
        <script language="javascript">
            function ShowEn(url, wName, h, w) {
                h = 700;
                w = 900;
                var s = "dialogWidth=" + parseInt(w) + "px;dialogHeight=" + parseInt(h) + "px;resizable:yes";
                var val = window.showModalDialog(url, null, s);
                window.location.href = window.location.href;
            }
            function ImgClick() {
            }
            function OpenAttrs(ensName) {
                var url = './../../Sys/EnsAppCfg.aspx?EnsName=' + ensName;
                var s = 'dialogWidth=680px;dialogHeight=480px;status:no;center:1;resizable:yes'.toString();
                val = window.showModalDialog(url, null, s);
                window.location.href = window.location.href;
            }
            function DDL_mvals_OnChange(ctrl, ensName, attrKey) {

                var idx_Old = ctrl.selectedIndex;
                if (ctrl.options[ctrl.selectedIndex].value != 'mvals')
                    return;
                if (attrKey == null)
                    return;
                var timestamp = Date.parse(new Date());

                var url = 'SelectMVals.aspx?EnsName=' + ensName + '&AttrKey=' + attrKey + '&D=' + timestamp;
                var val = window.showModalDialog(url, 'dg', 'dialogHeight: 450px; dialogWidth: 450px; center: yes; help: no');
                if (val == '' || val == null) {
                    ctrl.selectedIndex = 0;
                }
            }
	</script>
</head>
<body>

<table width='100%' border=0>
<tr>
<td  align=left class='ToolBar'  >
    <div ID="ToolBar1" ><%=bpm.toolBar1.get_content() %></div>
    </td>
    </tr>
<tr>
<td  align=left>
<div ID="UCSys1" ><%=bpm.UCSys1.toString() %></div>
    </td>
    </tr>
    <tr>
<td  align=left>
<div ID="Pub2" ><%=bpm.pub2.toString() %></div>
    </td>
    </tr>
    </table>
</body>
</html>