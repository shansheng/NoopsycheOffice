<%@page import="cn.jflow.model.wf.mapdef.MapDtlDeModel"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head1.jsp"%>

<%
	MapDtlDeModel deModel = new MapDtlDeModel(request, response);
	deModel.pageLoad();
%>
<title><%=deModel.getTitle() %></title>
<script language='JavaScript' src='/DataUser/JSLibData/<%=deModel.getFK_MapDtl()%>.js' ></script> 
    <script language="javascript">
        function Insert(mypk, IDX) {
            var url = 'Do.jsp?DoType=AddF&MyPK=' + mypk + '&IDX=' + IDX;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function AddF(mypk) {
            var url = 'Do.jsp?DoType=AddF&MyPK=' + mypk;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function AddFGroup(mypk) {
            var url = 'Do.jsp?DoType=AddFGroup&FK_MapData=' + mypk;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function CopyF(mypk) {
            var url = 'CopyDtlField.jsp?MyPK=' + mypk;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 600px; dialogWidth: 800px;center: yes; help: no');
            window.location.href = window.location.href;
        }

        function HidAttr(mypk) {
            var url = 'HidAttr.jsp?FK_MapData=' + mypk;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 600px; dialogWidth: 800px;center: yes; help: no');
            //  window.location.href = window.location.href;
        }
        function Edit(mypk, refNo, ftype) {
            var url = 'EditF.jsp?DoType=Edit&MyPK=' + mypk + '&RefNo=' + refNo + '&FType=' + ftype;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function EditEnum(mypk, refNo) {
            var url = 'EditEnum.jsp?DoType=Edit&MyPK=' + mypk + '&RefNo=' + refNo;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function EditTable(mypk, refno) {
            var url = 'EditTable.jsp?DoType=Edit&MyPK=' + mypk + '&RefNo=' + refno;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }

        function Up(mypk, refNo, toidx) {
            var url = 'Do.jsp?DoType=Up&MyPK=' + mypk + '&RefNo=' + refNo + "&IsDtl=1&ToIdx="+toidx;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
            //window.location.href ='MapDef.jsp?PK='+mypk+'&IsOpen=1';
            window.location.href = window.location.href;
        }
        function Down(mypk, refNo, toidx) {
            var url = 'Do.jsp?DoType=DownAttr&MyPK=' + mypk + '&RefNo=' + refNo + "&IsDtl=1&Ds=" + toidx;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function Del(mypk, refNo) {
            if (window.confirm('您确定要删除吗？') == false)
                return;

            var url = 'Do.jsp?DoType=Del&MyPK=' + mypk + '&RefNo=' + refNo;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function DtlMTR(MyPK) {
            var url = 'MapDtlMTR.jsp?MyPK=' + MyPK;
            var b = window.showModalDialog(url, 'ass', 'dialogHeight: 350px; dialogWidth: 550px;center: yes; help: no');
            window.location.href = window.location.href;
        }
        function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
        function Attachment(fk_mapdtl) {
            window.showModalDialog('Attachment.jsp?IsBTitle=1&PKVal=0&FK_MapData=' + fk_mapdtl + '&FK_FrmAttachment=' + fk_mapdtl + '_AthM&Ath=AthM');
        }
        function MapM2M(fk_mapdtl) {
            window.showModalDialog('MapM2M.jsp?NoOfObj=M2M&PKVal=0&FK_MapData=' + fk_mapdtl + '&FK_FrmAttachment=' + fk_mapdtl + '_AthM&Ath=AthM');
        }
    </script>
    <script language="javascript" type="text/javascript">
        // row主键信息 .
        var rowPK = null;
        // ccform 为开发者提供的内置函数.
        // 获取DDL值.
        function ReqDDL(ddlID) {
            var v = document.getElementById('Pub1_DDL_' + ddlID + "_" + rowPK).value;
            if (v == null) {
                alert('没有找到ID=' + ddlID + '的下拉框控件.');
            }
            return v;
        }
        // 获取TB值
        function ReqTB(tbID) {
            var v = document.getElementById('Pub1_TB_' + tbID + "_" + rowPK).value;
            if (v == null) {
                alert('没有找到ID=' + tbID + '的文本框控件.');
            }
            return v;
        }
        // 获取CheckBox值
        function ReqCB(cbID) {
            var v = document.getElementById('Pub1_CB_' + cbID + "_" + rowPK).value;
            if (v == null) {
                alert('没有找到ID=' + cbID + '的单选控件.');
            }
            return v;
        }

        /// 获取DDL Obj
        function ReqDDLObj(ddlID) {
            var v = document.getElementById('Pub1_DDL_' + ddlID + "_" + rowPK);
            if (v == null) {
                alert('没有找到ID=' + ddlID + '的下拉框控件.');
            }
            return v;
        }
        // 获取TB Obj
        function ReqTBObj(tbID) {
            var v = document.getElementById('Pub1_TB_' + tbID + "_" + rowPK);
            if (v == null) {
                alert('没有找到ID=' + tbID + '的文本框控件.');
            }
            return v;
        }
        // 获取CheckBox Obj值
        function ReqCBObj(cbID) {
            var v = document.getElementById('Pub1_CB_' + cbID + "_" + rowPK);
            if (v == null) {
                alert('没有找到ID=' + cbID + '的单选控件.');
            }
            return v;
        }

        // 设置控件值.
        function SetCtrlVal(ctrlID, val) {
            document.getElementById('Pub1_TB_' + ctrlID + "_" + rowPK).value = val;
            document.getElementById('Pub1_DDL_' + ctrlID + "_" + rowPK).value = val;
            document.getElementById('Pub1_CB_' + ctrlID + "_" + rowPK).value = val;
        }
    </script>
</head>
<body class="easyui-layout" onkeypress="Esc()">
    <form id="form1" runat="server">
    <div data-options="region:'center',noheader:true">
        <%=deModel.getPub() %>
    </div>
    </form>
</body>
</html>
