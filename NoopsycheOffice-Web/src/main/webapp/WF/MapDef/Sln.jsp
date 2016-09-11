<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
    String FK_MapData = request.getParameter("FK_MapData");
    String FK_Node = request.getParameter("FK_Node");
	String FK_Flow = request.getParameter("FK_Flow");
	if (StringHelper.isNullOrEmpty(FK_Flow)==true)
    {
		Node nd = new Node(FK_Node);
        FK_Flow = nd.getFK_Flow();
    }
	 String KeyOfEn = request.getParameter("KeyOfEn");
	 String Ath = request.getParameter("Ath");
         String sql = "SELECT NodeID,Name,Step FROM WF_Node WHERE NodeID IN (SELECT FK_Node FROM Sys_FrmSln WHERE FK_MapData='" + FK_MapData + "' )";
         DataTable dtNodes = BP.DA.DBAccess.RunSQLReturnTable(sql);
    SlnModel sln=new SlnModel(request,response,FK_MapData,FK_Flow,FK_Node,
			KeyOfEn, Ath, dtNodes);
    sln.init();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
  //编辑Dtl的原始属性.
    function EditDtlYuanShi(fk_mapdata, dtlKey) {
        var url = 'MapDefDtlFreeFrm.jsp?DoType=Edit&FK_MapData=' + fk_mapdata + '&FK_MapDtl=' + dtlKey;
        WinOpen(url,'ss');
    }
    
     //删除附件的权限控制.
    function DeleteDtl(fk_node, fk_mapdata, dtl) {
        if (confirm('您确定要删除该控件在当前节点的权限控制吗？') == false)
            return;
        var url = 'Sln.jsp?DoType=DeleteDtl&FK_Node=' + fk_node + '&FK_MapData=' + fk_mapdata + '&FK_MapDtl=' + dtl;
        WinShowModalDialog(url, 'ss');
        window.location.href = window.location.href;
    }
    
    function DelSln(fk_mapdata,fk_flow, fk_node, keyofen) {
        var url = 'SlnDo.jsp?DoType=DelSln&FK_MapData=' + fk_mapdata + '&FK_Flow=' + fk_flow + '&FK_Node=' + fk_node + '&KeyOfEn=' + keyofen;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 700px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function EditDtl(fk_node, fk_mapdata, dtlNo) {
        var url = 'MapDefDtlFreeFrm.jsp?DoType=Edit&FK_MapData=' + fk_mapdata + '&FK_MapDtl=' + dtlNo + '&FK_Node=' + fk_node;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 600px; dialogWidth: 700px;center: yes; help:no;resizable:yes');
        window.location.href = window.location.href;
    }
    function EditSln(fk_mapdata,fk_flow,fk_node, keyofen) {
        var url = 'SlnDo.jsp?DoType=EditSln&FK_MapData=' + fk_mapdata + '&FK_Flow=' + fk_flow + '&FK_Node=' + fk_node + '&KeyOfEn=' + keyofen;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 700px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function SetSln(fk_mapdata) {
        var url = 'EditMapData.jsp?DoType=EditSln&FK_MapData=' + fk_mapdata ;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 700px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function CopyIt(fk_mapdata,fk_flow, nodeID) {
        var url = 'SlnDo.jsp?DoType=Copy&FK_MapData=' + fk_mapdata + '&FK_Flow=' + fk_flow + '&FK_Node=' + nodeID;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 500px; dialogWidth: 700px;center: yes; help: no');
        window.location.href = window.location.href;
    }

    var IsNoteNull=false;
    function CheckAll(idstr) {
        var arrObj = document.all;
        IsNoteNull = !IsNoteNull;
        for (var i = 0; i < arrObj.length; i++) {

            if (arrObj[i].type != 'checkbox')
                continue;

            var cid = arrObj[i].name;
            if (cid == null || cid == "" || cid == '')
                continue;

            

            if (cid.indexOf(idstr) == -1)
                continue;

            arrObj[i].checked = IsNoteNull;
            //  !arrObj[i].checked;
        }
    }

    var IsEnable = false;
    function CheckAllIsEnable(idstr) {
        var arrObj = document.all;
        IsEnable = !IsEnable;
        for (var i = 0; i < arrObj.length; i++) {

            if (arrObj[i].type != 'checkbox')
                continue;

            var cid = arrObj[i].name;
            if (cid == null || cid == "" || cid == '')
                continue;

            if (cid.indexOf(idstr) == -1)
                continue;

            arrObj[i].checked = IsEnable;
            //  !arrObj[i].checked;
        }
    }

    //编辑附件
    function EditFJ(fk_node,fk_mapdata,ath) {
        WinShowModalDialog('Attachment.jsp?FK_Node=' + fk_node + '&FK_MapData=' + fk_mapdata + '&Ath=' + ath, 'ss');
        window.location.href = window.location.href;
    }
    //删除附件.
    function DeleteFJ(fk_flow, fk_node, fk_mapdata, ath) {

        if (confirm('您确定要删除吗？') == false)
            return;

        var url = 'Sln.jsp?DoType=DeleteFJ&FK_Flow='+fk_flow+'&FK_Node=' + fk_node + '&FK_MapData=' + fk_mapdata + '&Ath=' + ath;
        WinShowModalDialog(url, 'ss');
        window.location.href = window.location.href;
    }
    function btn_Field_Click(btnName){
    	if(btnName=="Btn_Del"){
    		if(confirm('Are you sure?')){
				var url = "<%=basePath%>WF/MapDef/btn_Field_Click.do?btnName="+btnName+"&FK_Node=<%=FK_Node%>&FK_Flow=<%=FK_Flow%>&FK_MapData=<%=FK_MapData%>";
				$("#form1").attr("action",url);
				$("#form1").submit();
			}else{
			 Window.close();
			}
    	}else if(btnName=="Btn_Copy"){
    		CopyIt('<%=FK_MapData%>','<%=FK_Node%>','<%=FK_Flow%>');
    	}else{
    		var url = "<%=basePath%>WF/MapDef/btn_Field_Click.do?btnName="+btnName+"&FK_Node=<%=FK_Node%>&FK_Flow=<%=FK_Flow%>&FK_MapData=<%=FK_MapData%>";
			$("#form1").attr("action",url);
			$("#form1").submit();
    	}
    }
</script>
</head>
<body>
	<form method="post"
		action="Sln.jsp?FK_MapData=<%=FK_MapData%>&amp;FK_Flow=<%=FK_Flow%>&amp;FK_Node=<%=FK_Node%>&amp;Lang=CH"
		id="form1">
		<div>
			<%=sln.Pub1.toString()%>
		</div>
	</form>
</body>
</html>