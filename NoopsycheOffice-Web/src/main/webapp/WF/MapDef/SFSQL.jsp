<%@page import="cn.jflow.model.wf.mapdef.SFSQLModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
    SFSQLModel sfSqlModel = new SFSQLModel(request, response);
    sfSqlModel.pageLoad();
%>
<title><%= sfSqlModel.getTitle()%></title>
<script language=javascript>
    /* ESC Key Down  */
    function Esc()
    {
        if (event.keyCode == 27)
            window.close();
       return true;
   }
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
   
</script>
<base target=_self /> 
<script type="text/javascript">
    function btn_Save_Click(){
		$("#BodyHtml").val($("#form_id").html());
		document.getElementById('form_id').action="<%=basePath%>WF/MapDef/sfsql/SFSqlSave.do";
		document.getElementById('form_id').submit();
    }
    function btn_Add_Click(){
		$("#BodyHtml").val($("#form_id").html());
		document.getElementById('form_id').action="<%=basePath%>WF/MapDef/sfsql/SFSqlAdd.do";
		document.getElementById('form_id').submit();
    }
    
    function btn_Del_Click(){
		$("#BodyHtml").val($("#form_id").html());
		document.getElementById('form_id').action="<%=basePath%>WF/MapDef/sfsql/SFSqlDel.do";
		document.getElementById('form_id').submit();
    }
    
    function tbNameToPinyin(){
    	var tbName=$("#TB_Name").val();
    	$.ajax({  
		      type:'post',  
		      url:'<%=basePath%>WF/MapDef/sfsql/tbNameToPinyin.do?tbName='+tbName,  
		      data:{},  
		      cache:false,  
		      success:function(data){
		    	  $("#TB_No").val(data);
		       },  
		       error:function(){
		    	   alert("出错了！");
		       }  
		 });
    }
    
</script>
</head>
<body topmargin="0" leftmargin="0" onkeypress="Esc()" onload="RSize()"  >
    <form id="form_id" method="post">
    <input type="hidden" name="BodyHtml" id="BodyHtml">
    <div align=center>
        <%= sfSqlModel.getPubBuilder()%>
    </div>
    
    </form>
</body>
</html>