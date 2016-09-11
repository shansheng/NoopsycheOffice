<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="BP.WF.Flow" %>
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	String FK_Flow = request.getParameter("FK_Flow");
	if (FK_Flow == null || "".equals(FK_Flow)){
		 FK_Flow = "007";
	}
	String FK_MapData = request.getParameter("FK_MapData");
	if (FK_MapData == null || "".equals(FK_MapData)){
		FK_MapData = "ND" + Integer.parseInt(FK_Flow) + "Rpt";
	}
	String RptNo = request.getParameter("RptNo");
	if (RptNo == null || "".equals(RptNo)){
		RptNo = "ND" + Integer.parseInt(FK_Flow) + "MyRpt";
	}
	//String fl = new Flow(FK_Flow).getName();
    String Title = "报表设计：" + new Flow(FK_Flow).getName();
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=Title%></title>
<link href="../Comm/Style/CommStyle.css" rel="stylesheet" type="text/css" />
<link href="../Scripts/easyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="../Scripts/easyUI/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="../Scripts/easyUI/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="../Scripts/easyUI/jquery.easyui.min.js" type="text/javascript"></script>
<script language="javascript">
        var currShow;

        //在右侧框架中显示指定url的页面
        function OpenUrlInRightFrame(ele, url) {
            if (ele != null && ele != undefined) {
                //if (currShow == $(ele).text()) return;

                currShow = $(ele).parents('li').text(); //有回车符
                $.each($('ul.navlist'), function () {
                    $.each($(this).children('li'), function () {
                        $(this).children('div').css('font-weight', $(this).text() == currShow ? 'bold' : 'normal');
                    });
                });
                $('#context').attr('src', url);
            }
        }
        $(document).ready(function(){
        	$("#aa2").click();
        }); 
        
    </script>
</head>

<body class="easyui-layout">
	<form method="post"
		action="OneFlow.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>" id="form1">
		<div class="aspNetHidden">
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwULLTE5ODUxNjk3NjhkZIS5dGhQTb2b0JPHCh7Zrz34a0//sNboLmTAST03abqH" />
		</div>

		<div data-options="region:'center',border:false">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'west',split:true" style="width: 200px;">

					<div class="easyui-panel" title="报表设计/监控"
						data-options="collapsible:true,border:false" style="height: auto">
						<ul class="navlist">
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>mapdef/S1Edit.do?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span class="nav">1. 基本信息</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<a id="aa2" href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/MapDef/Rpt/S2_ColsChose.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span class="nav">2. 设置报表显示列</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/MapDef/Rpt/S3_ColsLabel.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span class="nav">3. 设置报表显示列次序</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/MapDef/Rpt/S5_SearchCond.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span class="nav">4. 设置报表查询条件</span>
									</a>
								</div>
							</li>
							<%-- <li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/MapDef/Rpt/S6_Power.jsp?FK_MapData=<%=FK_MapData %>&FK_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span class="nav">5. 设置报表权限</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Admin/FlowDB/FlowDB.jsp?s=d34&FK_Flow=<%=FK_Flow %>&ExtType=StartFlow&RefNo=')">
										<span>6. 流程监控</span>
									</a>
								</div>
							</li> --%>
						</ul>
					</div>


					<div class="easyui-panel" title="报表查看"
						data-options="collapsible:true,border:false" style="height: auto">
						<ul class="navlist">
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Rpt/Search.jsp?K_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span>1. 查询</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<%-- <a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Rpt/SearchAdv.jsp?RptNo=<%=RptNo%>')">
										 --%><span>2. 高级查询(暂未实现)</span>
									<!-- </a> -->
								</div>
							</li>
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Rpt/Group.jsp?K_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span>3. 分组分析</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Rpt/D3.jsp?K_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										<span>4. 交叉报表</span>
									</a>
								</div>
							</li>
							<li>
								<div>
									<%-- <a href="javascript:void(0)"
										onclick="OpenUrlInRightFrame(this, '<%=basePath%>WF/Rpt/Contrast.jsp?K_Flow=<%=FK_Flow %>&RptNo=<%=RptNo%>')">
										 --%><span>5. 对比分析(暂未实现)</span>
									<!-- </a> -->
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div data-options="region:'center',noheader:true"
					style="overflow-y: hidden">
					<iframe id="context" scrolling="auto" frameborder="0" src=""
						style="width: 100%; height: 100%;"></iframe>
				</div>
			</div>
		</div>
	</form>
</body>
</html>