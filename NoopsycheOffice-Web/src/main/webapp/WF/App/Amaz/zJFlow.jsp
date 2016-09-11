<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<style type="text/css">
.large {
	background-color: #99CCFF;
}

.box {
	margin: 0 auto; /* 居中 这个是必须的，，其它的属性非必须 */
	border: 2px solid #99CCFF;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px; /* W3C syntax */
	width: 900px; /* 给个宽度 顶到浏览器的两边就看不出居中效果了 */
	height: 35px;
	text-align: center;
	background-color: #99CCFF;
	width: 900px;
	-moz-border-radius: 15px; /* Gecko browsers */
	-webkit-border-radius: 15px; /* Webkit browsers */
	border-radius: 15px; /* 文字等内容居中 */
}

.box-main {
	margin: 0 auto;
	border: 2px solid #99CCFF;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px; /* W3C syntax */
	width: 900px;
	height: auto;
	background-color: #FFFFFF;
}

.img {
	width: 100%;
	height: 500px;
	border: 2px solid #99CCFF;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px; /* W3C syntax */
	margin-bottom: 10px;
}

input {
	border: 2px solid #99CCFF;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px; /* W3C syntax */
	width: 190px;
	height: 32px;
}

.img1 {
	width: 250px;
	height: auto;
}

.box-top {
	border: 2px solid #99CCFF;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px; /* W3C syntax */
	background-color: #0099CC;
	text-align: center;
	font-size: 45px;
	font-family: fantasy;
	width: auto;
	height: 65px;
	color: white;
}

.box-model1 {
	width: 280px;
	float: left;
	height: auto;
	margin: 5px;
	height: auto;
}

.box-model2 {
	width: 590px;
	float: right;
	height: auto;
	margin: 5px;
}

.box-left {
	width: 280px;
	float: left;
	height: auto;
	margin: 5px;
	height: auto;
}

.box-content {
	width: 305px;
	float: left;
	height: auto;
	margin: 5px;
	height: auto;
}

.box-right {
	float: right;
	width: 280px;
	height: auto;
	margin: 5px;
	height: auto;
}

.footer {
	font-size: 15px;
}
</style>
</head>

