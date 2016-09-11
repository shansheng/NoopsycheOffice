<%@page import="BP.Sys.Frm.MapDtl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>

<%
	String myPk = request.getParameter("MyPK");
	String isSubmit = request.getParameter("isSubmit");
	
	MapDtl dtl = new MapDtl(myPk);
	
	if(!StringHelper.isNullOrEmpty(isSubmit)){
		String tbDoc = request.getParameter("TB_Doc");
		dtl.setMTR(tbDoc);
		dtl.Update();
		BaseModel.WinClose();
	}
%>

<script type="text/javascript">
	function Rep() {
	    var mytb = document.getElementById('TB_Doc');
	    var s = mytb.value;
	    s = s.replace(/</g, "《");
	    s = s.replace(/>/g, "》");
	    s = s.replace(/'/g, "‘");
	    alert(s);
	    mytb.value = s;
	    return true;
	}
</script>
<base target="_self" />
<body>
<form action="MapDtlMTR.jsp?MyPK=<%=myPk %>&isSubmit=true" method="post">
	<div style="left: 0px; top: 0px; width: 600px;" class="panel layout-panel layout-panel-center">
		<div class="panel-body panel-body-noheader layout-body" data-options="region:'center',title:''"
			style="padding: 5px; width: 600px; height: 750px;">
			<table class="Table" cellpadding="2" cellspacing="2">
				<caption>请书写html标记,以《TR》开头，以《/TR》结尾。</caption>
				<tbody>
					<tr>
						<td><textarea name="TB_Doc" rows="15" cols="60" id="TB_Doc"><%=dtl.getMTR()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input name="Btn_Save" value="保存" onclick="javascript:Rep();"
				id="Btn_Save" class="Btn" type="submit">
		</div>
	</div>
	</form>
</body>
</html>