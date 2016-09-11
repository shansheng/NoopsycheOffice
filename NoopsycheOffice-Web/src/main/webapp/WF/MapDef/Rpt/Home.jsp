<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String FK_Flow=request.getParameter("FK_Flow");
	if(FK_Flow==null || FK_Flow.equals("")){
		FK_Flow="007";
	}
	
	String idx=request.getParameter("Idx");
	int Idx;
	if(idx==null || idx.equals("")){
		Idx=0;
	}else{
		Integer.parseInt(idx);
	}
	
	String FK_MapAttr=request.getParameter("FK_MapAttr");
	
	String FK_MapData=request.getParameter("FK_MapData");
	if(FK_MapData==null || FK_MapData.equals("")){
		FK_MapData="ND"+Integer.parseInt(FK_Flow)+"Rpt";
	}
	
	String RptNo=request.getParameter("RptNo");
	if(RptNo==null || RptNo.equals("")){
		RptNo="ND"+Integer.parseInt(FK_Flow)+"MyRpt";
	}
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>报表设计：会议通知流程</title>
<link href="../../Comm/Style/CommStyle.css" rel="stylesheet"
	type="text/css" />
<link href="../../Comm/Style/Table0.css" rel="stylesheet"
	type="text/css" />
<link href="../../Scripts/easyUI/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<link href="../../Scripts/easyUI/themes/icon.css" rel="stylesheet"
	type="text/css" />
<script src="../../Scripts/easyUI/jquery-1.8.0.min.js"
	type="text/javascript"></script>
<script src="../../Scripts/easyUI/jquery.easyui.min.js"
	type="text/javascript"></script>

<base target="_self" />
</head>
<body class="easyui-layout">
	<form method="post" action="Home.jsp" id="form1">
		<div class="aspNetHidden">
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUJMzQ3MDkxOTAyZGRnUhBc44hStX2GAZ7/pHpKfHtgGNMWwIuIx6cggKv/HQ==" />
		</div>

		<div data-options="region:'center',title:'报表设计：会议通知流程',border:false"
			style="padding: 5px; height: auto">


			<h4>报表设计向导，帮助您完成报表个性化定义：</h4>
			<ul class="navlist">
				<li>
					<div>
						<a href="S1_Edit.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>">
							<span class="nav">1. 基本信息</span>
						</a>
					</div>
				</li>
				<li>
					<div>
						<a
							href="S2_ColsChose.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>">
							<span class="nav">2. 设置报表显示列</span>
						</a>
					</div>
				</li>
				<li>
					<div>
						<a
							href="S3_ColsLabel.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>">
							<span class="nav">3. 设置报表显示列次序</span>
						</a>
					</div>
				</li>
				<li>
					<div>
						<a
							href="S5_SearchCond.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>">
							<span class="nav">4. 设置报表查询条件</span>
						</a>
					</div>
				</li>
				<li>
					<div>
						<a
							href="S6_Power.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>">
							<span class="nav">5. 设置报表权限</span>
						</a>
					</div>
				</li>
			</ul>

		</div>
	</form>
</body>
</html>