<body class="large">
	<div class="box-top">
		<b>Jflow,引领时代的潮流</b>
	</div>
	<header class="box">
		<div class="am-collapse am-topbar-collapse" id="topbar-collapse">
			<ul class="am-nav am-nav-pills am-topbar-nav admin-header-list">
				<li><button type="button"
						class="am-round am-btn am-btn-secondary">首页</button></li>
				<li class="am-dropdown" data-am-dropdown><button type="button"
						data-am-dropdown-toggle
						class="am-dropdown-toggle am-round am-btn am-btn-secondary">
						关于我们&nbsp;<span class="am-icon-caret-down"></span>
					</button>
					<ul class="am-dropdown-content">
						<li><a href="#">总裁致辞</a></li>
						<li><a href="#">企业文化</a></li>
					</ul></li>
				<li class="am-dropdown" data-am-dropdown><button type="button"
						class="am-dropdown-toggle am-round am-btn am-btn-secondary"
						data-am-dropdown-toggle>
						解决方案&nbsp;<span class="am-icon-caret-down"></span>
					</button>
					<ul class="am-dropdown-content">
						<li><a href="#">项目管理</a></li>
						<li><a href="#">IT服务管理</a></li>
						<li><a href="#">统一搜索</a></li>
						<li><a href="#">单点登录</a></li>
					</ul></li>
				<li><button type="button"
						class="am-round am-btn am-btn-secondary">成功经验</button></li>
				<li><button type="button"
						class="am-round am-btn am-btn-secondary">联系我们</button></li>
				<li><button type="button"
						class="am-round am-btn am-btn-secondary">公司动态</button></li>
				<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li class="am-rf"><input type="text" placeholder="搜索">
					<button type="button" class="am-round am-btn am-btn-secondary">搜索</button></li>
		</div>
	</header>
	<div class="box-main">
		<div>
			<img class="img" src="<%=basePath%>WF/assets/i/30006.jpg" />
		</div>
		<div class="am-g">
			<%
				int num = request.getParameter("num") == null ? 0 : Integer
						.parseInt(request.getParameter("num"));
				String title = request.getParameter("title") == null ? "" : request
						.getParameter("title");
				String[] tt = title.split("，");
				String[] textarea = new String[100];
				String[] col = new String[100];
				String[] content = new String[100];
				int[] selectIndex = new int[100];
				for (int i = 0; i < num; i++) {
					String ta = request.getParameter("textarea" + i) == null ? ""
							: request.getParameter("textarea" + i);
					content = ta.split("，");
					String cl = request.getParameter("col" + i) == null ? ""
							: request.getParameter("col" + i);
					int si = request.getParameter("selectType" + i) == null ? 0
							: Integer.parseInt(request.getParameter("selectType"
									+ i));
					textarea[i] = ta;
					col[i] = cl;
					selectIndex[i] = si;
				}
			%>
			<%
				for (int i = 0; i < num; i++) {
			%>
			<div class="am-u-sm-<%=col[i]%>">
				<div class="am-panel am-panel-secondary">
					<div class="am-panel-hd">
						<h3 class="am-panel-title">
							<i class="am-icon-check-square-o"></i>&nbsp;<%=tt[i]%>
						</h3>
					</div>
					<table class="am-table">
						
							<%
								if (selectIndex[i] == 1) {
											String[] st = textarea[i].split("，");
											for (int k = 0; k < st.length; k++) {
							%>
							<tr>
							<td><a href="#"><%=st[k]%></a></td></tr>
							<%
								}
							%>

							<%
								}
							%>
							<%
								if (selectIndex[i] == 0) {
											String[] st = textarea[i].split("，");
											for (int k = 0; k < st.length; k++) {
							%>
							<tr><td><%=st[k]%></td></tr>
							<%
								}
							%>
						<%
							}
						%>
						
							<%
								if (selectIndex[i] == 2) {
											String[] st = textarea[i].split("，");
											for (int k = 0; k < st.length; k++) {
							%>
							<%=st[k]%>
							<%
								}
							%>
						<%
							}
						%>
						
						<%
								if (selectIndex[i] == 3) {
											String[] st = textarea[i].split("，");
											for (int k = 0; k < st.length; k++) {
							%>
							<%=st[k]%>
							<%
								}
							%>
						<%
							}
						%>
					</table>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div style="clear: both"></div>
	</div>
	<footer data-am-widget="footer" class="am-footer footer"
		data-am-footer="{  }">
		<div class="am-footer-switch">
			<span class="am-footer-ysp" data-rel="mobile"
				data-am-modal="{target: '#am-switch-mode'}">云适配版</span> <span
				class="am-footer-divider">|</span> <a id="godesktop"
				data-rel="desktop" class="am-footer-desktop" href="javascript:">电脑版</a>
		</div>
		<div class="am-footer-miscs ">
			<p>
				由 <a href="http://www.yunshipei.com/" title="诺亚方舟" target="_blank"
					class="">诺亚方舟</a>提供技术支持
			</p>
			<p>CopyRight©2014 AllMobilize Inc.</p>
			<p>京ICP备13033158</p>
		</div>
	</footer>
	<div id="am-footer-modal"
		class="am-modal am-modal-no-btn am-switch-mode-m am-switch-mode-m-default">
		<div class="am-modal-dialog">
			<div class="am-modal-hd am-modal-footer-hd">
				<a href="javascript:void(0)" data-dismiss="modal"
					class="am-close am-close-spin " data-am-modal-close>&times;</a>
			</div>
			<div class="am-modal-bd">
				您正在浏览的是 <span class="am-switch-mode-owner">云适配</span> <span
					class="am-switch-mode-slogan">为您当前电脑订制的移动网站。</span>
			</div>
		</div>
	</div>
	<div style="clear: both"></div>
</body>
</html>