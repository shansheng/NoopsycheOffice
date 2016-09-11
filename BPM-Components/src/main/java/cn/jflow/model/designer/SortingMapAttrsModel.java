//package cn.jflow.model.designer;
//
//import java.beans.EventHandler;
//import java.io.IOException;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.http.HttpRequest;
//import org.apache.poi.ss.usermodel.BorderStyle;
//
//import cn.jflow.common.model.BaseModel;
//import cn.jflow.system.ui.UiFatory;
//import cn.jflow.system.ui.core.DDL;
//import cn.jflow.system.ui.core.LinkButton;
//import cn.jflow.system.ui.core.ListBox;
//import cn.jflow.system.ui.core.ListItem;
//import cn.jflow.system.ui.core.NamesOfBtn;
//import cn.jflow.system.ui.core.ToolBar;
//import BP.DA.DataRow;
//import BP.DA.DataTable;
//import BP.En.*;
//import BP.Sys.*;
//import BP.Sys.Frm.GroupField;
//import BP.Sys.Frm.GroupFieldAttr;
//import BP.Sys.Frm.GroupFields;
//import BP.Sys.Frm.MapAttr;
//import BP.Sys.Frm.MapAttrAttr;
//import BP.Sys.Frm.MapAttrs;
//import BP.Sys.Frm.MapData;
//import BP.Sys.Frm.MapDataAttr;
//import BP.Sys.Frm.MapDatas;
//import BP.Sys.Frm.MapDtl;
//import BP.Sys.Frm.MapDtlAttr;
//import BP.Sys.Frm.MapDtls;
//import BP.Web.*;
//import BP.WF.*;
//
///** 
// 手机表单中的字段排序功能，added by liuxc,2016-02-26
// 
//*/
//public class SortingMapAttrsModel
//{
//	private HttpServletRequest request = null;
//	private HttpServletResponse response = null;
//	public StringBuilder pub1 = new StringBuilder();
//	
//	public SortingMapAttrsModel(HttpServletRequest request, HttpServletResponse response, String basePath) {
//		//this.basePath = basePath; 
//		this.request = request;
//		this.response = response;
//	}
//
//		///#region 排序按钮控件ID拆解对象
//	
//	private static class MoveBtnIds
//	{
//		
//	
//		/** 
//		 排序按钮控件ID拆解对象
//		 
//		 @param btnId 排序按钮控件ID，由8部分组成，每部分由_连接，如：Btn_Group_Up_4_1_2_1_186
//		 <p>各部分含义：</p>
//		 <p>1.控件命名前缀，此处为Btn</p>
//		 <p>2.移动对象类型，Group[字段分组]或Attr[字段]</p>
//		 <p>3.移动方向，Up[上移]或Down[下移]</p>
//		 <p>4.所有参与排序的记录总数</p>
//		 <p>5.当前记录所处索引号，从1开始</p>
//		 <p>6.当前记录原记录的索引号，从1开始</p>
//		 <p>7.如果是字段移动，此处为该字段所处分组的索引号；分组移动时，此处为0</p>
//		 <p>8.当前记录的主键值</p>
//		 
//		*/
//		public MoveBtnIds(String btnId)
//		{
//			setControlId(btnId);
//
//			String[] ids = getControlId().split("[_]", -1);
//			if (ids.length < 8)
//			{
//				setSuccess(false);
//				return;
//			}
//
//			try
//			{
//				setCtrlPrefix(ids[0]);
//				setMoveDirection(ids[2]);
//				setObjectType(ids[1]);
//				setAllCount(Integer.parseInt(ids[3]));
//				setIdx(Integer.parseInt(ids[4]));
//				setOldIdx(Integer.parseInt(ids[5]));
//				setGroupIdx(Integer.parseInt(ids[6]));
//				setKey(getControlId().substring(getCtrlPrefix().length() + getObjectType().length() + getMoveDirection().length() + (new Integer(getAllCount())).toString().length() + (new Integer(getIdx())).toString().length() + (new Integer(getOldIdx())).toString().length() + (new Integer(getGroupIdx())).toString().length() + 7));
//				setSuccess(true);
//			}
//			catch (java.lang.Exception e)
//			{
//				setSuccess(false);
//			}
//		}
//
//		/** 
//		 获取控件ID
//		 
//		*/
//		private String privateControlId;
//		public final String getControlId()
//		{
//			return privateControlId;
//		}
//		private void setControlId(String value)
//		{
//			privateControlId = value;
//		}
//		/** 
//		 获取控件前缀
//		 
//		*/
//		private String privateCtrlPrefix;
//		public final String getCtrlPrefix()
//		{
//			return privateCtrlPrefix;
//		}
//		private void setCtrlPrefix(String value)
//		{
//			privateCtrlPrefix = value;
//		}
//		/** 
//		 获取排序移动类型，Group或Attr
//		 
//		*/
//		private String privateObjectType;
//		public final String getObjectType()
//		{
//			return privateObjectType;
//		}
//		private void setObjectType(String value)
//		{
//			privateObjectType = value;
//		}
//		/** 
//		 获取移动方向，Down或Up
//		 
//		*/
//		private String privateMoveDirection;
//		public final String getMoveDirection()
//		{
//			return privateMoveDirection;
//		}
//		private void setMoveDirection(String value)
//		{
//			privateMoveDirection = value;
//		}
//		/** 
//		 获取所有参与排序的记录总数
//		 
//		*/
//		private int privateAllCount;
//		public final int getAllCount()
//		{
//			return privateAllCount;
//		}
//		private void setAllCount(int value)
//		{
//			privateAllCount = value;
//		}
//		/** 
//		 获取当前记录所处索引号，从1开始
//		 
//		*/
//		private int privateIdx;
//		public final int getIdx()
//		{
//			return privateIdx;
//		}
//		private void setIdx(int value)
//		{
//			privateIdx = value;
//		}
//		/** 
//		 获取当前记录原记录的索引号，从1开始
//		 
//		*/
//		private int privateOldIdx;
//		public final int getOldIdx()
//		{
//			return privateOldIdx;
//		}
//		private void setOldIdx(int value)
//		{
//			privateOldIdx = value;
//		}
//		/** 
//		 获取字段所处分组的索引号，字段排序时有效
//		 
//		*/
//		private int privateGroupIdx;
//		public final int getGroupIdx()
//		{
//			return privateGroupIdx;
//		}
//		private void setGroupIdx(int value)
//		{
//			privateGroupIdx = value;
//		}
//		/** 
//		 获取当前记录的主键值
//		 
//		*/
//		private String privateKey;
//		public final String getKey()
//		{
//			return privateKey;
//		}
//		private void setKey(String value)
//		{
//			privateKey = value;
//		}
//		/** 
//		 获取本对象是否转换成功
//		 
//		*/
//		private boolean privateSuccess;
//		public final boolean getSuccess()
//		{
//			return privateSuccess;
//		}
//		private void setSuccess(boolean value)
//		{
//			privateSuccess = value;
//		}
//	}
//
//		///#endregion
//
//	public final String getFK_MapData()
//	{
//		return request.getParameter("FK_MapData");
//	}
//
//	public final String getFK_Flow()
//	{
//		return request.getParameter("FK_Flow");
//	}
//
//	private MapDatas mapdatas;
//	private MapAttrs attrs;
//	private GroupFields groups;
//	private MapDtls dtls;
//
//	protected final void Page_lode(Object sender) throws IOException
//	{
//
//		///#region 检验登录（只有admin能进行排序），与传参
//		if ("admin" != WebUser.getNo())
//		{
//			response.getWriter().print("<h3>只有管理员可以进行表单字段的排序操作！</h3>");
//			return;
//		}
//
//		if (StringHelper.isNullOrEmpty(getFK_MapData()))
//		{
//			response.getWriter().print("<h3>FK_MapData参数错误！</h3>");
//			return;
//		}
//
//		///#endregion
//
//
//		///#region 获取数据
//		mapdatas = new MapDatas();
//		QueryObject qo = new QueryObject(mapdatas);
//		qo.AddWhere(MapDataAttr.No, "Like", getFK_MapData() + "%");
//		qo.addOrderBy(MapDataAttr.Idx);
//		qo.DoQuery();
//
//		attrs = new MapAttrs();
//		qo = new QueryObject(attrs);
//		qo.AddWhere(MapAttrAttr.FK_MapData, getFK_MapData());
//		qo.addAnd();
//		qo.AddWhere(MapAttrAttr.UIVisible, true);
//		qo.addOrderBy(MapAttrAttr.GroupID, MapAttrAttr.IDX);
//		qo.DoQuery();
//
//		groups = new GroupFields();
//		qo = new QueryObject(groups);
//		qo.AddWhere(GroupFieldAttr.EnName, getFK_MapData());
//		qo.addOrderBy(GroupFieldAttr.Idx);
//		qo.DoQuery();
//
//		dtls = new MapDtls();
//		qo = new QueryObject(dtls);
//		qo.AddWhere(MapDtlAttr.FK_MapData, getFK_MapData());
//		qo.addAnd();
//		qo.AddWhere(MapDtlAttr.IsView, true);
//		qo.addOrderBy(MapDtlAttr.RowIdx);
//		qo.DoQuery();
//
//		///#endregion
//
//		BindData();
//	}
//
//	/** 
//	 加载数据
//	 
//	*/
//	private void BindData()
//	{
//		Object tempVar = mapdatas.GetEntityByKey(getFK_MapData());
//		MapData mapdata = (MapData)((tempVar instanceof MapData) ? tempVar : null);
//		DataTable dt = attrs.ToDataTableField("dtAttrs");
//		DataTable dtGroups = groups.ToDataTableField("dtGroups");
//		DataTable dtNoGroupAttrs = null;
//		DataRow[] rows = null;
//		DataRow[] grps = null;
//		LinkButton btn = null;
//		DDL ddl = null;
//		int idx = 1;
//		int gidx = 1;
//	
//		if (mapdata != null)
//		{
////ORIGINAL LINE: pub1.AddEasyUiPanelInfoBegin(mapdata.Name + "[" + mapdata.No + "]字段排序", padding: 5);
//			pub1.AddEasyUiPanelInfoBegin(mapdata.getName() + "[" + mapdata.getNo() + "]字段排序", StringHelper.padding: 5);
//			pub1.append(BaseModel.AddTable());
//			pub1.append(BaseModel.AddUL());
//
//			///#region 标题行
//
//			pub1.append(BaseModel.AddTR());
//			pub1.append(BaseModel.AddTDGroupTitle("style='width:40px;text-align:center'", "序"));
//			pub1.append(BaseModel.AddTDGroupTitle("style='width:100px;'", "字段名称"));
//			pub1.append(BaseModel.AddTDGroupTitle("style='width:160px;'", "中文描述"));
//			pub1.append(BaseModel.AddTDGroupTitle("style='width:160px;'", "字段分组"));
//			pub1.append(BaseModel.AddTDGroupTitle("字段排序"));
//			pub1.append(BaseModel.AddTREnd());
//
//
//			///#endregion
//
//			//分组
//			grps = dtGroups.Select(String.format("EnName='%1$s'", getFK_MapData().toString()));
//
//			//检索全部字段，查找出没有分组或分组信息不正确的字段，存入"无分组"集合
//			dtNoGroupAttrs = dt.clone();
//
//			for (DataRow dr : dt.Rows)
//			{
//				if (IsExistInDataRowArray(grps, GroupFieldAttr.OID, dr.get(MapAttrAttr.GroupID)) == false)
//				{
//					dtNoGroupAttrs.Rows.add(dr.ItemArray);
//				}
//			}
//
//			for (DataRow drGrp : grps)
//			{
//				//分组中的字段
//				rows = dt.Select(String.format("FK_MapData = '%1$s' AND GroupID = %2$s", getFK_MapData().toString(), drGrp.get("OID")));
//
//
//				///#region 分组行
//
//				pub1.append(BaseModel.AddTR());
//				pub1.append(BaseModel.AddTDBegin("colspan='5' class='GroupTitle'"));
//
//				if (gidx > 1)
//				{
//					btn = new LinkButton(false, "Btn_Group_Up_" + grps.length + "_" + gidx + "_" + drGrp.get("Idx") + "_0_" + drGrp.get("OID"), "上移");
//					btn.SetDataOption("iconCls", "'icon-up'");
//
//					btn.Click += btn_Click;
//					pub1.append((btn));
//				}
//
//				if (gidx < grps.length)
//				{
//					btn = new LinkButton(false, "Btn_Group_Down_" + grps.length + "_" + gidx + "_" + drGrp.get("Idx") + "_0_" + drGrp.get("OID"), "下移");
//					btn.SetDataOption("iconCls", "'icon-down'");
//
//					btn.Click += btn_Click;
//					pub1.append(btn);
//				}
//
//				pub1.append(BaseModel.AddSpace(1));
//				pub1.append("<a href=\"javascript:GroupField('" + this.getFK_MapData() + "','" + drGrp.get("OID") + "')\" >分组：" + drGrp.get("Lab") + "</a>");
//
//				pub1.append(BaseModel.AddTDEnd());
//				pub1.append(BaseModel.AddTREnd());
//
//
//				///#endregion
//
//				idx = 1;
//
//				for (DataRow row : rows)
//				{
//
//					///#region 字段行
//
//					ddl = new DDL();
//					ddl.setId("DDL_Group_" + drGrp.get(GroupFieldAttr.OID) + "_" + row.get(MapAttrAttr.KeyOfEn));
//
//					for (DataRow rowGroup : grps)
//					{
//						ddl.Items.add(new ListItem(rowGroup.get(GroupFieldAttr.Lab).toString(), rowGroup.get(GroupFieldAttr.OID).toString()));
//					}
//
//					ddl.AutoPostBack = true;
//
//					ddl.SelectedIndexChanged += ddl_SelectedIndexChanged;
//					ddl.SetSelectItem((int)drGrp.get(GroupFieldAttr.OID));
//
//					pub1.append(BaseModel.AddTR());
//					pub1.append(BaseModel.AddTD("style='text-align:center'", (new Integer(idx)).toString()));
//					pub1.append(BaseModel.AddTD(String.format("<a href='javascript:ShowEditWindow(\"%1$s\",\"%2$s\")'>%3$s</a>", row.get(MapAttrAttr.Name), GenerateEditUrl(row), row.get(MapAttrAttr.KeyOfEn))));
//					pub1.append(BaseModel.AddTD(row.get(MapAttrAttr.Name).toString()));
//					pub1.append(BaseModel.AddTD(ddl));
//					pub1.append(BaseModel.AddTDBegin());
//
//					if (idx > 1)
//					{
//						btn = new LinkButton(false, "Btn_Attr_Up_" + rows.length + "_" + idx + "_" + row.get("Idx") + "_" + gidx + "_" + row.get("KeyOfEn"), "上移");
//						btn.SetDataOption("iconCls", "'icon-up'");
//
//						btn.Click += btn_Click;
//						pub1.append(btn);
//					}
//
//					if (idx < rows.length)
//					{
//						btn = new LinkButton(false, "Btn_Attr_Down_" + rows.length + "_" + idx + "_" + row.get("Idx") + "_" + gidx + "_" + row.get("KeyOfEn"), "下移");
//						btn.SetDataOption("iconCls", "'icon-down'");
//
//						btn.Click += btn_Click;
//						pub1.append(btn);
//					}
//
//					pub1.append(BaseModel.AddTDEnd());
//					pub1.append(BaseModel.AddTREnd());
//
//
//					///#endregion
//
//					idx++;
//				}
//
//				//如果此分组下没有字段，则显示无字段消息
//				if (rows.length == 0)
//				{
//
//					///#region 该分组下面没有任何字段
//					pub1.append(BaseModel.AddTR());
//					pub1.append(BaseModel.AddTDBegin("colspan='5' style='color:red'"));
//					pub1.append(BaseModel.AddSpace(1));
//					pub1.append("该分组下面没有任何字段");
//					pub1.append(BaseModel.AddTDEnd());
//					pub1.append(BaseModel.AddTREnd());
//
//					///#endregion
//				}
//
//				gidx++;
//			}
//
//			//如果含有未分组字段，则显示在下方
//			if (dtNoGroupAttrs.Rows.size() > 0)
//			{
//
//				///#region 分组行
//				pub1.append(BaseModel.AddTR());
//				pub1.append(BaseModel.AddTDBegin("colspan='5' class='GroupTitle'"));
//				pub1.append(BaseModel.AddSpace(1));
//				pub1.append("未分组字段");
//				pub1.append(BaseModel.AddTDEnd());
//				pub1.append(BaseModel.AddTREnd());
//
//				///#endregion
//
//				idx = 1;
//
//				for (DataRow row : dtNoGroupAttrs.Rows)
//				{
//
//					///#region 字段行
//
//					ddl = new DDL();
//					ddl.setId("DDL_Group_" + (((row.get(MapAttrAttr.GroupID) != null) ? row.get(MapAttrAttr.GroupID) : "") + "_" + row.get(MapAttrAttr.KeyOfEn)));
//					ddl.Items.add(new ListItem("请选择分组", ""));
//
//					for (DataRow rowGroup : grps)
//					{
//						ddl.Items.add(new ListItem(rowGroup.get(GroupFieldAttr.Lab).toString(), rowGroup.get(GroupFieldAttr.OID).toString()));
//					}
//
//					ddl.AutoPostBack = true;
//
//					ddl.SelectedIndexChanged += ddl_SelectedIndexChanged;
//
//					pub1.append(BaseModel.AddTR());
//					pub1.append(BaseModel.AddTD("style='text-align:center'", (new Integer(idx)).toString()));
//					pub1.append(BaseModel.AddTD(String.format("<a href='javascript:ShowEditWindow(\"%1$s\",\"%2$s\")'>%3$s</a>", row.get(MapAttrAttr.Name), GenerateEditUrl(row), row.get(MapAttrAttr.KeyOfEn))));
//					pub1.append(BaseModel.AddTD(row.get(MapAttrAttr.Name).toString()));
//					pub1.append(BaseModel.AddTD(ddl));
//					pub1.append(BaseModel.AddTD("&nbsp;"));
//					pub1.append(BaseModel.AddTREnd());
//
//
//					///#endregion
//
//					idx++;
//				}
//			}
//
//			pub1.append(BaseModel.AddTableEnd());
//			pub1.append(BaseModel.AddEasyUiPanelInfoEnd());
//			pub1.append(BaseModel.AddBR());
//
//
//			///#region //检测是否含有明细表，对明细表做排序
//			if (dtls.size() > 0)
//			{
////ORIGINAL LINE: pub1.AddEasyUiPanelInfoBegin("明细表排序", padding: 5);
//				pub1.AddEasyUiPanelInfoBegin("明细表排序", padding: 5);
//				pub1.append(BaseModel.AddTable("class='Table' border='0' cellpadding='0' cellspacing='0' style='width:100%'"));
//
//
//				///#region 标题行
//
//				pub1.append(BaseModel.AddTR());
//				pub1.append(BaseModel.AddTDGroupTitle("style='width:40px;text-align:center'", "序"));
//				pub1.append(BaseModel.AddTDGroupTitle("style='width:100px;'", "明细表编号"));
//				pub1.append(BaseModel.AddTDGroupTitle("style='width:160px;'", "中文名称"));
//				pub1.append(BaseModel.AddTDGroupTitle("排序"));
//				pub1.append(BaseModel.AddTREnd());
//
//
//				///#endregion
//
//				idx = 1;
//
//				for (MapDtl dtl : dtls.ToJavaList())
//				{
//
//					///#region 字段行
//
//					pub1.append(BaseModel.AddTR());
//					pub1.append(BaseModel.AddTD("style='text-align:center'", (new Integer(idx)).toString()));
//					pub1.append(BaseModel.AddTD("<a href=\"javascript:EditDtl('" + this.getFK_MapData() + "','" + dtl.getNo() + "')\" >" + dtl.getNo()+ "</a>"));
//					pub1.append(BaseModel.AddTD(dtl.getName()));
//					pub1.append(BaseModel.AddTDBegin());
//
//					if (idx > 1)
//					{
//						btn = new LinkButton(false, "Btn_Dtl_Up_" + dtls.size() + "_" + idx + "_" + dtl.getRowIdx() + "_0_" + dtl.getNo(), "上移");
//						btn.SetDataOption("iconCls", "'icon-up'");
//
//						btn.Click += btn_Click;
//						pub1.append(btn);
//					}
//
//					if (idx < dtls.size())
//					{
//						btn = new LinkButton(false, "Btn_Dtl_Down_" + dtls.size() + "_" + idx + "_" + dtl.getRowIdx() + "_0_" + dtl.getNo(), "下移");
//						btn.SetDataOption("iconCls", "'icon-down'");
//
//						btn.Click += btn_Click;
//						pub1.append(btn);
//					}
//
//					pub1.append(BaseModel.AddSpace(1));
//					String tempVar2 = getFK_Flow();
//					pub1.Add(String.format("<a href='%1$s' target='_self' class='easyui-linkbutton' data-options=\"iconCls:'icon-sheet'\">字段排序</a>", request.Path + "?FK_Flow=" + ((tempVar2 != null) ? tempVar2 : "") + "&FK_MapData=" + dtl.getNo() + "&t=" + new java.util.Date(("yyyyMMddHHmmssffffff"))));
//
//					pub1.append(BaseModel.AddTDEnd());
//					pub1.append(BaseModel.AddTREnd());
//
//
//					///#endregion
//
//					idx++;
//				}
//
//				pub1.append(BaseModel.AddTableEnd());
//				pub1.append(BaseModel.AddEasyUiPanelInfoEnd());
//				pub1.append(BaseModel.AddBR());
//			}
//
//			///#endregion
//
//
//			///#region //如果是明细表的字段排序，则增加"返回"按钮；否则增加"复制排序"按钮,2016-03-21
//
//			MapDtl tdtl = new MapDtl();
//			tdtl.setNo(getFK_MapData());
//			if (tdtl.RetrieveFromDBSources() == 1)
//			{
//				String tempVar3 = getFK_Flow();
//				pub1.Add(String.format("<a href='%1$s' target='_self' class='easyui-linkbutton' data-options=\"iconCls:'icon-back'\">返回</a>", request.Path + "?FK_Flow=" + ((tempVar3 != null) ? tempVar3 : "") + "&FK_MapData=" + tdtl.getFK_MapData() + "&t=" + new java.util.Date("yyyyMMddHHmmssffffff")));
//			}
//			else
//			{
//				pub1.append(BaseModel.Add("<a href='javascript:void(0)' onclick=\"Form_View('" + this.getFK_MapData() + "','" + this.getFK_Flow() + "');\" class='easyui-linkbutton' data-options=\"iconCls:'icon-search'\">预览</a>"));
//				pub1.append(BaseModel.Add("<a href='javascript:void(0)' onclick=\"$('#nodes').dialog('open');\" class='easyui-linkbutton' data-options=\"iconCls:'icon-copy'\">复制排序</a>"));
//				pub1.append(BaseModel.Add("&nbsp;<a href='javascript:void(0)' onclick=\"GroupFieldNew('" + this.getFK_MapData() + "')\" class='easyui-linkbutton' data-options=\"iconCls:'icon-addfolder'\">新建分组</a>"));
//				pub1.append(BaseModel.AddBR());
//				pub1.append(BaseModel.AddBR());
//
//				pub1.append(BaseModel.Add("<div id='nodes' class='easyui-dialog' data-options=\"title:'选择复制到节点（多选）:',closed:true,buttons:'#btns'\" style='width:280px;height:340px'>"));
//
//				ListBox lb = new ListBox();
//				lb.getStyle().Add("width", "100%");
//				lb.Style.Add("Height", "100%");
//				lb.SelectionMode = ListSelectionMode.Multiple;
//				lb.BorderStyle = BorderStyle.None;
//				lb.setId( "lbNodes");
//
//				Nodes nodes = new Nodes();
//				nodes.Retrieve(BP.WF.Template.NodeAttr.FK_Flow, getFK_Flow(), BP.WF.Template.NodeAttr.Step);
//
//				if (nodes.size() == 0)
//				{
//					String nodeid = getFK_MapData().replace("ND", "");
//					String flowno = "";
//
//					if (nodeid.length() > 2)
//					{
//						flowno = nodeid.substring(0, nodeid.length() - 2).StringHelper.PadLeft(String.valueOf(3, '0'));
//						nodes.Retrieve(BP.WF.Template.NodeAttr.FK_Flow, flowno, BP.WF.Template.NodeAttr.Step);
//					}
//				}
//
//				ListItem item = null;
//
//				for (BP.WF.Node node : nodes.ToJavaList())
//				{
//					item = new ListItem(String.format("(%1$s)%2$s", node.getNodeID(), node.getName()), node.NodeID.toString());
//
//					if ("ND" + getFK_MapData().equals(node.getNodeID()) != null)
//					{
//						item.attributes.put("disabled", "disabled");
//					}
//
//					lb.Items.add(item);
//				}
//
//				pub1.append(lb);
//				pub1.append(BaseModel.AddDivEnd());
//
//				pub1.append("<div id='btns'>");
//
//				LinkButton lbtn = new LinkButton(false, NamesOfBtn.Copy.toString(), "复制");
//				lbtn.OnClientClick = "var v = $('#" + lb.ClientID + "').val(); if(!v) { alert('请选择将此排序复制到的节点！'); return false; } else { $('#" + hidCopyNodes.ClientID + "').val(v); return true; }";
//
//				lbtn.Click += new EventHandler(lbtn_Click);
//				pub1.append(lbtn);
//				lbtn = new LinkButton(false, NamesOfBtn.Cancel.toString(), "取消");
//				lbtn.OnClientClick = "$('#nodes').dialog('close');";
//				pub1.append(lbtn);
//
//				pub1.append(BaseModel.AddDivEnd());
//			}
//
//			///#endregion
//		}
//	}
//
//
//		///#region 排序复制功能
//
//	private void lbtn_Click(Object sender)
//	{
//		if (String.IsNullOrWhiteSpace(hidCopyNodes.getValue()))
//		{
//			return;
//		}
//
//		String[] nodeids = hidCopyNodes.getValue().split("[,]", -1);
//		String tmd = null;
//		GroupField group = null;
//		MapDatas tmapdatas = null;
//		MapAttrs tattrs = null, oattrs = null, tarattrs = null;
//		GroupFields tgroups = null, ogroups = null, targroups = null;
//		MapDtls tdtls = null;
//		MapData tmapdata = null;
//		MapAttr tattr = null;
//		GroupField tgrp = null;
//		MapDtl tdtl = null;
//		int maxGrpIdx = 0; //当前最大分组排序号
//		int maxAttrIdx = 0; //当前最大字段排序号
//		int maxDtlIdx = 0; //当前最大明细表排序号
//		java.util.ArrayList<String> idxGrps = new java.util.ArrayList<String>(); //复制过的分组名称集合
//		java.util.ArrayList<String> idxAttrs = new java.util.ArrayList<String>(); //复制过的字段编号集合
//		java.util.ArrayList<String> idxDtls = new java.util.ArrayList<String>(); //复制过的明细表编号集合
//
//		for (String nodeid : nodeids)
//		{
//			tmd = "ND" + nodeid;
//
//
//			///#region 获取数据
//			tmapdatas = new MapDatas();
//			QueryObject qo = new QueryObject(tmapdatas);
//			qo.AddWhere(MapDataAttr.No, "Like", tmd + "%");
//			qo.addOrderBy(MapDataAttr.Idx);
//			qo.DoQuery();
//
//			tattrs = new MapAttrs();
//			qo = new QueryObject(tattrs);
//			qo.AddWhere(MapAttrAttr.FK_MapData, tmd);
//			qo.addAnd();
//			qo.AddWhere(MapAttrAttr.UIVisible, true);
//			qo.addOrderBy(MapAttrAttr.GroupID, MapAttrAttr.IDX);
//			qo.DoQuery();
//
//			tgroups = new GroupFields();
//			qo = new QueryObject(tgroups);
//			qo.AddWhere(GroupFieldAttr.EnName, tmd);
//			qo.addOrderBy(GroupFieldAttr.Idx);
//			qo.DoQuery();
//
//			tdtls = new MapDtls();
//			qo = new QueryObject(tdtls);
//			qo.AddWhere(MapDtlAttr.FK_MapData, tmd);
//			qo.addAnd();
//			qo.AddWhere(MapDtlAttr.IsView, true);
//			qo.addOrderBy(MapDtlAttr.RowIdx);
//			qo.DoQuery();
//
//			///#endregion
//
//
//			///#region 复制排序逻辑
//
//
//			///#region //分组排序复制
//			for (GroupField grp : groups.ToJavaList())
//			{
//				//通过分组名称来确定是同一个组，同一个组在不同的节点分组编号是不一样的
//				Object tempVar = tgroups.GetEntityByKey(GroupFieldAttr.Lab, grp.getLab());
//				tgrp = (GroupField)((tempVar instanceof GroupField) ? tempVar : null);
//				if (tgrp == null)
//				{
//					continue;
//				}
//
//				tgrp.setIdx(grp.getIdx());
//				tgrp.DirectUpdate();
//
//				maxGrpIdx = Math.max(grp.getIdx(), maxGrpIdx);
//				idxGrps.add(grp.getLab());
//			}
//
//			for (GroupField grp : tgroups.ToJavaList())
//			{
//				if (idxGrps.contains(grp.getLab()))
//				{
//					continue;
//				}
//
//				grp.setIdx(maxGrpIdx = maxGrpIdx + 1);
//				grp.DirectUpdate();
//			}
//
//			///#endregion
//
//
//			///#region //字段排序复制
//			for (MapAttr attr : attrs.ToJavaList())
//			{
//				//排除主键
//				if (attr.getIsPK() == true)
//				{
//					continue;
//				}
//
//				Object tempVar2 = tattrs.GetEntityByKey(MapAttrAttr.KeyOfEn, attr.getKeyOfEn());
//				tattr = (MapAttr)((tempVar2 instanceof MapAttr) ? tempVar2 : null);
//				if (tattr == null)
//				{
//					continue;
//				}
//
//				Object tempVar3 = groups.GetEntityByKey(GroupFieldAttr.OID, attr.getGroupID());
//				group = (GroupField)((tempVar3 instanceof GroupField) ? tempVar3 : null);
//
//				//比对字段的分组是否一致，不一致则更新一致
//				if (group == null)
//				{
//					//源字段分组为空，则目标字段分组置为0
//					tattr.setGroupID(0);
//				}
//				else
//				{
//					//此处要判断目标节点中是否已经创建了这个源字段所属分组，如果没有创建，则要自动创建
//					Object tempVar4 = tgroups.GetEntityByKey(GroupFieldAttr.Lab, group.getLab());
//					tgrp = (GroupField)((tempVar4 instanceof GroupField) ? tempVar4 : null);
//
//					if (tgrp == null)
//					{
//						tgrp = new GroupField();
//						tgrp.setLab(group.getLab());
//						tgrp.setEnName(tmd);
//						tgrp.setIdx(group.getIdx());
//						tgrp.Insert();
//						tgroups.AddEntity(tgrp);
//
//						tattr.setGroupID((int) tgrp.getOID());
//					}
//					else
//					{
//						if (tgrp.getOID() != tattr.getGroupID())
//						{
//							tattr.setGroupID((int) tgrp.getOID());
//						}
//					}
//				}
//
//				tattr.setIDX(attr.getIDX());
//				tattr.DirectUpdate();
//				maxAttrIdx = Math.max(attr.getIDX(), maxAttrIdx);
//				idxAttrs.add(attr.getKeyOfEn());
//			}
//
//			for (MapAttr attr : tattrs.ToJavaList())
//			{
//				//排除主键
//				if (attr.getIsPK() == true)
//				{
//					continue;
//				}
//				if (idxAttrs.contains(attr.getKeyOfEn()))
//				{
//					continue;
//				}
//
//				attr.setIDX( maxAttrIdx = maxAttrIdx + 1);
//				attr.DirectUpdate();
//			}
//
//			///#endregion
//
//
//			///#region //明细表排序复制
//			String dtlIdx = "";
//
//			for (MapDtl dtl : dtls.ToJavaList())
//			{
//				dtlIdx = dtl.getNo().replace(dtl.getFK_MapData() + "Dtl", "");
//				Object tempVar5 = tdtls.GetEntityByKey(MapDtlAttr.No, tmd + "Dtl" + dtlIdx);
//				tdtl = (MapDtl)((tempVar5 instanceof MapDtl) ? tempVar5 : null);
//
//				if (tdtl == null)
//				{
//					continue;
//				}
//
//
//				///#region 1.明细表排序
//				if (tdtl.getRowIdx() != dtl.getRowIdx())
//				{
//					tdtl.setRowIdx(dtl.getRowIdx());
//					tdtl.DirectUpdate();
//
//					Object tempVar6 = tmapdatas.GetEntityByKey(MapDataAttr.No, tdtl.getNo());
//					tmapdata = (MapData)((tempVar6 instanceof MapData) ? tempVar6 : null);
//					if (tmapdata != null)
//					{
//						tmapdata.setIdx(dtl.getRowIdx());
//						tmapdata.DirectUpdate();
//					}
//				}
//
//				maxDtlIdx = Math.max(tdtl.getRowIdx(), maxDtlIdx);
//				idxDtls.add(dtl.getNo());
//
//				///#endregion
//
//
//				///#region 2.获取源节点明细表中的字段分组、字段信息
//				oattrs = new MapAttrs();
//				qo = new QueryObject(oattrs);
//				qo.AddWhere(MapAttrAttr.FK_MapData, dtl.getNo());
//				qo.addAnd();
//				qo.AddWhere(MapAttrAttr.UIVisible, true);
//				qo.addOrderBy(MapAttrAttr.GroupID, MapAttrAttr.IDX);
//				qo.DoQuery();
//
//				ogroups = new GroupFields();
//				qo = new QueryObject(ogroups);
//				qo.AddWhere(GroupFieldAttr.EnName, dtl.getNo());
//				qo.addOrderBy(GroupFieldAttr.Idx);
//				qo.DoQuery();
//
//				///#endregion
//
//
//				///#region 3.获取目标节点明细表中的字段分组、字段信息
//				tarattrs = new MapAttrs();
//				qo = new QueryObject(tarattrs);
//				qo.AddWhere(MapAttrAttr.FK_MapData, tdtl.getNo());
//				qo.addAnd();
//				qo.AddWhere(MapAttrAttr.UIVisible, true);
//				qo.addOrderBy(MapAttrAttr.GroupID, MapAttrAttr.IDX);
//				qo.DoQuery();
//
//				targroups = new GroupFields();
//				qo = new QueryObject(targroups);
//				qo.AddWhere(GroupFieldAttr.EnName, tdtl.getNo());
//				qo.addOrderBy(GroupFieldAttr.Idx);
//				qo.DoQuery();
//
//				///#endregion
//
//
//				///#region 4.明细表字段分组排序
//				maxGrpIdx = 0;
//				idxGrps = new java.util.ArrayList<String>();
//
//				for (GroupField grp : ogroups.ToJavaList())
//				{
//					//通过分组名称来确定是同一个组，同一个组在不同的节点分组编号是不一样的
//					Object tempVar7 = targroups.GetEntityByKey(GroupFieldAttr.Lab, grp.getLab());
//					tgrp = (GroupField)((tempVar7 instanceof GroupField) ? tempVar7 : null);
//					if (tgrp == null)
//					{
//						continue;
//					}
//
//					tgrp.setIdx(grp.getIdx());
//					tgrp.DirectUpdate();
//
//					maxGrpIdx = Math.max(grp.getIdx(), maxGrpIdx);
//					idxGrps.add(grp.getLab());
//				}
//
//				for (GroupField grp : targroups.ToJavaList())
//				{
//					if (idxGrps.contains(grp.getLab()))
//					{
//						continue;
//					}
//
//					grp.setIdx(maxGrpIdx = maxGrpIdx + 1);
//					grp.DirectUpdate();
//				}
//
//				///#endregion
//
//
//				///#region 5.明细表字段排序
//				maxAttrIdx = 0;
//				idxAttrs = new java.util.ArrayList<String>();
//
//				for (MapAttr attr : oattrs.ToJavaList())
//				{
//					Object tempVar8 = tarattrs.GetEntityByKey(MapAttrAttr.KeyOfEn, attr.getKeyOfEn());
//					tattr = (MapAttr)((tempVar8 instanceof MapAttr) ? tempVar8 : null);
//					if (tattr == null)
//					{
//						continue;
//					}
//
//					Object tempVar9 = ogroups.GetEntityByKey(GroupFieldAttr.OID, attr.getGroupID());
//					group = (GroupField)((tempVar9 instanceof GroupField) ? tempVar9 : null);
//
//					//比对字段的分组是否一致，不一致则更新一致
//					if (group == null)
//					{
//						//源字段分组为空，则目标字段分组置为0
//						tattr.setGroupID(0);
//					}
//					else
//					{
//						//此处要判断目标节点中是否已经创建了这个源字段所属分组，如果没有创建，则要自动创建
//						Object tempVar10 = targroups.GetEntityByKey(GroupFieldAttr.Lab, group.getLab());
//						tgrp = (GroupField)((tempVar10 instanceof GroupField) ? tempVar10 : null);
//
//						if (tgrp == null)
//						{
//							tgrp = new GroupField();
//							tgrp.setLab(group.getLab());
//							tgrp.setEnName(tdtl.getNo());
//							tgrp.setIdx(group.getIdx());
//							tgrp.Insert();
//							targroups.AddEntity(tgrp);
//
//							tattr.setGroupID((int) tgrp.getOID());
//						}
//						else
//						{
//							if (tgrp.getOID() != tattr.getGroupID())
//							{
//								tattr.setGroupID((int) tgrp.getOID());
//							}
//						}
//					}
//
//					tattr.setIDX(attr.getIDX());
//					tattr.DirectUpdate();
//					maxAttrIdx = Math.max(attr.getIDX(), maxAttrIdx);
//					idxAttrs.add(attr.getKeyOfEn());
//				}
//
//				for (MapAttr attr : tarattrs.ToJavaList())
//				{
//					if (idxAttrs.contains(attr.getKeyOfEn()))
//					{
//						continue;
//					}
//
//					attr.setIDX(maxAttrIdx = maxAttrIdx + 1);
//					attr.DirectUpdate();
//				}
//
//				///#endregion
//			}
//
//			for (MapDtl dtl : tdtls.ToJavaList())
//			{
//				if (idxDtls.contains(dtl.getNo()))
//				{
//					continue;
//				}
//
//				dtl.setRowIdx(maxDtlIdx = maxDtlIdx + 1);
//				dtl.DirectUpdate();
//
//				Object tempVar11 = tmapdatas.GetEntityByKey(MapDataAttr.No, dtl.getNo());
//				tmapdata = (MapData)((tempVar11 instanceof MapData) ? tempVar11 : null);
//				if (tmapdata != null)
//				{
//					tmapdata.setIdx(dtl.getRowIdx());
//					tmapdata.DirectUpdate();
//				}
//			}
//
//			///#endregion
//
//
//			///#endregion
//		}
//
//		//重新加载本页
//		String tempVar12 = getFK_Flow();
//		response.sendRedirect(request.getLocalAddr() + "?FK_Flow=" + ((tempVar12 != null) ? tempVar12 : "") + "&FK_MapData=" + getFK_MapData() + "&t=" + new java.util.Date("yyyyMMddHHmmssffffff"));
//	}
//
//		///#endregion
//
//
//		///#region 字段分组调整
//
//	private void ddl_SelectedIndexChanged(Object sender)
//	{
//		DDL ddl = (DDL)((sender instanceof DDL) ? sender : null);
//		MapAttr attr = null;
//		String key = null;
//		int newGrpId = 0;
//		DataTable dt = null;
//		DataRow rows = null;
//		String[] ids = ddl.getId().split("[_]", -1); //如：DDL_Group_102_XingMing
//
//		if (ids.length < 4)
//		{
//			return;
//		}
//
//		key = ddl.getId().substring(ids[0].length() + ids[1].length() + ids[2].length() + 3);
//		Object tempVar = attrs.GetEntityByKey(MapAttrAttr.FK_MapData, getFK_MapData(), MapAttrAttr.KeyOfEn, key);
//		attr = (MapAttr)((tempVar instanceof MapAttr) ? tempVar : null);
//
//		if (attr == null)
//		{
//			return;
//		}
//
//		newGrpId = ddl.getSelectedItemIntVal();
//		dt = attrs.ToDataTableField("dtAttrs");
//		rows = dt.Select(String.format("FK_MapData = '%1$s' AND GroupID = %2$s", getFK_MapData(), newGrpId), "Idx DESC");
//
//		attr.setGroupID(newGrpId);
//		attr.setIDX((rows.size() > 0 ?Integer.parseInt(rows.get("Idx").toString()) : 0) + 1);
//		
//		
//
//		attr.DirectUpdate();
//
//		//重新加载本页
//		String tempVar2 = getFK_Flow();
//		response.Redirect(request.getPath() + "?FK_Flow=" + ((tempVar2 != null) ? tempVar2 : "") + "&FK_MapData=" + getFK_MapData() + "&t=" + new java.util.Date("yyyyMMddHHmmssffffff"));
//	}
//
//		///#endregion
//
//
//		///#region 字段排序
//
//	@SuppressWarnings("deprecation")
//	private void btn_Click(Object sender)
//	{
//		LinkButton btn = (LinkButton)((sender instanceof LinkButton) ? sender : null);
//		MoveBtnIds ids = new MoveBtnIds(btn.getId());
//		MoveBtnIds tids = null;
//		LinkButton tbtn = null;
//		GroupField group = null;
//		MapAttr attr = null;
//		MapData mapdata = null;
//		MapDtl dtl = null;
//		java.util.ArrayList<String> keys = new java.util.ArrayList<String>();
//		int targetIdx;
//
//		if (!ids.getSuccess())
//		{
//			return;
//		}
//
//		targetIdx = ids.getMoveDirection().equals("Up") ? ids.getIdx() - 1 : ids.getIdx() + 1;
//
////C# TO JAVA CONVERTER NOTE: The following 'switch' operated on a string member and was converted to Java 'if-else' logic:
////		switch (ids.ObjectType)
////ORIGINAL LINE: case "Group":
//		if (ids.getObjectType().equals("Group"))
//		{
//
//				///#region 字段分组
//				//检测所有的分组，判断原有idx与现在idx是否匹配，不匹配的都进行更新，第一次进行排序时，将原有的idx都更新一遍
//				for (Control ctrl : pub1.Controls)
//				{
//					tbtn = (LinkButton)((ctrl instanceof LinkButton) ? ctrl : null);
//					if (tbtn == null || !tbtn.getId().startsWith("Btn_Group_"))
//					{
//						continue;
//					}
//
//					tids = new MoveBtnIds(ctrl.ID);
//					if (!tids.getSuccess() || keys.contains(tids.getKey()))
//					{
//						continue;
//					}
//
//					keys.add(tids.getKey());
//
//					if (tids.getIdx() == targetIdx)
//					{
//						//受影响的组索引号更改为当前移动组的索引号
//						if (tids.getOldIdx() != ids.getIdx())
//						{
//							//更新GroupField中的索引
//							Object tempVar = groups.GetEntityByKey(Integer.parseInt(tids.getKey()));
//							group = (GroupField)((tempVar instanceof GroupField) ? tempVar : null);
//							group.setIdx(ids.getIdx());
//							group.Update();
//						}
//					}
//					else if (tids.getIdx() == ids.getIdx())
//					{
//						//当前移动组的索引号改为受影响的组索引号
//						if (tids.getOldIdx() != targetIdx)
//						{
//							//更新GroupField中的索引
//							Object tempVar2 = groups.GetEntityByKey(Integer.parseInt(tids.getKey()));
//							group = (GroupField)((tempVar2 instanceof GroupField) ? tempVar2 : null);
//							group.setIdx(targetIdx);
//							group.Update();
//						}
//					}
//					else
//					{
//						//检索其余未受影响的组，将与之对应的索引号不一样的均更新
//						if (tids.getOldIdx() != tids.getIdx())
//						{
//							//更新GroupField中的索引
//							Object tempVar3 = groups.GetEntityByKey(Integer.parseInt(tids.getKey()));
//							group = (GroupField)((tempVar3 instanceof GroupField) ? tempVar3 : null);
//							group.setIdx(tids.getIdx());
//							group.Update();
//						}
//					}
//				}
//
//				///#endregion
//		}
////ORIGINAL LINE: case "Attr":
//		else if (ids.getObjectType().equals("Attr"))
//		{
//
//				///#region 字段
//				//检测所有的字段，判断原有idx与现在idx是否匹配，不匹配的都进行更新，第一次进行排序时，将原有的idx都更新一遍
//				for (Control ctrl : pub1.Controls)
//				{
//					tbtn = (LinkButton)((ctrl instanceof LinkButton) ? ctrl : null);
//					if (tbtn == null || !tbtn.getId().startsWith("Btn_Attr_"))
//					{
//						continue;
//					}
//
//					tids = new MoveBtnIds(ctrl.ID);
//					if (!tids.getSuccess() || keys.contains(tids.getKey()))
//					{
//						continue;
//					}
//
//					keys.add(tids.getKey());
//
//					if (tids.getIdx() == targetIdx && tids.getGroupIdx() == ids.getGroupIdx())
//					{
//						//受影响的字段索引号更改为当前移动字段的索引号
//						if (tids.getOldIdx() != ids.getIdx())
//						{
//							//更新MapAttr中的索引
//							Object tempVar4 = attrs.GetEntityByKey(MapAttrAttr.FK_MapData, getFK_MapData(), MapAttrAttr.KeyOfEn, tids.getKey());
//							attr = (MapAttr)((tempVar4 instanceof MapAttr) ? tempVar4 : null);
//							attr.setIDX(ids.getIdx());
//							attr.Update();
//						}
//					}
//					else if (tids.getIdx() == ids.getIdx() && tids.getGroupIdx() == ids.getGroupIdx())
//					{
//						//当前移动字段的索引号改为受影响的字段索引号
//						if (tids.getOldIdx() != targetIdx)
//						{
//							//更新MapAttr中的索引
//							Object tempVar5 = attrs.GetEntityByKey(MapAttrAttr.FK_MapData, getFK_MapData(), MapAttrAttr.KeyOfEn, tids.getKey());
//							attr = (MapAttr)((tempVar5 instanceof MapAttr) ? tempVar5 : null);
//							attr.setIDX(targetIdx);
//							attr.Update();
//						}
//					}
//					else
//					{
//						//检索其余未受影响的字段，将与之对应的索引号不一样的均更新
//						if (tids.getOldIdx() != tids.getIdx())
//						{
//							//更新MapAttr中的索引
//							Object tempVar6 = attrs.GetEntityByKey(MapAttrAttr.FK_MapData, getFK_MapData(), MapAttrAttr.KeyOfEn, tids.getKey());
//							attr = (MapAttr)((tempVar6 instanceof MapAttr) ? tempVar6 : null);
//							attr.setIDX(tids.getIdx());
//							attr.Update();
//						}
//					}
//				}
//
//				///#endregion
//		}
////ORIGINAL LINE: case "Dtl":
//		else if (ids.getObjectType().equals("Dtl"))
//		{
//
//				///#region 明细表
//				//检测所有的明细表，判断原有idx与现在idx是否匹配，不匹配的都进行更新，第一次进行排序时，将原有的idx都更新一遍
//				for (Control ctrl : pub1.Controls)
//				{
//					tbtn = (LinkButton)((ctrl instanceof LinkButton) ? ctrl : null);
//					if (tbtn == null || !tbtn.getId().startsWith("Btn_Dtl_"))
//					{
//						continue;
//					}
//
//					tids = new MoveBtnIds(ctrl.ID);
//					if (!tids.getSuccess() || keys.contains(tids.getKey()))
//					{
//						continue;
//					}
//
//					keys.add(tids.getKey());
//
//					if (tids.getIdx() == targetIdx)
//					{
//						//受影响的明细表索引号更改为当前移动明细表的索引号
//						if (tids.getOldIdx() != ids.getIdx())
//						{
//							//更新MapDtl中的明细表索引
//							Object tempVar7 = dtls.GetEntityByKey(tids.getKey());
//							dtl = (MapDtl)((tempVar7 instanceof MapDtl) ? tempVar7 : null);
//							dtl.setRowIdx(ids.getIdx());
//							dtl.Update();
//
//							//更新MapData中的索引
//							Object tempVar8 = mapdatas.GetEntityByKey(dtl.No);
//							mapdata = (MapData)((tempVar8 instanceof MapData) ? tempVar8 : null);
//							mapdata.setIdx(ids.getIdx());
//							mapdata.Update();
//						}
//					}
//					else if (tids.getIdx() == ids.getIdx())
//					{
//						//当前移动明细表的索引号改为受影响的明细表索引号
//						if (tids.getOldIdx() != targetIdx)
//						{
//							//更新MapDtl中的明细表索引
//							Object tempVar9 = dtls.GetEntityByKey(tids.getKey());
//							dtl = (MapDtl)((tempVar9 instanceof MapDtl) ? tempVar9 : null);
//							dtl.setRowIdx(targetIdx);
//							dtl.Update();
//
//							//更新MapData中的索引
//							Object tempVar10 = mapdatas.GetEntityByKey(dtl.No);
//							mapdata = (MapData)((tempVar10 instanceof MapData) ? tempVar10 : null);
//							mapdata.setIdx(targetIdx);
//							mapdata.Update();
//						}
//					}
//					else
//					{
//						//检索其余未受影响的明细表，将与之对应的索引号不一样的均更新
//						if (tids.getOldIdx() != tids.getIdx())
//						{
//							//更新MapDtl中的明细表索引
//							Object tempVar11 = dtls.GetEntityByKey(tids.getKey());
//							dtl = (MapDtl)((tempVar11 instanceof MapDtl) ? tempVar11 : null);
//							dtl.setRowIdx(tids.getIdx());
//							dtl.Update();
//
//							//更新MapData中的索引
//							Object tempVar12 = mapdatas.GetEntityByKey(dtl.No);
//							mapdata = (MapData)((tempVar12 instanceof MapData) ? tempVar12 : null);
//							mapdata.setIdx(tids.getIdx());
//							mapdata.Update();
//						}
//					}
//				}
//
//				///#endregion
//		}
//
//		//重新加载本页
//		String tempVar13 = getFK_Flow();
//		response.Redirect(request.Path + "?FK_Flow=" + ((tempVar13 != null) ? tempVar13 : "") + "&FK_MapData=" + getFK_MapData() + "&t=" + new java.util.Date("yyyyMMddHHmmssffffff"));
//	}
//
//		///#endregion
//
//	/** 
//	 判断在DataRow数组中，是否存在指定列指定值的行
//	 
//	 @param rows DataRow数组
//	 @param field 指定列名
//	 @param value 指定值
//	 @return 
//	*/
//	private boolean IsExistInDataRowArray(DataRow[] rows, String field, Object value)
//	{
//		for (DataRow row : rows)
//		{
//			if (equals(row.get(field)))
//			{
//				return true;
//			}
//		}
//
//		return false;
//	}
//
//	/** 
//	 根据MapAttr字段行数据，获取该字段的编辑链接
//	 
//	 @param drAttr MapAttr字段行数据
//	 @return 
//	*/
//	private String GenerateEditUrl(DataRow drAttr)
//	{
//		String url = "../../MapDef/";
//
//		switch ((FieldTypeS)drAttr.get(MapAttrAttr.LGType))
//		{
//			case Enum:
//				url += "EditEnum.aspx?MyPK=" + drAttr.get(MapAttrAttr.FK_MapData) + "&RefNo=" + drAttr.get(MapAttrAttr.MyPK);
//				break;
//			case BP.En.FieldTypeS.Normal:
//				url += "EditF.aspx?DoType=Edit&MyPK=" + drAttr.get(MapAttrAttr.FK_MapData) + "&RefNo=" + drAttr.get(MapAttrAttr.MyPK) + "&FType=" + drAttr.get(MapAttrAttr.MyDataType) + "&GroupField=0";
//				break;
//			case BP.En.FieldTypeS.FK:
//				url += "EditTable.aspx?DoType=Edit&MyPK=" + drAttr.get(MapAttrAttr.FK_MapData) + "&RefNo=" + drAttr.get(MapAttrAttr.MyPK) + "&FType=" + drAttr.get(MapAttrAttr.MyDataType) + "&GroupField=0";
//				break;
//			default:
//				url = "javascript:alert('未涉及的字段类型！');void(0);";
//				break;
//		}
//
//		return url;
//	}
//}
