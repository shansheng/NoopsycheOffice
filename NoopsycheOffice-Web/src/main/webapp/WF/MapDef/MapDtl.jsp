<%@page import="BP.WF.Glo"%>
<%@page import="BP.Sys.Frm.MapDtl"%>
<%@page import="cn.jflow.model.wf.mapdef.MapDtlModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WF/head/head1.jsp"%>
	
<%
	MapDtlModel mapDtlModel = new MapDtlModel(request, response);
	mapDtlModel.pageLoad();
%>
	<base target=_self  />
    <title>表单设计</title>
	<script language=javascript>
   
	function Insert(mypk,IDX)
    {
        var url='Do.jsp?DoType=AddF&MyPK='+mypk+'&IDX=' +IDX ;
        var b=window.showModalDialog( url , 'ass' ,'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no'); 
        window.location.href = window.location.href;
    }
    function AddF(mypk) {
        var url = 'Do.jsp?DoType=AddF&MyPK=' + mypk;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function Edit(mypk,refno, ftype)
    {
        var url='EditF.jsp?DoType=Edit&MyPK='+mypk+'&RefNo='+refno +'&FType=' + ftype;
        var b=window.showModalDialog( url , 'ass' ,'dialogHeight: 500px; dialogWidth: 600px;center: yes; help: no'); 
        window.location.href = window.location.href;
    }
    function EditEnum(mypk, refno) {
        var url = 'EditEnum.jsp?DoType=Edit&MyPK=' + mypk + '&RefNo=' + refno;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function EditTable(mypk, refno) {
        var url = 'EditTable.jsp?DoType=Edit&MyPK=' + mypk + '&RefNo=' + refno;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function Up(mypk, refoid) {
        var url = 'Do.jsp?DoType=Up&MyPK=' + mypk + '&RefOID=' + refoid;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function Down(mypk, refoid) {
        var url = 'Do.jsp?DoType=Down&MyPK=' + mypk + '&RefOID=' + refoid;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function Del(mypk, refoid) {
        if (window.confirm('您确定要删除吗？') == false)
            return;

        var url = 'Do.jsp?DoType=Del&MyPK=' + mypk + '&RefOID=' + refoid;
        var b = window.showModalDialog(url, 'ass', 'dialogHeight: 400px; dialogWidth: 600px;center: yes; help: no');
        window.location.href = window.location.href;
    }
    function Esc() {
        if (event.keyCode == 27)
            window.close();
        return true;
    }
    
    // 保存
    function save_map_def_dtl(){
    	$("#ddl_html").val($("#form_ddl").html());
    	$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/SaveMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
    	$("#form_ddl").submit();
    }
 	// 保存关闭
	function save_cancel_map_def_dtl(){
		$("#ddl_html").val($("#form_ddl").html());
    	$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/SaveCancelMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
    	$("#form_ddl").submit();
	}
	// 删除    
	function del_map_def_dtl(){
		if(confirm('您确定吗？')){
			$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/DelMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
	    	$("#form_ddl").submit();
		}
	}
	// 新建
	function new_map_def_dtl(){
		$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/NewMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
    	$("#form_ddl").submit();
	}
	// 扩展属性
	function mapext_map_def_dtl(){
		$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/MapExtMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
    	$("#form_ddl").submit();
	}
	// 附件属性
	function mapath_map_def_dtl(){
		$("#form_ddl").attr("action", "<%=basePath%>WF/MapDef/MapAthMapDtl.do?DoType=<%=mapDtlModel.getDoType()%>&FK_MapData=<%=mapDtlModel.getFK_MapData()%>&FK_MapDtl=<%=mapDtlModel.getFK_MapDtl()%>");
    	$("#form_ddl").submit();
	}
	</script>
</head>
<body topmargin="0" leftmargin="0" onkeypress="Esc();">
    <form id="form_ddl" method="post">
    	<div align=left>
      		<%=mapDtlModel.getPub() %>
      	</div>
      	<input type="hidden" id="ddl_html" name="ddl_html">
    </form>
</body>
</html>