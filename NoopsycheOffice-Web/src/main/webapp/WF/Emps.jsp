<%@page import="BP.WF.Port.WFEmp"%>
<%@page import="BP.WF.Port.WFEmps"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<%
	String DoType = request.getParameter("DoType");
	// 	if(DoType==null){
	// 		DoType="1";
	// 	}
%>
<script type="text/javascript">
	function DoUp(no, keys) {
		var url = "Do.jsp?DoType=EmpDoUp&RefNo=" + no + '&dt=' + keys;
		val = window
				.showModalDialog(
						url,
						'f4',
						'dialogHeight: 5px; dialogWidth: 6px; dialogTop: 100px; dialogLeft: 100px; center: yes; help: no');
		window.location.href = window.location.href;
		return;
	}
	function DoDown(no, keys) {
		var url = "Do.jsp?DoType=EmpDoDown&RefNo=" + no + '&sd=' + keys;
		val = window
				.showModalDialog(
						url,
						'f4',
						'dialogHeight: 5px; dialogWidth: 6px; dialogTop: 100px; dialogLeft: 100px; center: yes; help: no');
		window.location.href = window.location.href;
		return;
	}
</script>
</head>
<body>
	<!-- 内容 -->
	<!-- 表格数据 -->
	<table border=1px align=center width='100%'>
		<Caption ><div class='CaptionMsg' >成员列表</div></Caption>
		<!-- 数据 -->

		<div class="am-g">
			<div class="am-u-sm-12">
				<form class="am-form">
					<%
						if ( 1==2 ) {
					%>
					<table class="am-table am-table-striped am-table-hover table-main"
						align="left">
						<tr>
							<th colspan="4" align="left" class="FDesc">成员</th>
						</tr>
						<%
								Depts depts = new Depts();
								depts.RetrieveAllFromDBSource();

								WFEmps emps = new WFEmps();
								emps.RetrieveAllFromDBSource();

								int idx = 0;
								for (BP.Port.Dept dept : Depts.convertDepts(depts)) {
						%>
						<tr>
							<td colspan="4"><%=dept.getName()%></td>
						</tr>
						<%
							for (WFEmp emp : emps.ToJavaList()) {
								if (emp.getFK_Dept() != dept.getNo())
									continue;
								idx++;
						%>
						<tr>
							<td><%=idx%></td>
							<td><%=emp.getName()%></td>
							<td><%=emp.getTel()%></td>
							<td><%=emp.getStas()%></td>
						</tr>
						<%
							}
								}
						%>
					</table>
					<%
						return;
						}
						String sql = "SELECT a.No,a.Name, b.Name as DeptName FROM Port_Emp a, Port_Dept b WHERE a.FK_Dept=b.No ORDER BY a.FK_Dept ";
						DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

						BP.WF.Port.WFEmps emps = new BP.WF.Port.WFEmps();
						if (DoType != null) {
							emps.RetrieveAllFromDBSource();
						} else {
							emps.RetrieveAllFromDBSource();
						}
					%>
					<table width="100%"
						class="am-table am-table-striped am-table-hover table-main"
						align="left">
						<th class="table-title" colspan="8">成员</th>
						<tr>
							<th class="table-title">IDX</th>
							<th class="table-title">部门</th>
							<th class="table-title">人员</th>
							<th class="table-title">Tel</th>
							<th class="table-title">Email</th>
							<th class="table-title">岗位</th>
							<th class="table-title">签名</th>
							<%
								if (WebUser.getNo() == "admin" ) {
							%>
							<th class="table-title">顺序</th>
							<%
								}
							%>
							<%
								if (DoType != null) {
									BP.WF.Port.WFEmp.DTSData();
									//this.GenerAllImg();
									BP.WF.Port.WFEmps empWFs = new BP.WF.Port.WFEmps();
									empWFs.RetrieveAll();

									for (BP.WF.Port.WFEmp emp : empWFs.ToJavaList()) {
										File file = new File(
												BP.Sys.SystemConfig.getPathOfDataUser()
														+ "Siganture\\" + emp.getNo() + ".jpg");
										File fl = new File(BP.Sys.SystemConfig.getPathOfDataUser()
												+ "Siganture\\" + emp.getName() + ".jpg");
										//System.out.println(BP.Sys.SystemConfig.getPathOfDataUser()
										//		+ "Siganture\\" + emp.getNo() + ".jpg");
										if (file.exists() || fl.exists()) {
											continue;
										}
										String path1 = BP.Sys.SystemConfig.getPathOfDataUser()
												+ "Siganture\\T.jpg";
										String pathMe = BP.Sys.SystemConfig.getPathOfDataUser()
												+ "Siganture\\" + emp.getNo() + ".jpg";
										GenerSiganture.fileChannelCopy(
												new File(BP.Sys.SystemConfig.getPathOfDataUser()
														+ "Siganture\\Templete.jpg"),
												new File(path));
										GenerSiganture.writeImageLocal(
												pathMe,
												GenerSiganture.modifyImage(
														GenerSiganture.loadImageLocal(path1),
														emp.getName(), 90, 90));
										GenerSiganture.fileChannelCopy(new File(pathMe), new File(
												BP.Sys.SystemConfig.getPathOfDataUser()
														+ "Siganture\\" + emp.getName() + ".jpg"));
									}
								}
							%>
						</tr>
						<%
							//String keys = DateTime.Now.toString("MMddhhmmss");
							String keys = DataType.dateToStr(new Date(), "MMddhhmmss");
							String deptName = null;
							int idx = 0;
							EmpStations ess = new EmpStations();
							ess.RetrieveAll();
							for (DataRow dr : dt.Rows) {
								String fk_emp = dr.getValue("No").toString();
								if (fk_emp.equals("admin"))
									continue;
								idx++;
								if (!dr.getValue("DeptName").toString().equals(deptName)) {
									deptName = dr.getValue("DeptName").toString();
						%>
						<tr>
							<td><%=idx%></td>
							<td><%=deptName%></td>
							<%
								} else {
							%>
						
						<tr>
							<td><%=idx%></td>
							<td></td>
							<%
								}
							%>
							<td><%=fk_emp%>-<%=dr.getValue("Name")%></td>
							<%
								//BP.WF.Port.WFEmp emp = emps.GetEntityByKey(fk_emp) as BP.WF.Port.WFEmp;
									BP.WF.Port.WFEmp emp = (BP.WF.Port.WFEmp) emps
											.GetEntityByKey(fk_emp);
									if (emp != null) {
							%>
							<td></td>
							<td></td>
							<%
								String stas = "";
										for (EmpStation es : EmpStations.convertEmpStations(ess)) {
											if (!es.getFK_Emp().equals(emp.getNo()))
												continue;
											stas += es.getFK_StationT() + ",";
										}
							%>
							<td><%=stas%></td>
							<%
								} else {
							%>
							<td></td>
							<td></td>
							<td></td>
							<%
								}
							%>
							<td><img
								src='<%=basePath%>DataUser/Siganture/<%=fk_emp%>.jpg' border="1"
								onerror="this.src='<%=basePath%>DataUser/Siganture/UnName.jpg'" /></td>
							<%
								if (  WebUser.getNo() == "admin" ) {
							%>
							<td><a
								href="javascript:DoUp('<%=emp.getNo()%>','<%=keys%>')"><img
									src='<%=basePath%>WF/Img/Btn/Up.GIF' border="0" /></a>-<a
								href="javascript:DoDown('<%=emp.getNo()%>','<%=keys%>')"><img
									src='<%=basePath%>WF/Img/Btn/Down.gif' border="0" /></a></td>
							<%
								}
							%>
						</tr>
						<%
							}
						%>
					</table>
				</form>
				<!-- <ul class="am-pagination am-pagination-right">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul>	 -->	
			</div>
		</div>
	</table>
</body>
</html>