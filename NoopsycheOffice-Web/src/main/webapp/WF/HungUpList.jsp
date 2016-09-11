<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WF/head/head2.jsp"%>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />
<%
	String PageSmall = null;
	String PageID = Glo.getCurrPageID();
	if (PageID.toLowerCase().contains("smallsingle")) {
		PageSmall = "SmallSingle";
	} else if (PageID.toLowerCase().contains("small")) {
		PageSmall = "Small";
	} else {
		PageSmall = "";
	}

	String FK_Flow = request.getParameter("FK_Flow") == null?"":request.getParameter("FK_Flow");
	String DoType = request.getParameter("DoType") == null?"":request.getParameter("DoType");
	String GroupBy = request.getParameter("GroupBy") == null?"":request.getParameter("GroupBy");
	if (StringHelper.isNullOrEmpty(GroupBy)) {
		if ("CC".equals(DoType)) {
			GroupBy = "Rec";
		} else {
			GroupBy = "FlowName";
		}
	}
	boolean IsHungUp = false;
	String isHungUp = request.getParameter("IsHungUp") == null?"":request.getParameter("IsHungUp");
	if (StringHelper.isNullOrEmpty(isHungUp)) {
		IsHungUp = false;
	} else {
		IsHungUp = true;
	}
%>

<%!StringBuffer infoCtrl;

	public void Add(String str) {
		infoCtrl.append(str);
	}

	public void AddTable(String attr) {
		this.Add("<Table class=\"am-table am-table-striped am-table-hover table-main\""
				+ attr + " >");
	}

	public void AddTableEnd() {
		this.Add("</Table>");
	}

	public void AddCaption(String str) {
		this.Add("\n<th class='table-title' colspan='8'>" + str + "</th>");
	}

	public void AddTR() {
		this.Add("\n<TR>");
	}

	public void AddTR(String attr) {
		this.Add("\n<TR " + attr + " >");
	}

	public void AddTREnd() {
		this.Add("\n</TR>");
	}

	public void AddTRSum() {
		this.Add("\n<TRss>");
	}

	public void AddTDTitle(String str) {
		this.Add("\n<TH class='table-title'>" + str + "</TH>");
	}

	public void AddTD(String attr, String str) {
		this.Add("\n<TD " + attr + " >" + str + "</TD>");
	}

	public void AddTDIdx(int idx) {
		this.Add("\n<TD nowrap>" + idx + "</TD>");
	}

	public void AddTDB(String attr, String str) {
		this.Add("\n<TD  " + attr + " nowrap=true ><b>" + str + "</b></TD>");
	}

	public void AddTDBigDoc(String str) {
		this.Add("\n<TD valign=top>" + str + "</TD>");
	}

	public void AddTDB(String str) {
		this.Add("\n<TD  nowrap=true ><b>" + str + "</b></TD>");
	}

	public void AddTD(String str) {
		if (null == str || "".equals(str))
			this.Add("\n<TD  nowrap >&nbsp;</TD>");
		else
			this.Add("\n<TD  nowrap >" + str + "</TD>");
	}

	public void AddTDCenter(String str) {
		this.Add("\n<TD align=center nowrap >" + str + "</TD>");
	}

	public void BindList(DataTable dt, String basePath, String FK_Flow,
			String GroupBy, boolean IsHungUp, String PageID, String PageSmall) {
		boolean isPRI = Glo.getIsEnablePRI();
		String groupVals = "";
		for (DataRow dr : dt.Rows) {
			if (groupVals.contains("@" + dr.getValue(GroupBy) + ","))
				continue;
			groupVals += "@" + dr.getValue(GroupBy) + ",";
		}
		int colspan = 9;

		//this.AddTable("align=left");
		this.AddCaption("<img src='" + basePath
				+ "WF/Img/Runing.gif' ><a href='" + basePath + "WF/" + PageID
				+ ".jsp?IsHungUp=1' >挂起工作</a>");
		String extStr = "";
		if (IsHungUp)
			extStr = "&IsHungUp=1";

		this.AddTR();
		this.AddTDTitle("ID");
		this.AddTDTitle("标题");

		if (!"FlowName".equals(GroupBy))
			this.AddTDTitle("<a href='" + basePath + "WF/" + PageID
					+ ".jsp?GroupBy=FlowName" + extStr + "' >流程</a>");

		if (!"NodeName".equals(GroupBy))
			this.AddTDTitle("<a href='" + basePath + "WF/" + PageID
					+ ".jsp?GroupBy=NodeName" + extStr + "' >节点</a>");

		if (!"StarterName".equals(GroupBy))
			this.AddTDTitle("<a href='" + basePath + "WF/" + PageID
					+ ".jsp?GroupBy=StarterName" + extStr + "' >发起人</a>");

		if (isPRI)
			this.AddTDTitle("<a href='" + basePath + "WF/" + PageID
					+ ".jsp?GroupBy=PRI" + extStr + "' >优先级</a>");

		this.AddTDTitle("发起日期");
		this.AddTDTitle("接受日期");
		this.AddTDTitle("期限");
		this.AddTDTitle("状态");
		//this.AddTREnd();

		int i = 0;
		Date cdt = DataType.getDate();
		String[] gVals = groupVals.split("@");
		int gIdx = 0;
		for (String g : gVals) {
			if (StringHelper.isNullOrEmpty(g))
				continue;
			gIdx++;
			this.AddTR();
			if ("Rec".equals(GroupBy))
				this.AddTD(
						"colspan='" + colspan
								+ "'onclick=\"GroupBarClick('"
								+ gIdx + "')\" ",
						"<div style='text-align:left; float:left' ><img src='"
								+ basePath
								+ "WF/Img/Min.gif' alert='Min' id='Img" + gIdx
								+ "'   border=0 />&nbsp;<b>"
								+ g.replace(",", "") + "</b>");
			else
				this.AddTD(
						"colspan='" + colspan
								+ "'onclick=\"GroupBarClick('"
								+ gIdx + "')\" ",
						"<div style='text-align:left; float:left' ><img src='"
								+ basePath
								+ "WF/Img/Min.gif' alert='Min' id='Img" + gIdx
								+ "'   border=0 />&nbsp;<b>"
								+ g.replace(",", "") + "</b>");
			this.AddTREnd();
			for (DataRow dr : dt.Rows) {
				if (!g.equals(dr.getValue(GroupBy) + ","))
					continue;

				String sdt = dr.getValue(GenerWorkFlowAttr.SDTOfFlow)
						.toString();
				this.AddTR("ID='" + gIdx + "_" + i + "'");
				i++;
				this.AddTDIdx(i);
				if (Glo.getIsWinOpenEmpWorks()) {
					this.AddTD(
							"onclick=\"SetImg('I" + gIdx + "_" + i
									+ "')\"",
							"<a href=\"javascript:WinOpenIt('" + basePath
									+ "WF/MyFlow.jsp?FK_Flow="
									+ dr.getValue("FK_Flow") + "&FK_Node="
									+ dr.getValue("FK_Node") + "&FID="
									+ dr.getValue("FID") + "&WorkID="
									+ dr.getValue("WorkID")
									+ "&IsRead=0');\" ><span class='am-icon-sign-out'></span>"
									+ dr.getValue("Title").toString());
				} else {
					this.AddTD("Class='TTD'",
							"<a href=\"" + basePath + "MyFlow" + PageSmall
									+ ".jsp?FK_Flow=" + dr.getValue("FK_Flow")
									+ "&FK_Node=" + dr.getValue("FK_Node")
									+ "&FID=" + dr.getValue("FID") + "&WorkID="
									+ dr.getValue("WorkID") + "\" >"
									+ dr.getValue("Title").toString());
				}

				if (!"FlowName".equals(GroupBy))
					this.AddTD(dr.getValue("FlowName").toString());

				if (!"NodeName".equals(GroupBy))
					this.AddTD(dr.getValue("NodeName").toString());

				if (!"StarterName".equals(GroupBy))
					this.AddTD(dr.getValue("Starter") + " "
							+ dr.getValue("StarterName"));

				if (isPRI)
					this.AddTD("<img src='" + basePath + "/WF/Img/PRI/"
							+ dr.getValue("PRI").toString()
							+ ".png' class='ImgPRI' />");

				this.AddTD(dr.getValue("RDT").toString().substring(5));
				this.AddTD(dr.getValue("SDTOfFlow").toString().substring(5));
				this.AddTD(dr.getValue("SDTOfNode").toString().substring(5));

				Date mysdt = DataType.ParseSysDate2DateTime(sdt);
				if (cdt.getTime() >= mysdt.getTime()) {
					if (DataType.dateToStr(cdt, "yyyy-MM-dd").equals(
							DataType.dateToStr(mysdt, "yyyy-MM-dd")))
						this.AddTDCenter("正常");
					else
						this.AddTDCenter("<font color=red>逾期</font>");
				} else {
					this.AddTDCenter("正常");
				}
				this.AddTREnd();
			}
		}
		this.AddTableEnd();
	}%>
