<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.DA.DataTable"%>
<%@page import="BP.WF.Dev2Interface"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="am-cf am-padding">
	<div class="am-fl am-cf">
		<strong class="am-text-primary am-text-lg">首页</strong> / <small>工作流程管理</small>
	</div>
</div>
<ul class="am-avg-sm-1 am-avg-md-4 am-margin am-padding am-text-center admin-content-list ">
	<li><a href="Start.jsp"
		class="am-text-success"><span
			class="am-icon-btn am-icon-file-text"></span><br />发起 </a></li>
	<li><a href="Todolist.jsp"
		class="am-text-warning"><span
			class="am-icon-btn am-icon-briefcase"></span><br />待办(<%=Dev2Interface.getTodolist_EmpWorks()%>)</a></li>
	<li><a href="Runing.jsp" class="am-text-danger"><span
			class="am-icon-btn am-icon-recycle"></span><br />在途(<%=Dev2Interface.getTodolist_Runing()%>)</a></li>
	<li><a href="<%=basePath%>WF/CC.jsp" class="am-text-secondary"><span
			class="am-icon-btn am-icon-user-md"></span><br />抄送(<%=Dev2Interface.getTodolist_CCWorks()%>)</a></li>
</ul>

<div class="am-g">
	<div class="am-u-md-6" style="width: 100%">
		<div class="am-panel am-panel-default">
			<div class="am-panel-hd am-cf"
				data-am-collapse="{target: '#tableData'}">
				待办列表<span class="am-icon-chevron-down am-fr"></span>
			</div>
			<div class="am-panel-bd am-collapse am-in" id="tableData">
				<form class="am-form">
					<table
						class="am-table am-table-striped am-table-hover table-main">
						<thead>
							<tr>
								<TH class='table-id'>序</TH>
								<TH class='table-title'>发起人</TH>
								<TH class='table-title'>发起时间</TH>
								<TH class='table-title'>标题</TH>
								<TH class='table-title'>流程</TH>
								<TH class='table-title'>发起时间</TH>
							</tr>
						</thead>
						<tbody>
							<%
								DataTable dt = Dev2Interface.DB_GenerEmpWorksOfDataTable();
								String t = DataType.dateToStr(new Date(), "MMddhhmmss");
								if (null != dt) {
									int i = 0;
									if (dt.Rows.size() < 5) {
										for (i = 0; i < dt.Rows.size(); i++) {
											DataRow dr = dt.Rows.get(i);
											String paras = dr.getValue("AtPara") == null ? "" : dr
													.getValue("AtPara").toString();
											String isRead = dr.getValue("isRead") == null ? "" : dr
													.getValue("isRead").toString();
							%>
							<tr>
								<td nowrap="nowrap"><%=i + 1%></td>
								<td nowrap="nowrap"><%=dr.getValue("StarterName")%></td>
								<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
								<%
									if ("0".equals(isRead)) {
								%>
								<td nowrap="nowrap"><a
									href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
										<b><span
										class="am-badge am-badge-danger">未阅</span></b><%=dr.getValue("Title")%>
								</a></td>
								<%
									} else {
								%>
								<td nowrap="nowrap"><a
									href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
										<span
									class="am-badge am-badge-success">已阅</span> <%=dr.getValue("Title")%>
								</a></td>
								<%
									}
								%>
								<td nowrap="nowrap"><%=dr.getValue("FlowName")%></td>
								<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
								<td nowrap="nowrap"><a
									href="Todolist.jsp">更多</a></td>
							</tr>
							<%
								}
							%>
							<%
								} else {
										for (i = 0; i < 5; i++) {
											DataRow dr = dt.Rows.get(i);
											String paras = dr.getValue("AtPara") == null ? "" : dr
													.getValue("AtPara").toString();
											String isRead = dr.getValue("isRead") == null ? "" : dr
													.getValue("isRead").toString();
							%>
							<tr>
								<td nowrap="nowrap"><%=i + 1%></td>
								<td nowrap="nowrap"><%=dr.getValue("StarterName")%></td>
								<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
								<%
									if ("0".equals(isRead)) {
								%>
								<td nowrap="nowrap"><a
									href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
										<b><span
										class="am-badge am-badge-danger">未阅</span></b><%=dr.getValue("Title")%>
								</a></td>
								<%
									} else {
								%>
								<td nowrap="nowrap"><a
									href="javascript:WinOpen('<%=basePath%>WF/MyFlow.jsp?FK_Flow=<%=dr.getValue("FK_Flow")%>&FK_Node=<%=dr.getValue("FK_Node")%>&WorkID=<%=dr.getValue("WorkID")%>&FID=<%=dr.getValue("FID")%>&IsRead=<%=isRead%>&Paras=<%=paras%>&T=<%=t%>')">
										<span
									class="am-badge am-badge-success">已阅</span> <%=dr.getValue("Title")%>
								</a></td>
								<%
									}
								%>
								<td nowrap="nowrap"><%=dr.getValue("FlowName")%></td>
								<td nowrap="nowrap"><%=dr.getValue("RDT")%></td>
							</tr>
							<%
								}
							%>
							<%
								}
								}
							%>

						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- <div class="am-g">
	<div class="am-u-md-6">
		<div class="am-panel am-panel-default">
			<div class="am-panel-hd am-cf"
				data-am-collapse="{target: '#collapse-panel-1'}">
				文件上传<span class="am-icon-chevron-down am-fr"></span>
			</div>
			<div class="am-panel-bd am-collapse am-in" id="collapse-panel-1">
				<ul class="am-list admin-content-file">
					<li><strong><span class="am-icon-upload"></span>
							Kong-cetian.Mp3</strong>
						<p>3.3 of 5MB - 5 mins - 1MB/Sec</p>
						<div
							class="am-progress am-progress-striped am-progress-sm am-active">
							<div class="am-progress-bar am-progress-bar-success"
								style="width: 82%">82%</div>
						</div></li>
					<li><strong><span class="am-icon-check"></span>
							好人-cetian.Mp3</strong>
						<p>3.3 of 5MB - 5 mins - 3MB/Sec</p></li>
					<li><strong><span class="am-icon-check"></span>
							其实都没有.Mp3</strong>
						<p>3.3 of 5MB - 5 mins - 3MB/Sec</p></li>
				</ul>
			</div>
		</div>
		<div class="am-panel am-panel-default">
			<div class="am-panel-hd am-cf"
				data-am-collapse="{target: '#collapse-panel-2'}">
				浏览器统计<span class="am-icon-chevron-down am-fr"></span>
			</div>
			<div id="collapse-panel-2" class="am-in">
				<table
					class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
					<tbody>
						<tr>
							<th class="am-text-center">#</th>
							<th>浏览器</th>
							<th>访问量</th>
						</tr>
						<tr>
							<td class="am-text-center"><img
								src="assets/i/examples/admin-chrome.png" alt=""></td>
							<td>Google Chrome</td>
							<td>3,005</td>
						</tr>
						<tr>
							<td class="am-text-center"><img
								src="assets/i/examples/admin-firefox.png" alt=""></td>
							<td>Mozilla Firefox</td>
							<td>2,505</td>
						</tr>
						<tr>
							<td class="am-text-center"><img
								src="assets/i/examples/admin-ie.png" alt=""></td>
							<td>Internet Explorer</td>
							<td>1,405</td>
						</tr>
						<tr>
							<td class="am-text-center"><img
								src="assets/i/examples/admin-opera.png" alt=""></td>
							<td>Opera</td>
							<td>4,005</td>
						</tr>
						<tr>
							<td class="am-text-center"><img
								src="assets/i/examples/admin-safari.png" alt=""></td>
							<td>Safari</td>
							<td>505</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="am-u-md-6">
		<div class="am-panel am-panel-default">
			<div class="am-panel-hd am-cf"
				data-am-collapse="{target: '#collapse-panel-4'}">
				任务 task<span class="am-icon-chevron-down am-fr"></span>
			</div>
			<div id="collapse-panel-4" class="am-panel-bd am-collapse am-in">
				<ul class="am-list admin-content-task">
					<li>
						<div class="admin-task-meta">Posted on 25/1/2120 by John
							Clark</div>
						<div class="admin-task-bd">The starting place for
							exploring business management; helping new managers get started
							and experienced managers get better.</div>
						<div class="am-cf">
							<div class="am-btn-toolbar am-fl">
								<div class="am-btn-group am-btn-group-xs">
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-check"></span>
									</button>
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-pencil"></span>
									</button>
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-times"></span>
									</button>
								</div>
							</div>
							<div class="am-fr">
								<button type="button" class="am-btn am-btn-default am-btn-xs">删除</button>
							</div>
						</div>
					</li>
					<li>
						<div class="admin-task-meta">Posted on 25/1/2120 by 呵呵呵</div>
						<div class="admin-task-bd">
							基兰和狗熊出现在不同阵营时。基兰会获得BUFF，“装甲熊憎恨者”。狗熊会获得BUFF，“时光老人憎恨者”。</div>
						<div class="am-cf">
							<div class="am-btn-toolbar am-fl">
								<div class="am-btn-group am-btn-group-xs">
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-check"></span>
									</button>
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-pencil"></span>
									</button>
									<button type="button" class="am-btn am-btn-default">
										<span class="am-icon-times"></span>
									</button>
								</div>
							</div>
							<div class="am-fr">
								<button type="button" class="am-btn am-btn-default am-btn-xs">删除</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<div class="am-panel am-panel-default">
			<div class="am-panel-hd am-cf"
				data-am-collapse="{target: '#collapse-panel-3'}">
				最近留言<span class="am-icon-chevron-down am-fr"></span>
			</div>
			<div class="am-panel-bd am-collapse am-in am-cf"
				id="collapse-panel-3">
				<ul class="am-comments-list admin-content-comment">
					<li class="am-comment"><a href="#"><img
							src="http://amui.qiniudn.com/bw-2014-06-19.jpg?imageView/1/w/96/h/96"
							alt="" class="am-comment-avatar" width="48" height="48"></a>
						<div class="am-comment-main">
							<header class="am-comment-hd">
								<div class="am-comment-meta">
									<a href="#" class="am-comment-author">某人</a> 评论于
									<time>2014-7-12 15:30</time>
								</div>
							</header>
							<div class="am-comment-bd">
								<p>遵循 “移动优先（Mobile First）”、“渐进增强（Progressive
									enhancement）”的理念，可先从移动设备开始开发网站，逐步在扩展的更大屏幕的设备上，专注于最重要的内容和交互，很好。</p>
							</div>
						</div></li>

					<li class="am-comment"><a href="#"><img
							src="http://amui.qiniudn.com/bw-2014-06-19.jpg?imageView/1/w/96/h/96"
							alt="" class="am-comment-avatar" width="48" height="48"></a>
						<div class="am-comment-main">
							<header class="am-comment-hd">
								<div class="am-comment-meta">
									<a href="#" class="am-comment-author">某人</a> 评论于
									<time>2014-7-12 15:30</time>
								</div>
							</header>
							<div class="am-comment-bd">
								<p>有效减少为兼容旧浏览器的臃肿代码；基于 CSS3
									的交互效果，平滑、高效。AMUI专注于现代浏览器（支持HTML5），不再为过时的浏览器耗费资源，为更有价值的用户提高更好的体验。</p>
							</div>
						</div></li>

				</ul>
				<ul class="am-pagination am-fr admin-content-pagination">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul>
			</div>
		</div>
	</div>
</div> -->
