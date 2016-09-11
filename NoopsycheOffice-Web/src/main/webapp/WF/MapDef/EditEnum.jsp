<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<% 
	EditEnumModel editE = new EditEnumModel(request, response);
	editE.init();
 %>
 <base target=_self  />
<script language=javascript>
    /* ESC Key Down  */
     function Esc() {
            if (event.keyCode == 27)
                window.close();
            return true;
        }
     function btn_Save_Click(btnName){
    	 var param = window.location.search;
     	$("#FormHtml").val($("#form1").html());
     	if(btnName=='Btn_Del'){
        	if (window.confirm('您确认吗?') == false)
                return;
        	}
         var url = "<%=basePath%>WF/MapDef/btn_Save_Click4.do"+param+"&btnName="+btnName;
 		$("#form1").attr("action",url);
 		$("#form1").submit();
     }
 </script>
</head>
<body>
	<form id="form1" method="post" action="">
	<input type="hidden" id="FormHtml" name="FormHtml" value="">
		<div align=center width='90%'>
			<%=editE.Pub1.ListToString() %>
		</div>
	</form>
</body>
</html>