</head>
<script type="text/javascript">
function GroupBarClick(rowIdx) {
    var alt = document.getElementById('Img' + rowIdx).alert;
    var sta = 'block';
    if (alt == 'Max') {
        sta = 'block';
        alt = 'Min';
    } else {
        sta = 'none';
        alt = 'Max';
    }
    document.getElementById('Img' + rowIdx).src = '<%=basePath%>WF/Img/' + alt + '.gif';
    document.getElementById('Img' + rowIdx).alert = alt;
    var i = 0;
    for (i = 0; i <= 5000; i++) {
        if (document.getElementById(rowIdx + '_' + i) == null)
            continue;
        if (sta == 'block') {
            document.getElementById(rowIdx + '_' + i).style.display = '';
        } else {
            document.getElementById(rowIdx + '_' + i).style.display = sta;
        }
    }
}
function WinOpenIt(url) {
    var newWindow = window.open(url, '_blank', 'height=600,width=850,top=50,left=50,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no');
    newWindow.focus();
    return;
}
function SetImg(id) {
    document.getElementById(id).src ='<%=basePath%>WF/Img/Mail_Read.png';
	}
</script>
</head>
<body>
	<!-- 内容 -->
	<!-- 表格数据 -->
	<table border=1px align=center width='100%'>
		<Caption ><div class='CaptionMsg' >挂起列表</div></Caption>
		<!-- 数据 -->

		<div class="am-g">
			<div class="am-u-sm-12">
				<form class="am-form">
					<%
						infoCtrl = new StringBuffer();
						this.BindList(Dev2Interface.DB_GenerHungUpList(), basePath,
								FK_Flow, GroupBy, IsHungUp, PageID, PageSmall);
					%>
					<%=infoCtrl.toString()%>
				</form>
				<!-- <ul class="am-pagination am-pagination-right">
					<li class="am-disabled"><a href="#">&laquo;</a></li>
					<li class="am-active"><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul> -->
			</div>
			
		</div>

	</table>
</body>
</html>