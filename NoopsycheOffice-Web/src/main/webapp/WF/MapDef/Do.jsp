<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<%
Do1Model dm=new Do1Model(request, response);
dm.init();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=dm.Title %></title>
<link href="../Comm/Style/Table.css" rel="stylesheet" type="text/css" />
<link href="../Comm/Style/Table0.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../Comm/JScript.js"
	type="text/javascript"></script>
<script language=javascript>
        function RSize() {

            if (document.body.scrollWidth > (window.screen.availWidth - 100)) {
                window.dialogWidth = (window.screen.availWidth - 100).toString() + "px"
            } else {
                window.dialogWidth = (document.body.scrollWidth + 50).toString() + "px"
            }

            if (document.body.scrollHeight > (window.screen.availHeight - 70)) {
                window.dialogHeight = (window.screen.availHeight - 50).toString() + "px"
            } else {
                window.dialogHeight = (document.body.scrollHeight + 115).toString() + "px"
            }
            window.dialogLeft = ((window.screen.availWidth - document.body.clientWidth) / 2).toString() + "px"
            window.dialogTop = ((window.screen.availHeight - document.body.clientHeight) / 2).toString() + "px"
        }
    /* ESC Key Down  */
    function Esc()
    {
        if (event.keyCode == 27)
            window.close();
       return true;
    }
    function EditEnum(key)
    {
        var url='SysEnum.jsp?DoType=Edit&RefNo='+key;
      //  window.location.href=url;
        var b=window.showModalDialog( url , 'ass' ,'dialogHeight: 500px; dialogWidth: 500px;center: yes; help: no'); 
        window.location.reload(); 
    }
    function NewEnum()
    {
        var url='SysEnum.jsp?DoType=New&EnumKey=';
        var b=window.showModalDialog( url , 'ass' ,'dialogHeight: 500px; dialogWidth: 500px;center: yes; help: no'); 
       window.location.href = window.location.href;
    }
    function AddEnum(mypk, idx, key) {
        var url = '';
        url = 'EditEnum.jsp?DoType=Edit&MyPK=' + mypk + '&EnumKey=' + key + '&IDX=' + idx;
        var c = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 500px;center: yes; help: no');
        return;
    }
    function AddSFTable(mypk, idx, key) {
       
        var url = 'Do.jsp?DoType=AddSFTableAttr&MyPK=' + mypk + '&IDX=' + idx + '&RefNo=' + key;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 500px;center: yes; help: no');
    }
    function HidShowSysField() {
        var v = document.getElementById('SysField').style.display;
        if (v == 'none')
            v = 'block';
        else
            v = 'none';
        document.getElementById('SysField').style.display = v;
    }
    </script>
<base target=_self />
<style type="text/css">
.FUL {
	
}

.FLI {
	
}
</style>
</head>
<body  topmargin="20" leftmargin="20" onkeypress="Esc()"  onload="RSize()" >
    <form id="form1" method="post" action="Do.jsp?DoType=<%=dm.getDoType() %>&MyPK=<%=dm.getMyPK() %>&IDX=<%=dm.getIDX() %>&RefNo=<%=dm.getRefNo()%>">
    <div align=center width="80%" >
    <%=dm.Pub1.toString() %>
    <%=dm.Pub2.toString() %>
    </div>
    </form>
</body>
</html>