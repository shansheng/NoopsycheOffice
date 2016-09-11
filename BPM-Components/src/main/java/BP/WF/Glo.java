package BP.WF;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

import BP.DA.AtPara;
import BP.DA.DBAccess;
import BP.DA.DBType;
import BP.DA.DataColumn;
import BP.DA.DataRow;
import BP.DA.DataSet;
import BP.DA.DataTable;
import BP.DA.DataType;
import BP.DA.Paras;
import BP.En.Attr;
import BP.En.Attrs;
import BP.En.Entity;
import BP.Port.Emp;
import BP.Sys.DefVal;
import BP.Sys.GEDtl;
import BP.Sys.GEDtlAttr;
import BP.Sys.GEDtls;
import BP.Sys.OSModel;
import BP.Sys.SFDBSrc;
import BP.Sys.SFTable;
import BP.Sys.SystemConfig;
import BP.Sys.ToolbarExcel;
import BP.Sys.Frm.FrmAttachment;
import BP.Sys.Frm.FrmImg;
import BP.Sys.Frm.MapAttr;
import BP.Sys.Frm.MapAttrs;
import BP.Sys.Frm.MapData;
import BP.Sys.Frm.MapDatas;
import BP.Sys.Frm.MapDtl;
import BP.Sys.Frm.MapDtls;
import BP.Sys.Frm.MapExt;
import BP.Sys.Frm.MapExtXmlList;
import BP.Tools.DateUtils;
import BP.Tools.SecurityDES;
import BP.Tools.StringHelper;
import BP.WF.Data.CH;
import BP.WF.Data.CHSta;
import BP.WF.Data.GERpt;
import BP.WF.Data.GERptAttr;
import BP.WF.Rpt.MapRpts;
import BP.WF.Template.CCList;
import BP.WF.Template.Cond;
import BP.WF.Template.Direction;
import BP.WF.Template.FlowAttr;
import BP.WF.Template.FlowSort;
import BP.WF.Template.FlowSorts;
import BP.WF.Template.FrmField;
import BP.WF.Template.FrmNode;
import BP.WF.Template.FrmWorkCheck;
import BP.WF.Template.MapDataExt;
import BP.WF.Template.NodeToolbar;
import BP.WF.Template.SelectAccper;
import BP.WF.Template.SysForm;
import BP.WF.Template.SysFormTree;
import BP.WF.Template.SysFormTrees;
import BP.WF.Template.TransferCustom;
import BP.Web.WebUser;
import cn.jflow.common.util.ContextHolderUtils;
import cn.jflow.controller.wf.admin.xap.service.WSDesignerSoap;
import cn.jflow.controller.wf.admin.xap.service.WSDesignerSoapImpl;

/**
 * 全局(方法处理)
 */
public class Glo {

	// /#region 公共属性.
	/**
	 * 当前选择的流程.
	 */
	public static String getCurrFlow() {
		return ((ContextHolderUtils.getRequest().getParameter("CurrFlow") instanceof String) ? ContextHolderUtils
				.getRequest().getParameter("CurrFlow") : null);
		// (String)((System.Web.HttpContext.Current.Session.get() instanceof
		// String) ? System.Web.HttpContext.Current.Session.get("CurrFlow") :
		// null);
	}

	public static void setCurrFlow(String value) {
		// System.Web.HttpContext.Current.Session.setValue("CurrFlow", value);
		ContextHolderUtils.getRequest().setAttribute("CurrFlow", value);
		;
	}

	/**
	 * 用户编号.
	 */
	public static String UserNo = null;
	/**
	 * 运行平台(用于处理不同的平台，调用不同的URL)
	 */
	public static Plant Plant = BP.WF.Plant.CCFlow;

	// /#endregion 公共属性.

	// /#region 执行安装/升级.
	/**
	 * 执行升级
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String UpdataCCFlowVer() throws Exception {
		// /#region 检查是否需要升级，并更新升级的业务逻辑.
		String val = "20160810";
		 

		/*
		 * 升级版本记录: 20150330: 优化发起列表的效率, by:zhoupeng. 2, 升级表单树,支持动态表单树. 1,
		 * 执行一次Sender发送人的升级，原来由GenerWorkerList 转入WF_GenerWorkFlow. 0,
		 * 静默升级启用日期.2014-12
		 */
		
		// 序列号.
		BP.Sys.Serial se=new  BP.Sys.Serial();
		se.CheckPhysicsTable();
	    
		String sql = "SELECT IntVal FROM Sys_Serial WHERE CfgKey='Ver'";
		String currVer = DBAccess.RunSQLReturnStringIsNull(sql, "");
		 if (val.equals(currVer))
		 {
		     return null; //不需要升级.
		 }
		// /#endregion 检查是否需要升级，并更新升级的业务逻辑.

		String msg = "";
		try {
			
		    BP.Sys.EnCfg cfg=new  BP.Sys.EnCfg();
		    cfg.CheckPhysicsTable();
			
			// 执行升级 2016.04.08
			BP.WF.Template.Cond cnd = new Cond();
			cnd.CheckPhysicsTable();

			// /#region 标签Ext
			sql = "DELETE FROM Sys_EnCfg WHERE No='BP.WF.Template.NodeExt'";
			BP.DA.DBAccess.RunSQL(sql);
			sql = "INSERT INTO Sys_EnCfg(No,GroupTitle) VALUES ('BP.WF.Template.NodeExt','";
			sql += "@NodeID=基本配置";
			sql += "@FWCSta=审核组件,适用于sdk表单审核组件与ccform上的审核组件属性设置.";
			sql += "@SendLab=按钮权限,控制工作节点可操作按钮.";
			sql += "@RunModel=运行模式,分合流,父子流程";
			sql += "@AutoJumpRole0=跳转,自动跳转规则当遇到该节点时如何让其自动的执行下一步.";
			sql += "@MPhone_WorkModel=移动,与手机平板电脑相关的应用设置.";
			sql += "@TSpanDay=考核,时效考核,质量考核.";
			// sql += "@OfficeOpen=公文按钮,只有当该节点是公文流程时候有效";
			sql += "')";
			BP.DA.DBAccess.RunSQL(sql);

			sql = "DELETE FROM Sys_EnCfg WHERE No='BP.WF.Template.FlowExt'";
			BP.DA.DBAccess.RunSQL(sql);
			sql = "INSERT INTO Sys_EnCfg(No,GroupTitle) VALUES ('BP.WF.Template.FlowExt','";
			sql += "@No=基本配置";
			sql += "')";
			BP.DA.DBAccess.RunSQL(sql);

			sql = "DELETE FROM Sys_EnCfg WHERE No='BP.WF.Template.MapDataExt'";
			BP.DA.DBAccess.RunSQL(sql);
			sql = "INSERT INTO Sys_EnCfg(No,GroupTitle) VALUES ('BP.WF.Template.MapDataExt','";
			sql += "@No=基本属性";
			sql += "@Designer=设计者信息";
			sql += "')";
			BP.DA.DBAccess.RunSQL(sql);

			// 更新表单应用类型，注意会涉及到其他问题.
			sql = "UPDATE Sys_MapData SET AppType=0 WHERE No NOT LIKE 'ND%'";
			DBAccess.RunSQL(sql);
			// /#endregion

			// /#region 标签
			sql = "DELETE FROM Sys_EnCfg WHERE No='BP.WF.Template.NodeSheet'";
			BP.DA.DBAccess.RunSQL(sql);
			sql = "INSERT INTO Sys_EnCfg(No,GroupTitle) VALUES ('BP.WF.Template.NodeSheet','";
			sql += "@NodeID=基本配置";
			sql += "@FormType=表单";
			sql += "@FWCSta=审核组件,适用于sdk表单审核组件与ccform上的审核组件属性设置.";
			sql += "@SFSta=父子流程,对启动，查看父子流程的控件设置.";
			sql += "@SendLab=按钮权限,控制工作节点可操作按钮.";
			sql += "@RunModel=运行模式,分合流,父子流程";
			sql += "@AutoJumpRole0=跳转,自动跳转规则当遇到该节点时如何让其自动的执行下一步.";
			sql += "@MPhone_WorkModel=移动,与手机平板电脑相关的应用设置.";
			sql += "@TSpanDay=考核,时效考核,质量考核.";
			// sql += "@MsgCtrl=消息,流程消息信息.";
			sql += "@OfficeOpen=公文按钮,只有当该节点是公文流程时候有效";
			sql += "')";
			BP.DA.DBAccess.RunSQL(sql);

			sql = "DELETE FROM Sys_EnCfg WHERE No='BP.WF.Template.FlowSheet'";
			BP.DA.DBAccess.RunSQL(sql);
			sql = "INSERT INTO Sys_EnCfg(No,GroupTitle) VALUES ('BP.WF.Template.FlowSheet','";
			sql += "@No=基本配置";
			sql += "@FlowRunWay=启动方式,配置工作流程如何自动发起，该选项要与流程服务一起工作才有效.";
			sql += "@StartLimitRole=启动限制规则";
			sql += "@StartGuideWay=发起前置导航";
			sql += "@CFlowWay=延续流程";
			sql += "@DTSWay=流程数据与业务数据同步";
			sql += "@PStarter=轨迹查看权限";
			sql += "')";
			BP.DA.DBAccess.RunSQL(sql);
			// /#endregion

			// /#region 增加week字段,方便按周统计.
			BP.WF.GenerWorkFlow gwf = new GenerWorkFlow();
			gwf.CheckPhysicsTable();
			sql = "SELECT WorkID,RDT FROM WF_GenerWorkFlow WHERE WeekNum=0 or WeekNum is null ";
			DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(sql);
			for (DataRow dr : dt.Rows) {
				sql = "UPDATE WF_GenerWorkFlow SET WeekNum="
						+ BP.DA.DataType.WeekOfYear(DataType.ParseSysDateTime2DateTime(dr.getValue(1).toString())) + " WHERE WorkID="
						+ dr.getValue(0).toString();
				BP.DA.DBAccess.RunSQL(sql);
			}
			// 查询.
			BP.WF.Data.CH ch = new CH();
			ch.CheckPhysicsTable();

//			没有Week字段，所以注释掉 2016-7-20
//			sql = "SELECT MyPK,DTFrom FROM WF_CH WHERE WeekNum=0 or WeekNum is null ";
//			dt = BP.DA.DBAccess.RunSQLReturnTable(sql);
//			for (DataRow dr : dt.Rows) {
//				sql = "UPDATE WF_CH SET Week=" + BP.DA.DataType.WeekOfYear(
//						BP.DA.DataType.ParseSysDateTime2DateTime(dr.getValue(1).toString()))
//						+ " WHERE MyPK='" + dr.getValue(0).toString() + "'";
//				BP.DA.DBAccess.RunSQL(sql);
//			}
			// /#endregion 增加week字段.

			// /#region 检查数据源.
			SFDBSrc src = new SFDBSrc();
			src.setNo("local");
			src.setName("本机数据源(默认)");
			if (src.RetrieveFromDBSources() == 0) {
				src.Insert();
			}
			// /#endregion 检查数据源.

			// /#region 更新枚举类型.
			// 删除枚举值,让其自动生成.
			sql = "DELETE FROM Sys_Enum WHERE EnumKey IN ('CodeStruct'";
			sql += ",'DBSrcType'";
			sql += ",'WebOfficeEnable'";
			sql += ",'BlockModel'";
			sql += ",'CCRole','FWCType','SelectAccepterEnable','NodeFormType','StartGuideWay','"
					+ FlowAttr.StartLimitRole
					+ "','BillFileType','EventDoType','FormType','BatchRole','StartGuideWay','NodeFormType','FormRunType')";
			BP.DA.DBAccess.RunSQL(sql);
			// /#endregion 更新枚举类型.

			// /#region 其他.
			// 更新 PassRate.
			sql = "UPDATE WF_Node SET PassRate=100 WHERE PassRate IS NULL";
			BP.DA.DBAccess.RunSQL(sql);
			// /#endregion 其他.

			// /#region 升级统一规则.
			try {
				String sqls = "";
				sqls += "UPDATE Sys_MapExt SET MyPK= ExtType+'_'+FK_Mapdata+'_'+AttrOfOper WHERE ExtType='"
						+ MapExtXmlList.TBFullCtrl + "'";
				sqls += "UPDATE Sys_MapExt SET MyPK= ExtType+'_'+FK_Mapdata+'_'+AttrOfOper WHERE ExtType='"
						+ MapExtXmlList.PopVal + "'";
				sqls += "UPDATE Sys_MapExt SET MyPK= ExtType+'_'+FK_Mapdata+'_'+AttrOfOper WHERE ExtType='"
						+ MapExtXmlList.DDLFullCtrl + "'";
				sqls += "UPDATE Sys_MapExt SET MyPK= ExtType+'_'+FK_Mapdata+'_'+AttrOfOper WHERE ExtType='"
						+ MapExtXmlList.ActiveDDL + "'";
				BP.DA.DBAccess.RunSQLs(sqls);
			} catch (java.lang.Exception e) {
			}
			// /#endregion

			// /#region 更新CA签名(2015-03-03)。
			// BP.Tools.WFSealData sealData = new Tools.WFSealData();
			// sealData.CheckPhysicsTable();
			// sealData.UpdateColumn();
			// /#endregion 更新CA签名.

			// /#region 其他.
			// 升级表单树. 2015.10.05
			SysFormTree sft = new SysFormTree();
			sft.CheckPhysicsTable();
			sql = "UPDATE Sys_FormTree SET DBSrc='local'  WHERE DBSrc IS NULL OR DBSrc=''";
			BP.DA.DBAccess.RunSQL(sql);

			// 表单信息表.
			MapDataExt mapext = new MapDataExt();
			mapext.CheckPhysicsTable();

			TransferCustom tc = new TransferCustom();
			tc.CheckPhysicsTable();

			// 增加部门字段。
			CCList cc = new CCList();
			cc.CheckPhysicsTable();
			// /#endregion 其他.

			// /#region 判断WF_Flow中是否含有FlowJson字段，没有则增加此字段，edited by
			// liuxc,2016-2-25

			DataTable columns = src.GetColumns("WF_Flow");
			Map<String, Object> filterMap = new HashMap<String, Object>();
			filterMap.put("name", "FLOWJSON");
			if (columns.Select(filterMap).size() == 0) {
				switch (src.getHisDBType()) {
				case MSSQL:
					DBAccess.RunSQL("ALTER TABLE WF_Flow ADD FlowJson IMAGE NULL");
					break;
				case Oracle:
				case Informix:
					DBAccess.RunSQL("ALTER TABLE WF_Flow ADD FlowJson BLOB NULL");
					break;
				case MySQL:
					DBAccess.RunSQL("ALTER TABLE WF_Flow ADD FlowJson LONGTEXT");
					break;
				default:
					break;
				}
			}
			// /#endregion

			// /#region 升级sys_sftable
			// 升级
			BP.Sys.SFTable tab = new SFTable();
			tab.CheckPhysicsTable();
			// mySQL =
			// "UPDATE Sys_SFTable SET "+SFTableAttr.SrcTable+"=0 WHERE TabType IS NULL";
			// BP.DA.DBAccess.RunSQL(mySQL);
			// /#endregion

			// /#region 基础数据更新.
			Node wf_Node = new Node();
			wf_Node.CheckPhysicsTable();
			// 设置节点ICON.
			sql = "UPDATE WF_Node SET ICON='/WF/Data/NodeIcon/审核.png' WHERE ICON IS NULL";
			BP.DA.DBAccess.RunSQL(sql);

			BP.WF.Template.NodeSheet nodeSheet = new BP.WF.Template.NodeSheet();
			nodeSheet.CheckPhysicsTable();
			// 升级手机应用. 2014-08-02.
			sql = "UPDATE WF_Node SET MPhone_WorkModel=0,MPhone_SrcModel=0,MPad_WorkModel=0,MPad_SrcModel=0 WHERE MPhone_WorkModel IS NULL";
			BP.DA.DBAccess.RunSQL(sql);
			// /#endregion 基础数据更新.

			// /#region 把节点的toolbarExcel, word 信息放入mapdata
			BP.WF.Template.NodeSheets nss = new BP.WF.Template.NodeSheets();
			nss.RetrieveAll();
			for (BP.WF.Template.NodeSheet ns : nss.ToJavaList()) {
				ToolbarExcel te = new ToolbarExcel();
				te.setNo("ND" + ns.getNodeID());
				te.RetrieveFromDBSources();

				// te.Copy(ns);
				// te.Update();
			}
			// /#endregion

			// /#region 升级SelectAccper
			Direction dir = new Direction();
			dir.CheckPhysicsTable();

			SelectAccper selectAccper = new SelectAccper();
			selectAccper.CheckPhysicsTable();
			// /#endregion

			// /#region 升级wf-generworkerlist 2014-05-09
			GenerWorkerList gwl = new GenerWorkerList();
			gwl.CheckPhysicsTable();
			// /#endregion 升级wf-generworkerlist 2014-05-09

			// /#region 升级 NodeToolbar
			FrmField ff = new FrmField();
			ff.CheckPhysicsTable();

			MapAttr attr = new MapAttr();
			attr.CheckPhysicsTable();

			NodeToolbar bar = new NodeToolbar();
			bar.CheckPhysicsTable();

			BP.WF.Template.FlowFormTree tree = new BP.WF.Template.FlowFormTree();
			tree.CheckPhysicsTable();

			FrmNode nff = new FrmNode();
			nff.CheckPhysicsTable();

			SysForm ssf = new SysForm();
			ssf.CheckPhysicsTable();

			SysFormTree ssft = new SysFormTree();
			ssft.CheckPhysicsTable();

			FrmAttachment ath = new FrmAttachment();
			ath.CheckPhysicsTable();

			FrmField ffs = new FrmField();
			ffs.CheckPhysicsTable();
			// /#endregion

			// /#region 执行sql．
			BP.DA.DBAccess
					.RunSQL("delete  from Sys_Enum WHERE EnumKey in ('BillFileType','EventDoType','FormType','BatchRole','StartGuideWay','NodeFormType')");
			DBAccess.RunSQL("UPDATE Sys_FrmSln SET FK_Flow =(SELECT FK_FLOW FROM WF_Node WHERE NODEID=Sys_FrmSln.FK_Node) WHERE FK_Flow IS NULL");

			try {
				DBAccess.RunSQL("UPDATE WF_FrmNode SET MyPK=FK_Frm+'_'+convert(varchar,FK_Node )+'_'+FK_Flow");
			} catch (java.lang.Exception e2) {

			}
			// /#endregion

			// /#region 检查必要的升级。
			// 部门
			BP.Port.Dept d = new BP.Port.Dept();
			d.CheckPhysicsTable();

			FrmWorkCheck fwc = new FrmWorkCheck();
			fwc.CheckPhysicsTable();

			Flow myfl = new Flow();
			myfl.CheckPhysicsTable();

			Node nd = new Node();
			nd.CheckPhysicsTable();
			// Sys_SFDBSrc
			SFDBSrc sfDBSrc = new SFDBSrc();
			sfDBSrc.CheckPhysicsTable();
			// /#endregion 检查必要的升级。

			// /#region 执行更新.wf_node
			sql = "UPDATE WF_Node SET FWCType=0 WHERE FWCType IS NULL";
			sql += "@UPDATE WF_Node SET FWC_X=0 WHERE FWC_X IS NULL";
			sql += "@UPDATE WF_Node SET FWC_Y=0 WHERE FWC_Y IS NULL";
			sql += "@UPDATE WF_Node SET FWC_W=0 WHERE FWC_W IS NULL";
			sql += "@UPDATE WF_Node SET FWC_H=0 WHERE FWC_H IS NULL";
			BP.DA.DBAccess.RunSQLs(sql);

			sql = "UPDATE WF_Node SET SFSta=0 WHERE SFSta IS NULL";
			sql += "@UPDATE WF_Node SET SF_X=0 WHERE SF_X IS NULL";
			sql += "@UPDATE WF_Node SET SF_Y=0 WHERE SF_Y IS NULL";
			sql += "@UPDATE WF_Node SET SF_W=0 WHERE SF_W IS NULL";
			sql += "@UPDATE WF_Node SET SF_H=0 WHERE SF_H IS NULL";
			BP.DA.DBAccess.RunSQLs(sql);

			// /#endregion 执行更新.

			// /#region 执行报表设计。
			Flows fls = new Flows();
			fls.RetrieveAll();
			for (Flow fl : fls.ToJavaList()) {
				try {
					MapRpts rpts = new MapRpts();
				} catch (java.lang.Exception e3) {
					fl.DoCheck();
				}
			}
			// /#endregion

			// /#region 升级站内消息表 2013-10-20
			BP.WF.SMS sms = new SMS();
			sms.CheckPhysicsTable();
			// /#endregion

			// /#region 重新生成view WF_EmpWorks, 2013-08-06.
			try {
				BP.DA.DBAccess.RunSQL("DROP VIEW WF_EmpWorks");
				BP.DA.DBAccess.RunSQL("DROP VIEW V_FlowStarter");
				BP.DA.DBAccess.RunSQL("DROP VIEW V_FlowStarterBPM");
				BP.DA.DBAccess.RunSQL("DROP VIEW V_TOTALCH");
				BP.DA.DBAccess.RunSQL("DROP VIEW V_TOTALCHYF");
				BP.DA.DBAccess.RunSQL("DROP VIEW V_TOTALCHWeek");
			} catch (java.lang.Exception e4) {
			}

			String sqlscript = "";
			// 执行必须的sql.
			switch (BP.Sys.SystemConfig.getAppCenterDBType()) {
			case Oracle:
				sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
						+ "/WF/Data/Install/SQLScript/InitView_Ora.sql";
				break;
			case MSSQL:
			case Informix:
				sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
						+ "/WF/Data/Install/SQLScript/InitView_SQL.sql";
				break;
			case MySQL:
				sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
						+ "/WF/Data/Install/SQLScript/InitView_MySQL.sql";
				break;
			default:
				break;
			}

			BP.DA.DBAccess.RunSQLScript(sqlscript);
			// /#endregion

			// /#region 更新表单的边界.2014-10-18
			MapDatas mds = new MapDatas();
			mds.RetrieveAll();

			for (MapData md : mds.ToJavaList()) {
				md.ResetMaxMinXY(); // 更新边界.
			}
			// /#endregion 更新表单的边界.

			// /#region 升级Img
			FrmImg img = new FrmImg();
			img.CheckPhysicsTable();
			// /#endregion

			// /#region 修复 mapattr UIHeight, UIWidth 类型错误.
			switch (BP.Sys.SystemConfig.getAppCenterDBType()) {
			case Oracle:
				msg = "@Sys_MapAttr 修改字段";
				break;
			case MSSQL:
				msg = "@修改sql server控件高度和宽度字段。";
				DBAccess.RunSQL("ALTER TABLE Sys_MapAttr ALTER COLUMN UIWidth float");
				DBAccess.RunSQL("ALTER TABLE Sys_MapAttr ALTER COLUMN UIHeight float");
				break;
			default:
				break;
			}
			// /#endregion

			// /#region 升级常用词汇
			switch (BP.Sys.SystemConfig.getAppCenterDBType()) {
			case Oracle:
				int i = DBAccess
						.RunSQLReturnCOUNT("SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'SYS_DEFVAL' AND COLUMN_NAME = 'PARENTNO'");
				if (i == 0) {
					DBAccess.RunSQL("drop table Sys_DefVal");
					DefVal dv = new DefVal();
					dv.CheckPhysicsTable();
				}
				msg = "@Sys_DefVal 修改字段";
				break;
			case MSSQL:
				msg = "@修改 Sys_DefVal。";
				i = DBAccess
						.RunSQLReturnCOUNT("SELECT * FROM SYSCOLUMNS WHERE ID=OBJECT_ID('Sys_DefVal') AND NAME='ParentNo'");
				if (i == 0) {
					DBAccess.RunSQL("drop table Sys_DefVal");
					DefVal dv = new DefVal();
					dv.CheckPhysicsTable();
				}
				break;
			default:
				break;
			}
			// /#endregion

			// /#region 登录更新错误
			msg = "@登录时错误。";
			DBAccess.RunSQL("DELETE FROM Sys_Enum WHERE EnumKey IN ('DeliveryWay','RunModel','OutTimeDeal','FlowAppType')");
			// /#endregion 登录更新错误

			// /#region 升级表单树
			// 首先检查是否升级过.
			sql = "SELECT * FROM Sys_FormTree WHERE No = '0'";
			DataTable formTree_dt = DBAccess.RunSQLReturnTable(sql);
			if (formTree_dt.Rows.size() == 0) {
				/* 没有升级过.增加根节点 */
				SysFormTree formTree = new SysFormTree();
				formTree.setNo("0");
				formTree.setName("表单库");
				formTree.setParentNo("");
				// formTree.TreeNo = "0";
				formTree.setIdx(0);
				formTree.setIsDir(true);

				try {
					formTree.DirectInsert();
				} catch (java.lang.Exception e5) {
				}
				// 将表单库中的数据转入表单树
				SysFormTrees formSorts = new SysFormTrees();
				formSorts.RetrieveAll();

				for (SysFormTree item : formSorts.ToJavaList()) {
					if (item.getNo().equals("0")) {
						continue;
					}
					SysFormTree subFormTree = new SysFormTree();
					subFormTree.setNo(item.getNo());
					subFormTree.setName(item.getName());
					subFormTree.setParentNo("0");
					subFormTree.Save();
				}
				// 表单于表单树进行关联
				sql = "UPDATE Sys_MapData SET FK_FormTree=FK_FrmSort WHERE FK_FrmSort <> '' AND FK_FrmSort is not null";
				DBAccess.RunSQL(sql);
			}
			// /#endregion

			// /#region 执行admin登录. 2012-12-25 新版本.
			Emp emp = new Emp();
			emp.setNo("admin");
			if (emp.RetrieveFromDBSources() == 1) {
				BP.Web.WebUser.SignInOfGener(emp, true);
			} else {
				emp.setNo("admin");
				emp.setName("admin");
				emp.setFK_Dept("01");
				emp.setPass("123");
				emp.Insert();
				BP.Web.WebUser.SignInOfGener(emp, true);
				// throw new Exception("admin 用户丢失，请注意大小写。");
			}
			// /#endregion 执行admin登录.

			// /#region 修复 Sys_FrmImg 表字段 ImgAppType Tag0
			switch (BP.Sys.SystemConfig.getAppCenterDBType()) {
			case Oracle:
				int i = DBAccess
						.RunSQLReturnCOUNT("SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'SYS_FRMIMG' AND COLUMN_NAME = 'TAG0'");
				if (i == 0) {
					DBAccess.RunSQL("ALTER TABLE SYS_FRMIMG ADD (ImgAppType number,TAG0 nvarchar(500))");
				}
				msg = "@Sys_FrmImg 修改字段";
				break;
			case MSSQL:
				msg = "@修改 Sys_FrmImg。";
				i = DBAccess
						.RunSQLReturnCOUNT("SELECT * FROM SYSCOLUMNS WHERE ID=OBJECT_ID('Sys_FrmImg') AND NAME='Tag0'");
				if (i == 0) {
					DBAccess.RunSQL("ALTER TABLE Sys_FrmImg ADD ImgAppType int");
					DBAccess.RunSQL("ALTER TABLE Sys_FrmImg ADD Tag0 nvarchar(500)");
				}
				break;
			default:
				break;
			}
			// /#endregion

			// 最后更新版本号，然后返回.
			sql = "UPDATE Sys_Serial SET IntVal=" + val + " WHERE CfgKey='Ver'";
			if (DBAccess.RunSQL(sql) == 0) {
				sql = "INSERT INTO Sys_Serial (CfgKey,IntVal) VALUES('Ver',"
						+ val + ") ";
				DBAccess.RunSQL(sql);
			}
			// 返回版本号.
			return val; // +"\t\n解决问题:" + updataNote;
		} catch (RuntimeException ex) {
			String err = "问题出处:" + ex.getMessage() + "<hr>" + msg
					+ "<br>详细信息:@" + ex.getStackTrace()
					+ "<br>@<a href='../DBInstall.aspx' >点这里到系统升级界面。</a>";
			BP.DA.Log.DefaultLogWriteLineError("系统升级错误:" + err, ex);
			return "0";
			// return "升级失败,详细请查看日志.\\DataUser\\Log\\";
		}
	}

	/**
	 * CCFlowAppPath
	 */
	public static String getCCFlowAppPath() {
		HttpServletRequest request = ContextHolderUtils.getRequest();
		String basePath="";
		if(request==null||request.getServerName()==null){
			basePath = BP.WF.Glo.getHostURL();
		}else{
			basePath = request.getScheme() + "://" + request.getServerName() 
					+ ":" + request.getServerPort() + request.getContextPath() + "/";
		}
		return basePath;
	}

	/**
	 * 安装包
	 * 
	 * @throws Exception
	 */
	public static void DoInstallDataBase(String lang,
			boolean isInstallFlowDemo, boolean isInstallCCIM) throws Exception {
		ArrayList al = null;
		String info = "BP.En.Entity";
		al = BP.En.ClassFactory.GetObjects(info);

		// /#region 1, 创建or修复表
		for (Object obj : al) {
			Entity en = null;
			en = (Entity) ((obj instanceof Entity) ? obj : null);
			if (en == null) {
				continue;
			}

			// 获得类名.
			String clsName = en.toString();

			if (isInstallFlowDemo == false) {
				/* 如果不安装demo. */
				if (clsName != null) {
					if (clsName.contains("BP.CN")
							|| clsName.contains("BP.Demo")) {
						continue;
					}
				}
			}

			String table = null;
			try {
				table = en.getEnMap().getPhysicsTable();
				if (table == null) {
					continue;
				}
			} catch (Exception e) {
				continue;
			}

			if (table == "" || table == null)
				continue;

			if (table.equals("WF_EmpWorks")
					|| table.equals("WF_GenerEmpWorkDtls")
					|| table.equals("WF_GenerEmpWorks")
					|| table.equals("V_FlowData")) {
				continue;
			} else if (table.equals("Sys_Enum")) {
				en.CheckPhysicsTable();
			} else {
				en.CheckPhysicsTable();
			}

		}

		// /#region 创建 Port_EmpDept 视图兼容旧版本.
		// 创建视图.
		try {
			if (DBAccess.IsExitsObject("Port_EmpDept"))
				BP.DA.DBAccess.RunSQL("DROP TABLE Port_EmpDept");
		} catch (java.lang.Exception e2) {
		}

		try {
			BP.DA.DBAccess.RunSQL("DROP VIEW Port_EmpDept");
		} catch (java.lang.Exception e3) {
		}
		if (DBAccess.IsExitsObject("Port_EmpDept") == false) {
			String sql = "CREATE VIEW Port_EmpDept as SELECT No as FK_Emp, FK_Dept FROM Port_Emp";
			BP.DA.DBAccess.RunSQL(sql);
		}
		// /#endregion 创建视图.

		// /#endregion 修复

		// /#region 2, 注册枚举类型 SQL
		// 2, 注册枚举类型。
		BP.Sys.XML.EnumInfoXmls xmls = new BP.Sys.XML.EnumInfoXmls();
		xmls.RetrieveAll();
		for (BP.Sys.XML.EnumInfoXml xml : xmls.ToJavaList()) {
			BP.Sys.SysEnums ses = new BP.Sys.SysEnums();
			ses.RegIt(xml.getKey(), xml.getVals());
		}
		// /#endregion 注册枚举类型

		// /#region 3, 执行基本的 sql
		if (isInstallFlowDemo == false) {
			SysFormTree frmSort = new SysFormTree();
			frmSort.setNo("01");
			frmSort.setName("表单类别1");
			frmSort.setParentNo("0");
			frmSort.Insert();
		}

		String sqlscript = "";
		if (Glo.getOSModel() == BP.Sys.OSModel.OneOne) {
			/* 如果是WorkFlow模式 */
			sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
					+ "WF/Data/Install/SQLScript/Port_Inc_CH_WorkFlow.sql";
			BP.DA.DBAccess.RunSQLScript(sqlscript);
		}

		if (Glo.getOSModel() == BP.Sys.OSModel.OneMore) {
			/* 如果是BPM模式 */
			sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
					+ "GPM/SQLScript/Port_Inc_CH_BPM.sql";
			BP.DA.DBAccess.RunSQLScript(sqlscript);
		}
		// /#endregion 修复

		// /#region 4, 创建视图与数据.
		// 执行必须的sql.

		sqlscript = "";
		// 执行必须的sql.
		switch (BP.Sys.SystemConfig.getAppCenterDBType()) {
		case Oracle:
			sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
					+ "WF/Data/Install/SQLScript/InitView_Ora.sql";
			break;
		case MSSQL:
		case Informix:
			sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
					+ "WF/Data/Install/SQLScript/InitView_SQL.sql";
			break;
		case MySQL:
			sqlscript = BP.Sys.SystemConfig.getCCFlowAppPath()
					+ "WF/Data/Install/SQLScript/InitView_MySQL.sql";
			break;
		default:
			break;
		}

		BP.DA.DBAccess.RunSQLScript(sqlscript);
		// /#endregion 创建视图与数据.

		// /#region 5, 初始化数据.
		if (isInstallFlowDemo) {
			sqlscript = SystemConfig.getPathOfData()
					+ "Install/SQLScript/InitPublicData.sql";
			BP.DA.DBAccess.RunSQLScript(sqlscript);
		} else {
			FlowSort fs = new FlowSort();
			fs.setNo("02");
			fs.setParentNo("99");
			fs.setName("其他类");
			fs.DirectInsert();
		}
		// /#endregion 初始化数据

		// /#region 6, 生成临时的 wf_emp 数据。
		if (isInstallFlowDemo) {
			BP.Port.Emps emps = new BP.Port.Emps();
			emps.RetrieveAllFromDBSource();
			int i = 0;
			for (BP.Port.Emp emp : emps.ToJavaList()) {
				i++;
				BP.WF.Port.WFEmp wfEmp = new BP.WF.Port.WFEmp();
				wfEmp.Copy(emp);
				wfEmp.setNo(emp.getNo());

				if (wfEmp.getEmail().length() == 0) {
					wfEmp.setEmail(emp.getNo() + "@ccflow.org");
				}

				if (wfEmp.getTel().length() == 0) {
					wfEmp.setTel("82374939-6"
							+ StringHelper.padLeft(
									String.valueOf(i), 2, '0'));
				}

				if (wfEmp.getIsExits()) {
					wfEmp.Update();
				} else {
					wfEmp.Insert();
				}
			}

			// 生成简历数据.
			int oid = 1000;
			for (BP.Port.Emp emp : emps.ToJavaList()) {
				// for (int myIdx = 0; myIdx < 6; myIdx++)
				// {
				// BP.WF.Demo.Resume re = new Demo.Resume();
				// re.NianYue = "200" + myIdx + "年01月";
				// re.FK_Emp = emp.getNo();
				// re.GongZuoDanWei = "工作部门-" + myIdx;
				// re.ZhengMingRen = "张" + myIdx;
				// re.BeiZhu = emp.getName() + "同志工作认真.";
				// oid++;
				// re.InsertAsOID(oid);
				// }
			}
			// 生成年度月份数据.
			String sqls = "";
			java.util.Date dtNow = new java.util.Date();
			for (int num = 0; num < 12; num++) {
				sqls = "@ INSERT INTO Pub_NY (No,Name) VALUES ('"
						+ DateUtils.format(new Date(), "yyyy-MM") + "','"
						+ DateUtils.format(new Date(), "yyyy-MM") + "')  ";
				// dtNow = dtNow.plusMonths(1);
				dtNow = DateUtils.addMonth(dtNow, 1);
			}
			BP.DA.DBAccess.RunSQLs(sqls);
		}
		// /#endregion 初始化数据

		// /#region 装载 demo.flow
		if (isInstallFlowDemo == true) {
			BP.Port.Emp emp = new BP.Port.Emp("admin");
			BP.Web.WebUser.SignInOfGener(emp);

			// 装载数据模版.
			BP.WF.DTS.LoadTemplete l = new BP.WF.DTS.LoadTemplete();
			Object tempVar = l.Do();
			String msg = (String) ((tempVar instanceof String) ? tempVar : null);

			// 修复视图.
			Flow.RepareV_FlowData_View();

		} else {

			// 创建一个空白的流程，不然，整个结构就出问题。
			FlowSorts fss = new FlowSorts();
			fss.RetrieveAll();
			fss.Delete();

			FlowSort fs = new FlowSort();
			fs.setName("流程树");
			fs.setNo("01");
			fs.setTreeNo("01");
			fs.setIsDir(true);
			fs.setParentNo("0");
			fs.Insert();

			FlowSort s1 = (FlowSort) fs.DoCreateSubNode();
			s1.setName("日常办公类");
			s1.Update();

			s1 = (FlowSort) fs.DoCreateSubNode();
			s1.setName("财务类");
			s1.Update();

			s1 = (FlowSort) fs.DoCreateSubNode();
			s1.setName("人力资源类");
			s1.Update();

		}
		// /#endregion 装载demo.flow

		// /#region 增加图片签名
		if (isInstallFlowDemo == true) {
			try {
				// 增加图片签名
				BP.WF.DTS.GenerSiganture gs = new BP.WF.DTS.GenerSiganture();
				gs.Do();
			} catch (java.lang.Exception e4) {
			}
		}
		// /#endregion 增加图片签名.

		// /#region 执行补充的sql, 让外键的字段长度都设置成100.
		DBAccess.RunSQL("UPDATE Sys_MapAttr SET maxlen=100 WHERE LGType=2 AND MaxLen<100");
		DBAccess.RunSQL("UPDATE Sys_MapAttr SET maxlen=100 WHERE KeyOfEn='FK_Dept'");

		// Nodes nds = new Nodes();
		// nds.RetrieveAll();
		// foreach (Node nd in nds)
		// nd.HisWork.CheckPhysicsTable();
		// /#endregion 执行补充的sql, 让外键的字段长度都设置成100.

		// /#region 安装ccim.
		// Glo.DoInstallCCIM();
		// /#endregion

	}

	public static void KillProcess(String processName) // 杀掉进程的方法
	{
		// System.Diagnostics.Process[] processes =
		// System.Diagnostics.Process.GetProcesses();
		// for (System.Diagnostics.Process pro : processes)
		// {
		// String name = pro.ProcessName + ".exe";
		// if (name.toLowerCase().equals(processName.toLowerCase()))
		// {
		// pro.Kill();
		// }
		// }
		try {
			Process process = Runtime.getRuntime().exec("taskList");
			Scanner in = new Scanner(process.getInputStream());
			while (in.hasNextLine()) {
				String temp = in.nextLine();
				if (temp.toLowerCase().contains(processName.toLowerCase())) {
					String pid = temp.substring(9, temp.indexOf("Console"));
					Runtime.getRuntime().exec("tskill " + pid);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 产生新的编号
	 * 
	 * @param rptKey
	 * @return
	 */
	public static String GenerFlowNo(String rptKey) {
		rptKey = rptKey.replace("ND", "");
		rptKey = rptKey.replace("Rpt", "");
		switch (rptKey.length()) {
		case 0:
			return "001";
		case 1:
			return "00" + rptKey;
		case 2:
			return "0" + rptKey;
		case 3:
			return rptKey;
		default:
			return "001";
		}
	}

	/** 
	 
	*/
	public static boolean getIsShowFlowNum() {
		if (SystemConfig.getAppSettings().get("IsShowFlowNum").toString()
				.equals("1")) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 产生word文档.
	 * 
	 * @param wk
	 */
	public static void GenerWord(Object filename, Work wk) {
		// BP.WF.Glo.KillProcess("WINWORD.EXE");
		// String enName = wk.getEnMap().getPhysicsTable();
		// try
		// {
		// RegistryKey delKey =
		// Registry.LocalMachine.OpenSubKey("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Shared Tools\\Text Converters\\Import\\",
		// true);
		// delKey.DeleteValue("MSWord6.wpc");
		// delKey.Close();
		// }
		// catch (java.lang.Exception e)
		// {
		// }
		//
		// GroupField currGF = new GroupField();
		// MapAttrs mattrs = new MapAttrs(enName);
		// GroupFields gfs = new GroupFields(enName);
		// MapDtls dtls = new MapDtls(enName);
		// for (MapDtl dtl : dtls.ToJavaList())
		// {
		// dtl.IsUse = false;
		// }
		//
		// // 计算出来单元格的行数。
		// int rowNum = 0;
		// for (GroupField gf : gfs)
		// {
		// rowNum++;
		// boolean isLeft = true;
		// for (MapAttr attr : mattrs)
		// {
		// if (attr.UIVisible == false)
		// {
		// continue;
		// }
		//
		// if (attr.GroupID != gf.OID)
		// {
		// continue;
		// }
		//
		// if (attr.UIIsLine)
		// {
		// rowNum++;
		// isLeft = true;
		// continue;
		// }
		//
		// if (isLeft == false)
		// {
		// rowNum++;
		// }
		// isLeft = !isLeft;
		// }
		// }
		//
		// rowNum = rowNum + 2 + dtls.size();
		//
		// // 创建Word文档
		// String CheckedInfo = "";
		// String message = "";
		// Object Nothing = System.Reflection.Missing.Value;

		// /#region 没用代码
		// object filename = fileName;

		// Word.Application WordApp = new Word.ApplicationClass();
		// Word.Document WordDoc = WordApp.Documents.Add(ref Nothing, ref
		// Nothing, ref Nothing, ref Nothing);
		// try
		// {
		// WordApp.ActiveWindow.View.Type = Word.WdViewType.wdOutlineView;
		// WordApp.ActiveWindow.View.SeekView =
		// Word.WdSeekView.wdSeekPrimaryHeader;

		// #region 增加页眉
		// // 添加页眉 插入图片
		// string pict = SystemConfig.getPathOfDataUser() + "log.jpg"; // 图片所在路径
		// if (System.IO.File.Exists(pict))
		// {
		// System.Drawing.Image img = System.Drawing.Image.FromFile(pict);
		// object LinkToFile = false;
		// object SaveWithDocument = true;
		// object Anchor = WordDoc.Application.Selection.Range;
		// WordDoc.Application.ActiveDocument.InlineShapes.AddPicture(pict, ref
		// LinkToFile,
		// ref SaveWithDocument, ref Anchor);
		// // WordDoc.Application.ActiveDocument.InlineShapes[1].Width =
		// img.Width; // 图片宽度
		// // WordDoc.Application.ActiveDocument.InlineShapes[1].Height =
		// img.Height; // 图片高度
		// }
		// WordApp.ActiveWindow.ActivePane.Selection.InsertAfter("[驰骋业务流程管理系统 http://ccFlow.org]");
		// WordApp.Selection.ParagraphFormat.Alignment =
		// Word.WdParagraphAlignment.wdAlignParagraphLeft; // 设置右对齐
		// WordApp.ActiveWindow.View.SeekView =
		// Word.WdSeekView.wdSeekMainDocument; // 跳出页眉设置
		// WordApp.Selection.ParagraphFormat.LineSpacing = 15f; // 设置文档的行间距
		// #endregion

		// // 移动焦点并换行
		// object count = 14;
		// object WdLine = Word.WdUnits.wdLine; // 换一行;
		// WordApp.Selection.MoveDown(ref WdLine, ref count, ref Nothing); //
		// 移动焦点
		// WordApp.Selection.TypeParagraph(); // 插入段落

		// // 文档中创建表格
		// Word.Table newTable = WordDoc.Tables.Add(WordApp.Selection.Range,
		// rowNum, 4, ref Nothing, ref Nothing);

		// // 设置表格样式
		// newTable.Borders.OutsideLineStyle =
		// Word.WdLineStyle.wdLineStyleThickThinLargeGap;
		// newTable.Borders.InsideLineStyle =
		// Word.WdLineStyle.wdLineStyleSingle;

		// newTable.Columns[1].Width = 100f;
		// newTable.Columns[2].Width = 100f;
		// newTable.Columns[3].Width = 100f;
		// newTable.Columns[4].Width = 100f;

		// // 填充表格内容
		// newTable.Cell(1, 1).Range.Text = wk.EnDesc;
		// newTable.Cell(1, 1).Range.Bold = 2; // 设置单元格中字体为粗体

		// // 合并单元格
		// newTable.Cell(1, 1).Merge(newTable.Cell(1, 4));
		// WordApp.Selection.Cells.VerticalAlignment =
		// Word.WdCellVerticalAlignment.wdCellAlignVerticalCenter; // 垂直居中
		// WordApp.Selection.ParagraphFormat.Alignment =
		// Word.WdParagraphAlignment.wdAlignParagraphCenter; // 水平居中

		// int groupIdx = 1;
		// foreach (GroupField gf in gfs)
		// {
		// groupIdx++;
		// // 填充表格内容
		// newTable.Cell(groupIdx, 1).Range.Text = gf.Lab;
		// newTable.Cell(groupIdx, 1).Range.Font.Color =
		// Word.WdColor.wdColorDarkBlue; // 设置单元格内字体颜色
		// newTable.Cell(groupIdx, 1).Shading.BackgroundPatternColor =
		// Word.WdColor.wdColorGray25;
		// // 合并单元格
		// newTable.Cell(groupIdx, 1).Merge(newTable.Cell(groupIdx, 4));
		// WordApp.Selection.Cells.VerticalAlignment =
		// Word.WdCellVerticalAlignment.wdCellAlignVerticalCenter;

		// groupIdx++;

		// bool isLeft = true;
		// bool isColumns2 = false;
		// int currColumnIndex = 0;
		// foreach (MapAttr attr in mattrs)
		// {
		// if (attr.UIVisible == false)
		// continue;

		// if (attr.GroupID != gf.OID)
		// continue;

		// if (newTable.Rows.Count < groupIdx)
		// continue;

		// #region 增加从表
		// foreach (MapDtl dtl in dtls)
		// {
		// if (dtl.IsUse)
		// continue;

		// if (dtl.RowIdx != groupIdx - 3)
		// continue;

		// if (gf.OID != dtl.GroupID)
		// continue;

		// GEDtls dtlsDB = new GEDtls(dtl.No);
		// QueryObject qo = new QueryObject(dtlsDB);
		// switch (dtl.DtlOpenType)
		// {
		// case DtlOpenType.ForEmp:
		// qo.AddWhere(GEDtlAttr.RefPK, wk.OID);
		// break;
		// case DtlOpenType.ForWorkID:
		// qo.AddWhere(GEDtlAttr.RefPK, wk.OID);
		// break;
		// case DtlOpenType.ForFID:
		// qo.AddWhere(GEDtlAttr.FID, wk.OID);
		// break;
		// }
		// qo.DoQuery();

		// newTable.Rows[groupIdx].SetHeight(100f,
		// Word.WdRowHeightRule.wdRowHeightAtLeast);
		// newTable.Cell(groupIdx, 1).Merge(newTable.Cell(groupIdx, 4));

		// Attrs dtlAttrs = dtl.GenerMap().Attrs;
		// int colNum = 0;
		// foreach (Attr attrDtl in dtlAttrs)
		// {
		// if (attrDtl.UIVisible == false)
		// continue;
		// colNum++;
		// }

		// newTable.Cell(groupIdx, 1).Select();
		// WordApp.Selection.Delete(ref Nothing, ref Nothing);
		// Word.Table newTableDtl = WordDoc.Tables.Add(WordApp.Selection.Range,
		// dtlsDB.Count + 1, colNum,
		// ref Nothing, ref Nothing);

		// newTableDtl.Borders.OutsideLineStyle =
		// Word.WdLineStyle.wdLineStyleSingle;
		// newTableDtl.Borders.InsideLineStyle =
		// Word.WdLineStyle.wdLineStyleSingle;

		// int colIdx = 1;
		// foreach (Attr attrDtl in dtlAttrs)
		// {
		// if (attrDtl.UIVisible == false)
		// continue;
		// newTableDtl.Cell(1, colIdx).Range.Text = attrDtl.Desc;
		// colIdx++;
		// }

		// int idxRow = 1;
		// foreach (GEDtl item in dtlsDB)
		// {
		// idxRow++;
		// int columIdx = 0;
		// foreach (Attr attrDtl in dtlAttrs)
		// {
		// if (attrDtl.UIVisible == false)
		// continue;
		// columIdx++;

		// if (attrDtl.IsFKorEnum)
		// newTableDtl.Cell(idxRow, columIdx).Range.Text =
		// item.GetValRefTextByKey(attrDtl.Key);
		// else
		// {
		// if (attrDtl.MyDataType == DataType.AppMoney)
		// newTableDtl.Cell(idxRow, columIdx).Range.Text =
		// item.GetValMoneyByKey(attrDtl.Key).ToString("0.00");
		// else
		// newTableDtl.Cell(idxRow, columIdx).Range.Text =
		// item.GetValStrByKey(attrDtl.Key);

		// if (attrDtl.IsNum)
		// newTableDtl.Cell(idxRow, columIdx).Range.ParagraphFormat.Alignment =
		// Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;
		// }
		// }
		// }

		// groupIdx++;
		// isLeft = true;
		// }
		// #endregion 增加从表

		// if (attr.UIIsLine)
		// {
		// currColumnIndex = 0;
		// isLeft = true;
		// if (attr.IsBigDoc)
		// {
		// newTable.Rows[groupIdx].SetHeight(100f,
		// Word.WdRowHeightRule.wdRowHeightAtLeast);
		// newTable.Cell(groupIdx, 1).Merge(newTable.Cell(groupIdx, 4));
		// newTable.Cell(groupIdx, 1).Range.Text = attr.getName() + ":\r\n" +
		// wk.GetValStrByKey(attr.KeyOfEn);
		// }
		// else
		// {
		// newTable.Cell(groupIdx, 2).Merge(newTable.Cell(groupIdx, 4));
		// newTable.Cell(groupIdx, 1).Range.Text = attr.getName();
		// newTable.Cell(groupIdx, 2).Range.Text =
		// wk.GetValStrByKey(attr.KeyOfEn);
		// }
		// groupIdx++;
		// continue;
		// }
		// else
		// {
		// if (attr.IsBigDoc)
		// {
		// if (currColumnIndex == 2)
		// {
		// currColumnIndex = 0;
		// }

		// newTable.Rows[groupIdx].SetHeight(100f,
		// Word.WdRowHeightRule.wdRowHeightAtLeast);
		// if (currColumnIndex == 0)
		// {
		// newTable.Cell(groupIdx, 1).Merge(newTable.Cell(groupIdx, 2));
		// newTable.Cell(groupIdx, 1).Range.Text = attr.getName() + ":\r\n" +
		// wk.GetValStrByKey(attr.KeyOfEn);
		// currColumnIndex = 3;
		// continue;
		// }
		// else if (currColumnIndex == 3)
		// {
		// newTable.Cell(groupIdx, 2).Merge(newTable.Cell(groupIdx, 3));
		// newTable.Cell(groupIdx, 2).Range.Text = attr.getName() + ":\r\n" +
		// wk.GetValStrByKey(attr.KeyOfEn);
		// currColumnIndex = 0;
		// groupIdx++;
		// continue;
		// }
		// else
		// {
		// continue;
		// }
		// }
		// else
		// {
		// string s = "";
		// if (attr.LGType == FieldTypeS.Normal)
		// {
		// if (attr.MyDataType == DataType.AppMoney)
		// s = wk.GetValDecimalByKey(attr.KeyOfEn).ToString("0.00");
		// else
		// s = wk.GetValStrByKey(attr.KeyOfEn);
		// }
		// else
		// {
		// s = wk.GetValRefTextByKey(attr.KeyOfEn);
		// }

		// switch (currColumnIndex)
		// {
		// case 0:
		// newTable.Cell(groupIdx, 1).Range.Text = attr.getName();
		// if (attr.IsSigan)
		// {
		// string path = BP.Sys.SystemConfig.getPathOfDataUser() +
		// "\\Siganture\\" + s + ".jpg";
		// if (System.IO.File.Exists(path))
		// {
		// System.Drawing.Image img = System.Drawing.Image.FromFile(path);
		// object LinkToFile = false;
		// object SaveWithDocument = true;
		// //object Anchor = WordDoc.Application.Selection.Range;
		// object Anchor = newTable.Cell(groupIdx, 2).Range;

		// WordDoc.Application.ActiveDocument.InlineShapes.AddPicture(path, ref
		// LinkToFile,
		// ref SaveWithDocument, ref Anchor);
		// // WordDoc.Application.ActiveDocument.InlineShapes[1].Width =
		// img.Width; // 图片宽度
		// // WordDoc.Application.ActiveDocument.InlineShapes[1].Height =
		// img.Height; // 图片高度
		// }
		// else
		// {
		// newTable.Cell(groupIdx, 2).Range.Text = s;
		// }
		// }
		// else
		// {
		// if (attr.IsNum)
		// {
		// newTable.Cell(groupIdx, 2).Range.Text = s;
		// newTable.Cell(groupIdx, 2).Range.ParagraphFormat.Alignment =
		// Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;
		// }
		// else
		// {
		// newTable.Cell(groupIdx, 2).Range.Text = s;
		// }
		// }
		// currColumnIndex = 1;
		// continue;
		// break;
		// case 1:
		// newTable.Cell(groupIdx, 3).Range.Text = attr.getName();
		// if (attr.IsSigan)
		// {
		// string path = BP.Sys.SystemConfig.getPathOfDataUser() +
		// "\\Siganture\\" + s + ".jpg";
		// if (System.IO.File.Exists(path))
		// {
		// System.Drawing.Image img = System.Drawing.Image.FromFile(path);
		// object LinkToFile = false;
		// object SaveWithDocument = true;
		// object Anchor = newTable.Cell(groupIdx, 4).Range;
		// WordDoc.Application.ActiveDocument.InlineShapes.AddPicture(path, ref
		// LinkToFile,
		// ref SaveWithDocument, ref Anchor);
		// }
		// else
		// {
		// newTable.Cell(groupIdx, 4).Range.Text = s;
		// }
		// }
		// else
		// {
		// if (attr.IsNum)
		// {
		// newTable.Cell(groupIdx, 4).Range.Text = s;
		// newTable.Cell(groupIdx, 4).Range.ParagraphFormat.Alignment =
		// Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;
		// }
		// else
		// {
		// newTable.Cell(groupIdx, 4).Range.Text = s;
		// }
		// }
		// currColumnIndex = 0;
		// groupIdx++;
		// continue;
		// break;
		// default:
		// break;
		// }
		// }
		// }
		// }
		// } //结束循环

		// #region 添加页脚
		// WordApp.ActiveWindow.View.SeekView =
		// Word.WdSeekView.wdSeekPrimaryFooter;
		// WordApp.ActiveWindow.ActivePane.Selection.InsertAfter("模板由ccflow自动生成，严谨转载。此流程的详细内容请访问 http://doc.ccFlow.org。 建造流程管理系统请致电: 0531-82374939  ");
		// WordApp.Selection.ParagraphFormat.Alignment =
		// Word.WdParagraphAlignment.wdAlignParagraphRight;
		// #endregion

		// // 文件保存
		// WordDoc.SaveAs(ref filename, ref Nothing, ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing);

		// WordDoc.Close(ref Nothing, ref Nothing, ref Nothing);
		// WordApp.Quit(ref Nothing, ref Nothing, ref Nothing);
		// try
		// {
		// string docFile = filename.ToString();
		// string pdfFile = docFile.replace(".doc", ".pdf");
		// Glo.Rtf2PDF(docFile, pdfFile);
		// }
		// catch (Exception ex)
		// {
		// BP.DA.Log.DebugWriteInfo("@生成pdf失败." + ex.Message);
		// }
		// }
		// catch (Exception ex)
		// {
		// throw ex;
		// // WordApp.Quit(ref Nothing, ref Nothing, ref Nothing);
		// WordDoc.Close(ref Nothing, ref Nothing, ref Nothing);
		// WordApp.Quit(ref Nothing, ref Nothing, ref Nothing);
		// }
		// /#endregion
	}

	// /#endregion 执行安装.

	// /#region 全局的方法处理
	/**
	 * 流程数据表系统字段,中间用,分开.
	 */
	public static ArrayList<String> getFlowFields() {
		ArrayList<String> list = new ArrayList<String>();
		list.add(GERptAttr.AtPara);
		list.add(GERptAttr.BillNo);
		list.add(GERptAttr.CFlowNo);
		list.add(GERptAttr.CWorkID);
		list.add(GERptAttr.FID);
		list.add(GERptAttr.FK_Dept);
		list.add(GERptAttr.FK_NY);
		list.add(GERptAttr.FlowDaySpan);
		list.add(GERptAttr.FlowEmps);
		list.add(GERptAttr.FlowEnder);
		list.add(GERptAttr.FlowEnderRDT);
		list.add(GERptAttr.FlowEndNode);
		list.add(GERptAttr.FlowNote);
		list.add(GERptAttr.FlowStarter);
		list.add(GERptAttr.FlowStartRDT);
		list.add(GERptAttr.GuestName);
		list.add(GERptAttr.GuestNo);
		list.add(GERptAttr.GUID);
		list.add(GERptAttr.MyNum);
		list.add(GERptAttr.OID);
		list.add(GERptAttr.PEmp);
		list.add(GERptAttr.PFlowNo);
		list.add(GERptAttr.PNodeID);
		// list.add(GERptAttr.ProjNo);
		list.add(GERptAttr.PWorkID);
		list.add(GERptAttr.Title);
		list.add(GERptAttr.WFSta);
		list.add(GERptAttr.WFState);
		return list;
		// String str = "";
		// str += GERptAttr.OID + ",";
		// str += GERptAttr.AtPara + ",";
		// str += GERptAttr.BillNo + ",";
		// // str += GERptAttr.CFlowNo + ",";
		// // str += GERptAttr.CWorkID + ",";
		// str += GERptAttr.FID + ",";
		// str += GERptAttr.FK_Dept + ",";
		// str += GERptAttr.FK_NY + ",";
		// str += GERptAttr.FlowDaySpan + ",";
		// str += GERptAttr.FlowEmps + ",";
		// str += GERptAttr.FlowEnder + ",";
		// str += GERptAttr.FlowEnderRDT + ",";
		// str += GERptAttr.FlowEndNode + ",";
		// str += GERptAttr.FlowNote + ",";
		// str += GERptAttr.FlowStarter + ",";
		// str += GERptAttr.FlowStartRDT + ",";
		// str += GERptAttr.GuestName + ",";
		// str += GERptAttr.GuestNo + ",";
		// str += GERptAttr.GUID + ",";
		// str += GERptAttr.MyNum + ",";
		// str += GERptAttr.PEmp + ",";
		// str += GERptAttr.PFID + ",";
		// str += GERptAttr.PFlowNo + ",";
		// str += GERptAttr.PNodeID + ",";
		// str += GERptAttr.PrjName + ",";
		// str += GERptAttr.PrjNo + ",";
		// str += GERptAttr.PWorkID + ",";
		// str += GERptAttr.Title + ",";
		// str += GERptAttr.WFSta + ",";
		// str += GERptAttr.WFState + ",";
		// return str;
		// return typeof(GERptAttr).GetFields().Select(o =>
		// o.getName()).ToJavaList();
	}

	/**
	 * 根据文字处理抄送，与发送人
	 * 
	 * @param note
	 * @param emps
	 */
	public static void DealNote(String note, BP.Port.Emps emps) {
		note = "请综合处阅知。李江龙核示。请王薇、田晓红批示。";
		note = note.replace("阅知", "阅知@");

		note = note.replace("请", "@");
		note = note.replace("呈", "@");
		note = note.replace("报", "@");
		String[] strs = note.split("[@]", -1);

		String ccTo = "";
		String sendTo = "";
		for (String str : strs) {
			if (StringHelper.isNullOrEmpty(str)) {
				continue;
			}

			if (str.contains("阅知") == true || str.contains("阅度") == true) {
				/* 抄送的. */
				for (BP.Port.Emp emp : emps.ToJavaList()) {
					if (str.contains(emp.getNo()) == false) {
						continue;
					}
					ccTo += emp.getNo() + ",";
				}
				continue;
			}

			if (str.contains("阅处") == true || str.contains("阅办") == true) {
				/* 发送送的. */
				for (BP.Port.Emp emp : emps.ToJavaList()) {
					if (str.contains(emp.getNo()) == false) {
						continue;
					}
					sendTo += emp.getNo() + ",";
				}
				continue;
			}
		}
	}

	// /#region 与流程事件实体相关.
	private static Hashtable Htable_FlowFEE = null;

	/**
	 * 获得节点事件实体
	 * 
	 * @param enName
	 *            实例名称
	 * @return 获得节点事件实体,如果没有就返回为空.
	 */
	public static FlowEventBase GetFlowEventEntityByEnName(String enName) {
		if (Htable_FlowFEE == null || Htable_FlowFEE.isEmpty()) {
			Htable_FlowFEE = new Hashtable();
			ArrayList<FlowEventBase> al = BP.En.ClassFactory
					.GetObjects("BP.WF.FlowEventBase");
			for (FlowEventBase en : al) {
				Htable_FlowFEE.put(en.toString(), en);
			}
		}
		FlowEventBase myen = (FlowEventBase) ((Htable_FlowFEE.get(enName) instanceof FlowEventBase) ? Htable_FlowFEE
				.get(enName) : null);
		if (myen == null) {
			throw new RuntimeException("@根据类名称获取流程事件实体实例出现错误:" + enName
					+ ",没有找到该类的实体.");
		}
		return myen;
	}

	/**
	 * 获得事件实体String，根据编号或者流程标记
	 * 
	 * @param flowMark
	 *            流程标记
	 * @param flowNo
	 *            流程编号
	 * @return null, 或者流程实体.
	 */
	public static String GetFlowEventEntityStringByFlowMark(String flowMark,
			String flowNo) {
		FlowEventBase en = GetFlowEventEntityByFlowMark(flowMark, flowNo);
		if (en == null) {
			return "";
		} else {
			return en.toString();
		}
	}

	/**
	 * 获得事件实体，根据编号或者流程标记.
	 * 
	 * @param flowMark
	 *            流程标记
	 * @param flowNo
	 *            流程编号
	 * @return null, 或者流程实体.
	 */
	public static FlowEventBase GetFlowEventEntityByFlowMark(String flowMark,
			String flowNo) {
		if (Htable_FlowFEE == null || Htable_FlowFEE.isEmpty()) {
			Htable_FlowFEE = new Hashtable();
			ArrayList<FlowEventBase> al = BP.En.ClassFactory
					.GetObjects("BP.WF.FlowEventBase");
			Htable_FlowFEE.clear();
			for (FlowEventBase en : al) {
				Htable_FlowFEE.put(en.toString(), en);
			}
		}

		for (Object key : Htable_FlowFEE.keySet()) {
			FlowEventBase fee = (FlowEventBase) ((Htable_FlowFEE.get(key) instanceof FlowEventBase) ? Htable_FlowFEE
					.get(key) : null);
			if (fee.getFlowMark().equals(flowMark)
					|| fee.getFlowMark().equals(flowNo)) {
				return fee;
			}
		}
		return null;
	}

	// /#endregion 与流程事件实体相关.

	/**
	 * 执行发送工作后处理的业务逻辑 用于流程发送后事件调用. 如果处理失败，就会抛出异常.
	 * 
	 * @throws Exception
	 */
	public static void DealBuinessAfterSendWork(String fk_flow, long workid,
			String doFunc, String WorkIDs, String cFlowNo, int cNodeID,
			String cEmp) {
		if (doFunc.equals("SetParentFlow")) {
			/*
			 * 如果需要设置子父流程信息. 应用于合并审批,当多个子流程合并审批,审批后发起一个父流程.
			 */
			String[] workids = WorkIDs.split("[,]", -1);
			String okworkids = ""; // 成功发送后的workids.
			GenerWorkFlow gwf = new GenerWorkFlow();
			for (String id : workids) {
				if (StringHelper.isNullOrEmpty(id)) {
					continue;
				}

				// 把数据copy到里面,让子流程也可以得到父流程的数据。
				long workidC = Long.parseLong(id);

				// 设置当前流程的ID
				BP.WF.Dev2Interface.SetParentInfo(cFlowNo, workidC, fk_flow,
						workid, cNodeID, cEmp);

				// 判断是否可以执行，不能执行也要发送下去.
				gwf.setWorkID(workidC);
				if (gwf.RetrieveFromDBSources() == 0) {
					continue;
				}

				// 是否可以执行？
				if (BP.WF.Dev2Interface.Flow_IsCanDoCurrentWork(
						gwf.getFK_Flow(), gwf.getFK_Node(), workidC,
						WebUser.getNo()) == false) {
					continue;
				}

				// 执行向下发送.
				try {
					BP.WF.Dev2Interface.Node_SendWork(cFlowNo, workidC);
					okworkids += workidC;
				} catch (RuntimeException ex) {
					// /#region 如果有一个发送失败，就撤销子流程与父流程.
					// 首先把主流程撤销发送.
					BP.WF.Dev2Interface.Flow_DoUnSend(fk_flow, workid);

					// 把已经发送成功的子流程撤销发送.
					String[] myokwokid = okworkids.split("[,]", -1);
					for (String okwokid : myokwokid) {
						if (StringHelper
								.isNullOrEmpty(id)) {
							continue;
						}

						// 把数据copy到里面,让子流程也可以得到父流程的数据。
						workidC = Long.parseLong(id);
						BP.WF.Dev2Interface.Flow_DoUnSend(cFlowNo, workidC);
					}
					// /#endregion 如果有一个发送失败，就撤销子流程与父流程.
					throw new RuntimeException("@在执行子流程(" + gwf.getTitle()
							+ ")发送时出现如下错误:" + ex.getMessage());
				}
			}
		}

	}

	// /#endregion 全局的方法处理

	// /#region web.config 属性.
	/**
	 * 根据配置的信息不同，从不同的表里获取人员岗位信息。
	 */
	public static String getEmpStation() {
		if (BP.WF.Glo.getOSModel() == BP.Sys.OSModel.OneMore) {
			return "Port_DeptEmpStation";
		} else {
			return "Port_EmpStation";
		}
	}

	public static String getEmpDept() {
		if (BP.WF.Glo.getOSModel() == BP.Sys.OSModel.OneMore) {
			return "Port_DeptEmp";
		} else {
			return "Port_EmpDept";
		}
	}

	/**
	 * 是否admin
	 */
	public static boolean getIsAdmin(String userNo) {
		String adminers = SystemConfig.getAppSettings().get("adminers")
				.toString();
		if (StringHelper.isNullOrEmpty(adminers)) {
			adminers = "admin";
		}
		String[] ss = adminers.split(",");
		for (String s : ss) {
			if (s.equals(userNo)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 获取mapdata字段查询Like。
	 * 
	 * @param flowNo
	 *            流程编号
	 * @param colName
	 *            列编号
	 */
	public static String MapDataLikeKeyV1(String flowNo, String colName) {
		flowNo = String.valueOf(Integer.parseInt(flowNo));
		String len = BP.Sys.SystemConfig.getAppCenterDBLengthStr();
		if (flowNo.length() == 1) {
			return " " + colName + " LIKE 'ND" + flowNo + "%' AND " + len + "("
					+ colName + ")=5";
		}
		if (flowNo.length() == 2) {
			return " " + colName + " LIKE 'ND" + flowNo + "%' AND " + len + "("
					+ colName + ")=6";
		}
		if (flowNo.length() == 3) {
			return " " + colName + " LIKE 'ND" + flowNo + "%' AND " + len + "("
					+ colName + ")=7";
		}

		return " " + colName + " LIKE 'ND" + flowNo + "%' AND " + len + "("
				+ colName + ")=8";
	}

	public static String MapDataLikeKey(String flowNo, String colName) {
		flowNo = String.valueOf(Integer.parseInt(flowNo));
		String len = BP.Sys.SystemConfig.getAppCenterDBLengthStr();
		// edited by liuxc,2016-02-22,合并逻辑，原来分流程编号的位数，现在统一处理
		return " (" + colName + " LIKE 'ND" + flowNo + "%' AND " + len + "("
				+ colName + ")=" + ("ND".length() + flowNo.length() + 2)
				+ ") OR (" + colName + " = 'ND" + flowNo + "Rpt' ) OR ("
				+ colName + " LIKE 'ND" + flowNo + "__Dtl%' AND " + len + "("
				+ colName + ")>"
				+ ("ND".length() + flowNo.length() + 2 + "Dtl".length()) + ")";
	}

	/**
	 * 短信时间发送从 默认从 8 点开始.
	 */
	public static int getSMSSendTimeFromHour() {
		try {
			return Integer.parseInt(BP.Sys.SystemConfig.getAppSettings()
					.get("SMSSendTimeFromHour").toString());
		} catch (java.lang.Exception e) {
			return 8;
		}
	}

	/**
	 * 短信时间发送到 默认到 20 点结束.
	 */
	public static int getSMSSendTimeToHour() {
		try {
			return Integer.parseInt(BP.Sys.SystemConfig.getAppSettings()
					.get("SMSSendTimeToHour").toString());
		} catch (java.lang.Exception e) {
			return 8;
		}
	}

	// /#endregion webconfig属性.

	// /#region 常用方法
	private static String html = "";
	private static ArrayList htmlArr = new ArrayList();
	private static String backHtml = "";
	private static long workid = 0;

	/**
	 * 模拟运行
	 * 
	 * @param flowNo
	 *            流程编号
	 * @param empNo
	 *            要执行的人员.
	 * @return 执行信息.
	 * @throws Exception
	 */
	public static String Simulation_RunOne(String flowNo, String empNo,
			String paras) throws Exception {
		backHtml = ""; // 需要重新赋空值
		Hashtable ht = null;
		if (StringHelper.isNullOrEmpty(paras) == false) {
			AtPara ap = new AtPara(paras);
			ht = ap.getHisHT();
		}

		Emp emp = new Emp(empNo);
		backHtml += " **** 开始使用:"
				+ Glo.GenerUserImgSmallerHtml(emp.getNo(), emp.getName())
				+ "登录模拟执行工作流程";
		BP.WF.Dev2Interface.Port_Login(empNo);

		workid = BP.WF.Dev2Interface.Node_CreateBlankWork(flowNo, ht, null,
				emp.getNo(), null);
		SendReturnObjs objs = BP.WF.Dev2Interface.Node_SendWork(flowNo, workid,
				ht);
		backHtml += objs.ToMsgOfHtml().replace("@", "<br>@"); // 记录消息.

		String[] accepters = objs.getVarAcceptersID().split("[,]", -1);

		for (String acce : accepters) {
			if (StringHelper.isNullOrEmpty(acce) == true) {
				continue;
			}

			// 执行发送.
			Simulation_Run_S1(flowNo, workid, acce, ht, empNo);
			break;
		}
		// return html;
		// return htmlArr;
		return backHtml;
	}

	private static boolean isAdd = true;

	private static void Simulation_Run_S1(String flowNo, long workid,
			String empNo, Hashtable ht, String beginEmp) throws Exception {
		// htmlArr.Add(html);
		Emp emp = new Emp(empNo);
		// html = "";
		backHtml += "empNo" + beginEmp;
		backHtml += "<br> **** 让:"
				+ Glo.GenerUserImgSmallerHtml(emp.getNo(), emp.getName())
				+ "执行模拟登录. ";
		// 让其登录.
		BP.WF.Dev2Interface.Port_Login(empNo);

		// 执行发送.
		SendReturnObjs objs = BP.WF.Dev2Interface.Node_SendWork(flowNo, workid,
				ht);
		backHtml += "<br>" + objs.ToMsgOfHtml().replace("@", "<br>@");

		if (objs.getVarAcceptersID() == null) {
			isAdd = false;
			backHtml += " <br> **** 流程结束,查看<a href='/WF/WFRpt.jsp?WorkID="
					+ workid + "&FK_Flow=" + flowNo
					+ "' target=_blank >流程轨迹</a> ====";
			// htmlArr.Add(html);
			// backHtml += "nextEmpNo";
			return;
		}

		if (StringHelper.isNullOrEmpty(objs
				.getVarAcceptersID())) // 此处添加为空判断，跳过下面方法的执行，否则出错。
		{
			return;
		}
		String[] accepters = objs.getVarAcceptersID().split("[,]", -1);

		for (String acce : accepters) {
			if (StringHelper.isNullOrEmpty(acce) == true) {
				continue;
			}

			// 执行发送.
			Simulation_Run_S1(flowNo, workid, acce, ht, beginEmp);
			break; // 就不让其执行了.
		}
	}

	/**
	 * 是否手机访问?
	 * 
	 * @return
	 */
	public static boolean IsMobile() {
		if (SystemConfig.getIsBSsystem() == false) {
			return false;
		}

		String agent = BP.Sys.Glo.getRequest().getHeader("UserAgent")
				.toLowerCase().trim();
		if (agent.equals("") || agent.indexOf("mozilla") != -1
				|| agent.indexOf("opera") != -1) {
			return false;
		}
		return true;
	}

	/**
	 * 是否启用草稿
	 */
	public static boolean getIsEnableDraft() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsEnableDraft", false);
	}

	/**
	 * 产生单据编号
	 * 
	 * @param billFormat
	 * @param en
	 * @return
	 */
	public static String GenerBillNo(String billNo, long workid, Entity en,
			String flowPTable) {
		if (StringHelper.isNullOrEmpty(billNo)) {
			return "";
		}
		if (billNo.contains("@")) {
			billNo = BP.WF.Glo.DealExp(billNo, en, null);
		}

		/* 如果，Bill 有规则 */
		if(billNo.contains("{YYYY}") || billNo.contains("{yyyy}"))
		{
			billNo = billNo.replace("{YYYY}", DateUtils.format(new Date(), "yyyy"));
			billNo = billNo.replace("{yyyy}", DateUtils.format(new Date(), "yyyy"));
		}else
		{
			billNo = billNo.replace("{yy}", DateUtils.format(new Date(), "yy"));
			billNo = billNo.replace("{YY}", DateUtils.format(new Date(), "YY"));
		}

		billNo = billNo.replace("{MM}", DateUtils.format(new Date(), "MM"));
		billNo = billNo.replace("{mm}", DateUtils.format(new Date(), "mm"));

//		billNo = billNo.replace("{DD}",
//				String.format("%d", new java.util.Date()));
//		billNo = billNo.replace("{dd}",
//				String.format("%d", new java.util.Date()));
		billNo = billNo.replace("{DD}",DateUtils.format(new Date(), "MM"));
		billNo = billNo.replace("{dd}",DateUtils.format(new Date(), "mm"));
		
		billNo = billNo.replace("{HH}", DateUtils.format(new Date(), "HH"));
		billNo = billNo.replace("{hh}", DateUtils.format(new Date(), "HH"));

		billNo = billNo.replace("{LSH}", String.valueOf(workid));
		billNo = billNo.replace("{WorkID}", String.valueOf(workid));
		billNo = billNo.replace("{OID}", String.valueOf(workid));

		if (billNo.contains("@WebUser.DeptZi")) {
			String val = DBAccess.RunSQLReturnStringIsNull(
					"SELECT Zi FROM Port_Dept WHERE No='"
							+ WebUser.getFK_Dept() + "'", "");
			billNo = billNo.replace("@WebUser.DeptZi", val.toString());
		}

		if (billNo.contains("{ParentBillNo}")) {
			String pWorkID = DBAccess.RunSQLReturnStringIsNull(
					"SELECT PWorkID FROM " + flowPTable + " WHERE WFState >1 AND OID="
							+ workid, "0");
			String parentBillNo = DBAccess.RunSQLReturnStringIsNull(
					"SELECT BillNo FROM WF_GenerWorkFlow WHERE WorkID="
							+ pWorkID, "");
			billNo = billNo.replace("{ParentBillNo}", parentBillNo);

			String sql = "";
			int num = 0;
			for (int i = 2; i < 7; i++) {
				if (billNo.contains("{LSH" + i + "}") == false) {
					continue;
				}
				if(flowPTable.startsWith("ND")){
					sql = "SELECT COUNT(OID) FROM " + flowPTable
							+ " WHERE PWorkID =" + pWorkID ;
				}else{
					sql = "SELECT COUNT(OID) FROM " + flowPTable
							+ " WHERE PWorkID =" + pWorkID +" AND WFState >1 ";
				}
				num = BP.DA.DBAccess.RunSQLReturnValInt(sql, 0);
				billNo = billNo
						+ StringHelper.padLeft(
								String.valueOf(num), i, '0');
				billNo = billNo.replace("{LSH" + i + "}", "");
				break;
			}
		} else {
			String sql = "";
			int num = 0;
			for (int i = 2; i < 7; i++) {
				if (billNo.contains("{LSH" + i + "}") == false) {
					continue;
				}

				billNo = billNo.replace("{LSH" + i + "}", "");
				if(flowPTable.startsWith("ND")){
					sql = "SELECT COUNT(*) FROM " + flowPTable
							+ " WHERE BillNo LIKE '" + billNo + "%'";
				}else{
					sql = "SELECT COUNT(*) FROM " + flowPTable
							+ " WHERE BillNo LIKE '" + billNo + "%' AND WFState >1";
				}
				if (DBAccess.getAppCenterDBType() == DBType.MSSQL) {
					// 改为取最大值
					if(flowPTable.startsWith("ND")){
						sql = " SELECT isnull(convert(int,max(RIGHT(billno,len(billno)-len('"
								+ billNo
								+ "')-1))),0) FROM "
								+ flowPTable
								+ " WHERE BillNo LIKE '" + billNo + "%'";
					}else {
						sql = " SELECT isnull(convert(int,max(RIGHT(billno,len(billno)-len('"
								+ billNo
								+ "')-1))),0) FROM "
								+ flowPTable
								+ " WHERE BillNo LIKE '" + billNo + "%' AND WFState >1";
					}
				}

				num = BP.DA.DBAccess.RunSQLReturnValInt(sql, 0) + 1;
				billNo = billNo
						+ StringHelper.padLeft(
								String.valueOf(num), i, '0');
			}
		}
		// if (billNo.contains("@") == true)
		// billNo = Glo.DealExp(billNo, en, null);

		return billNo;
	}

	/**
	 * 加入track
	 * 
	 * @param at
	 *            事件类型
	 * @param flowNo
	 *            流程编号
	 * @param workID
	 *            工作ID
	 * @param fid
	 *            流程ID
	 * @param fromNodeID
	 *            从节点编号
	 * @param fromNodeName
	 *            从节点名称
	 * @param fromEmpID
	 *            从人员ID
	 * @param fromEmpName
	 *            从人员名称
	 * @param toNodeID
	 *            到节点编号
	 * @param toNodeName
	 *            到节点名称
	 * @param toEmpID
	 *            到人员ID
	 * @param toEmpName
	 *            到人员名称
	 * @param note
	 *            消息
	 * @param tag
	 *            参数用@分开
	 */
	public static void AddToTrack(ActionType at, String flowNo, long workID,
			long fid, int fromNodeID, String fromNodeName, String fromEmpID,
			String fromEmpName, int toNodeID, String toNodeName,
			String toEmpID, String toEmpName, String note, String tag) {
		if (toNodeID == 0) {
			toNodeID = fromNodeID;
			toNodeName = fromNodeName;
		}

		Track t = new Track();
		t.setWorkID(workID);
		t.setFID(fid);
		t.setRDT(DataType.getCurrentDataTime());
		t.setHisActionType(at);

		t.setNDFrom(fromNodeID);
		t.setNDFromT(fromNodeName);

		t.setEmpFrom(fromEmpID);
		t.setEmpFromT(fromEmpName);
		t.FK_Flow = flowNo;

		t.setNDTo(toNodeID);
		t.setNDToT(toNodeName);

		t.setEmpTo(toEmpID);
		t.setEmpToT(toEmpName);
		t.setMsg(note);

		// 参数.
		if (tag != null) {
			t.setTag(tag);
		}

		try {
			t.Insert();
		} catch (java.lang.Exception e) {
			t.CheckPhysicsTable();
			t.Insert();
		}
	}

	/**
	 * 计算表达式是否通过(或者是否正确.)
	 * 
	 * @param exp
	 *            表达式
	 * @param en
	 *            实体
	 * @return true/false
	 */
	public static boolean ExeExp(String exp, Entity en) {
		exp = exp.replace("@WebUser.No", WebUser.getNo());
		exp = exp.replace("@WebUser.Name", WebUser.getName());
		exp = exp.replace("@WebUser.FK_Dept", WebUser.getFK_Dept());
		exp = exp.replace("@WebUser.FK_DeptName", WebUser.getFK_DeptName());

		String[] strs = exp.split("[ ]", -1);
		boolean isPass = false;

		String key = strs[0].trim();
		String oper = strs[1].trim();
		String val = strs[2].trim();
		val = val.replace("'", "");
		val = val.replace("%", "");
		val = val.replace("~", "");
		BP.En.Row row = en.getRow();
		for (String item : row.keySet()) {
			if (!item.trim().equals(key)) {
				continue;
			}

			String valPara = row.get(key).toString();
			if (oper.equals("=")) {
				if (val.equals(valPara)) {
					return true;
				}
			}

			if (oper.toUpperCase().equals("LIKE")) {
				if (valPara.contains(val)) {
					return true;
				}
			}

			if (oper.equals(">")) {
				if (Float.parseFloat(valPara) > Float.parseFloat(val)) {
					return true;
				}
			}
			if (oper.equals(">=")) {
				if (Float.parseFloat(valPara) >= Float.parseFloat(val)) {
					return true;
				}
			}
			if (oper.equals("<")) {
				if (Float.parseFloat(valPara) < Float.parseFloat(val)) {
					return true;
				}
			}
			if (oper.equals("<=")) {
				if (Float.parseFloat(valPara) <= Float.parseFloat(val)) {
					return true;
				}
			}

			if (oper.equals("!=")) {
				if (Float.parseFloat(valPara) != Float.parseFloat(val)) {
					return true;
				}
			}

			throw new RuntimeException("@参数格式错误:" + exp + " Key=" + key
					+ " oper=" + oper + " Val=" + val);
		}

		return false;
	}

	/**
	 * 执行PageLoad装载数据
	 * 
	 * @param item
	 * @param en
	 * @param mattrs
	 * @param dtls
	 * @return
	 */
	public static Entity DealPageLoadFull(Entity en, MapExt item,
			MapAttrs mattrs, MapDtls dtls) {
		if (item == null) {
			return en;
		}

		DataTable dt = null;
		String sql = item.getTag();
		if (StringHelper.isNullOrEmpty(sql) == false) {
			/* 如果有填充主表的sql */
			sql = Glo.DealExp(sql, en, null);

			if (StringHelper.isNullOrEmpty(sql) == false) {
				if (sql.contains("@")) {
					throw new RuntimeException("设置的sql有错误可能有没有替换的变量:" + sql);
				}
				dt = DBAccess.RunSQLReturnTable(sql);
				if (dt.Rows.size() == 1) {
					DataRow dr = dt.Rows.get(0);
					for (DataColumn dc : dt.Columns) {
						// 去掉一些不需要copy的字段.
						String columnName = dc.ColumnName;
						if (columnName.equals(WorkAttr.OID)
								|| columnName.equals(WorkAttr.FID)
								|| columnName.equals(WorkAttr.Rec)
								|| columnName.equals(WorkAttr.MD5)
								|| columnName.equals(WorkAttr.MyNum)
								|| columnName.equals(WorkAttr.RDT)
								|| columnName.equals("RefPK")
								|| columnName.equals(WorkAttr.RecText)) {
							continue;
						}

						if (StringHelper
								.isNullOrEmpty(en
										.GetValStringByKey(dc.ColumnName))
								|| en.GetValStringByKey(dc.ColumnName).equals(
										"0")) {
							en.SetValByKey(dc.ColumnName,
									dr.getValue(dc.ColumnName).toString());
						}
					}
				}
			}
		}

		if (StringHelper.isNullOrEmpty(item.getTag1())
				|| item.getTag1().length() < 15) {
			return en;
		}

		// 填充从表.
		for (MapDtl dtl : dtls.ToJavaList()) {
			String[] sqls = item.getTag1().split("[*]", -1);
			for (String mysql : sqls) {
				if (StringHelper.isNullOrEmpty(mysql)) {
					continue;
				}
				if (mysql.contains(dtl.getNo() + "=") == false) {
					continue;
				}
				if (mysql.equals(dtl.getNo() + "=") == true) {
					continue;
				}

				// /#region 处理sql.
				sql = Glo.DealExp(mysql, en, null);
				// /#endregion 处理sql.

				if (StringHelper.isNullOrEmpty(sql)) {
					continue;
				}

				if (sql.contains("@")) {
					throw new RuntimeException("设置的sql有错误可能有没有替换的变量:" + sql);
				}

				GEDtls gedtls = null;

				try {
					gedtls = new GEDtls(dtl.getNo());
					gedtls.Delete(GEDtlAttr.RefPK, en.getPKVal());
				} catch (RuntimeException ex) {
					((GEDtl) ((gedtls.getGetNewEntity() instanceof GEDtl) ? gedtls
							.getGetNewEntity() : null)).CheckPhysicsTable();
				}

				dt = DBAccess.RunSQLReturnTable(sql.startsWith(dtl.getNo()
						+ "=") ? sql.substring((dtl.getNo() + "=").length())
						: sql);
				for (DataRow dr : dt.Rows) {
					GEDtl gedtl = (GEDtl) ((gedtls.getGetNewEntity() instanceof GEDtl) ? gedtls
							.getGetNewEntity() : null);
					for (DataColumn dc : dt.Columns) {
						gedtl.SetValByKey(dc.ColumnName,
								dr.getValue(dc.ColumnName).toString());
					}

					gedtl.setRefPK(en.getPKVal().toString());
					gedtl.setRDT(DataType.getCurrentDataTime());
					gedtl.setRec(WebUser.getNo());
					gedtl.Insert();
				}
			}
		}
		return en;
	}

	/**
	 * 处理表达式
	 * 
	 * @param exp
	 *            表达式
	 * @param en
	 *            数据源
	 * @param errInfo
	 *            错误
	 * @return
	 */
	public static String DealExp(String exp, Entity en, String errInfo) {
		exp = exp.replace("~", "'");

		// 首先替换加; 的。
		exp = exp.replace("@WebUser.No;", WebUser.getNo());
		exp = exp.replace("@WebUser.Name;", WebUser.getName());
		exp = exp.replace("@WebUser.FK_Dept;", WebUser.getFK_Dept());
		exp = exp.replace("@WebUser.FK_DeptName;", WebUser.getFK_DeptName());

		// 替换没有 ; 的 .
		exp = exp.replace("@WebUser.No", WebUser.getNo());
		exp = exp.replace("@WebUser.Name", WebUser.getName());
		exp = exp.replace("@WebUser.FK_Dept", WebUser.getFK_Dept());
		exp = exp.replace("@WebUser.FK_DeptName", WebUser.getFK_DeptName());

		if (exp.contains("@") == false) {
			exp = exp.replace("~", "'");
			return exp;
		}

		// 增加对新规则的支持. @MyField; 格式.
		for (Attr item : en.getEnMap().getAttrs()) {
			if (exp.contains("@" + item.getKey() + ";")) {
				exp = exp.replace("@" + item.getKey() + ";",
						en.GetValStrByKey(item.getKey()));
			}
		}
		if (exp.contains("@") == false) {
			return exp;
		}

		// /#region 解决排序问题.
		Attrs attrs = en.getEnMap().getAttrs();
		String mystrs = "";
		for (Attr attr : attrs) {
			if (attr.getMyDataType() == DataType.AppString) {
				mystrs += "@" + attr.getKey() + ",";
			} else {
				mystrs += "@" + attr.getKey();
			}
		}
		String[] strs = mystrs.split("[@]", -1);
		DataTable dt = new DataTable();
		dt.Columns.Add(new DataColumn("No", String.class));
		for (String str : strs) {
			if (StringHelper.isNullOrEmpty(str)) {
				continue;
			}

			DataRow dr = dt.NewRow();
			dr.setValue(0, str);
			dt.Rows.add(dr);
		}
		// DataView dv = dt.DefaultView;
		// dv.Sort = "No DESC";
		// DataTable dtNew = dv.Table;
		// /#endregion 解决排序问题.

		// /#region 替换变量.
		for (DataRow dr : dt.Rows) {
			String key = dr.getValue(0).toString();
			boolean isStr = key.contains(",");
			if (isStr == true) {
				key = key.replace(",", "");
				exp = exp.replace("@" + key, en.GetValStrByKey(key));
			} else {
				exp = exp.replace("@" + key, en.GetValStrByKey(key));
			}
		}

		// 处理Para的替换.
		if (exp.contains("@") && Glo.getSendHTOfTemp() != null) {
			for (Object key : Glo.getSendHTOfTemp().keySet()) {
				exp = exp.replace("@" + key, Glo.getSendHTOfTemp().get(key)
						.toString());
			}
		}

		// if (exp.contains("@") && SystemConfig.getIsBSsystem() == true)
		// {
		// /*如果是bs*/
		// for (String key :
		// System.Web.HttpContext.Current.Request.QueryString.keySet())
		// {
		// exp = exp.replace("@" + key,
		// System.Web.HttpContext.Current.Request.QueryString[key]);
		// }
		// }
		// /#endregion

		exp = exp.replace("~", "'");
		// exp = exp.replace("''", "'");
		// exp = exp.replace("''", "'");
		// exp = exp.replace("=' ", "=''");
		// exp = exp.replace("= ' ", "=''");
		return exp;
	}

	/**
	 * 加密MD5
	 * 
	 * @param s
	 * @return
	 */
	public static String GenerMD5(BP.WF.Work wk) {
		String s = null;
		for (Attr attr : wk.getEnMap().getAttrs()) {
			String key = attr.getKey();
			if (key.equals(WorkAttr.MD5) || key.equals(WorkAttr.RDT)
					|| key.equals(WorkAttr.CDT) || key.equals(WorkAttr.Rec)
					|| key.equals(StartWorkAttr.Title)
					|| key.equals(StartWorkAttr.Emps)
					|| key.equals(StartWorkAttr.FK_Dept)
					|| key.equals(StartWorkAttr.PRI)
					|| key.equals(StartWorkAttr.FID)) {
				continue;
			}

			String obj = (String) ((attr.getDefaultVal() instanceof String) ? attr
					.getDefaultVal() : null);
			// if (obj == null)
			// continue;
			if (obj != null && obj.contains("@")) {
				continue;
			}

			s += wk.GetValStrByKey(attr.getKey());
		}
		s += "ccflow";
		// return
		// System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(s,
		// "MD5").toLowerCase();
		return DigestUtils.md5Hex(s).toLowerCase();
	}

	/**
	 * 装载流程数据
	 * 
	 * @param xlsFile
	 * @throws Exception
	 */
	public static String LoadFlowDataWithToSpecNode(String xlsFile)
			throws Exception {
		DataTable dt = BP.DA.DBLoad.GetTableByExt(xlsFile);
		String err = "";
		String info = "";

		for (DataRow dr : dt.Rows) {
			String flowPK = dr.getValue("FlowPK").toString();
			String starter = dr.getValue("Starter").toString();
			String executer = dr.getValue("Executer").toString();
			int toNode = Integer.parseInt(dr.getValue("ToNodeID").toString()
					.replace("ND", ""));
			Node nd = new Node();
			nd.setNodeID(toNode);
			if (nd.RetrieveFromDBSources() == 0) {
				err += "节点ID错误:" + toNode;
				continue;
			}
			String sql = "SELECT count(*) as Num FROM ND"
					+ Integer.parseInt(nd.getFK_Flow()) + "01 WHERE FlowPK='"
					+ flowPK + "'";
			int i = DBAccess.RunSQLReturnValInt(sql);
			if (i == 1) {
				continue; // 此数据已经调度了。
			}

			// /#region 检查数据是否完整。
			BP.Port.Emp emp = new BP.Port.Emp();
			emp.setNo(executer);
			if (emp.RetrieveFromDBSources() == 0) {
				err += "@账号:" + starter + ",不存在。";
				continue;
			}
			if (StringHelper.isNullOrEmpty(emp
					.getFK_Dept())) {
				err += "@账号:" + starter + ",没有部门。";
				continue;
			}

			emp.setNo(starter);
			if (emp.RetrieveFromDBSources() == 0) {
				err += "@账号:" + executer + ",不存在。";
				continue;
			}
			if (StringHelper.isNullOrEmpty(emp
					.getFK_Dept())) {
				err += "@账号:" + executer + ",没有部门。";
				continue;
			}
			// /#endregion 检查数据是否完整。

			BP.Web.WebUser.SignInOfGener(emp);
			Flow fl = nd.getHisFlow();
			Work wk = fl.NewWork();

			Attrs attrs = wk.getEnMap().getAttrs();
			// foreach (Attr attr in wk.getEnMap().getAttrs())
			// {
			// }

			for (DataColumn dc : dt.Columns) {
				Attr attr = attrs.GetAttrByKey(dc.ColumnName.trim());
				if (attr == null) {
					continue;
				}

				String val = dr.getValue(dc.ColumnName).toString().trim();
				switch (attr.getMyDataType()) {
				case DataType.AppString:
				case DataType.AppDate:
				case DataType.AppDateTime:
					wk.SetValByKey(attr.getKey(), val);
					break;
				case DataType.AppInt:
				case DataType.AppBoolean:
					wk.SetValByKey(attr.getKey(), Integer.parseInt(val));
					break;
				case DataType.AppMoney:
				case DataType.AppDouble:
				case DataType.AppRate:
				case DataType.AppFloat:
					wk.SetValByKey(attr.getKey(), Float.parseFloat(val));
					break;
				default:
					wk.SetValByKey(attr.getKey(), val);
					break;
				}
			}

			wk.SetValByKey(WorkAttr.Rec, BP.Web.WebUser.getNo());
			wk.SetValByKey(StartWorkAttr.FK_Dept, BP.Web.WebUser.getFK_Dept());
			wk.SetValByKey("FK_NY", DataType.getCurrentYearMonth());
			wk.SetValByKey(WorkAttr.MyNum, 1);
			wk.Update();

			Node ndStart = nd.getHisFlow().getHisStartNode();
			WorkNode wn = new WorkNode(wk, ndStart);
			try {
				info += "<hr>" + wn.NodeSend(nd, executer).ToMsgOfHtml();
			} catch (RuntimeException ex) {
				err += "<hr>" + ex.getMessage();
				WorkFlow wf = new WorkFlow(fl, wk.getOID());
				wf.DoDeleteWorkFlowByReal(true);
				continue;
			}

			// /#region 更新 下一个节点数据。
			Work wkNext = nd.getHisWork();
			wkNext.setOID(wk.getOID());
			wkNext.RetrieveFromDBSources();
			attrs = wkNext.getEnMap().getAttrs();
			for (DataColumn dc : dt.Columns) {
				Attr attr = attrs.GetAttrByKey(dc.ColumnName.trim());
				if (attr == null) {
					continue;
				}

				String val = dr.getValue(dc.ColumnName).toString().trim();
				switch (attr.getMyDataType()) {
				case DataType.AppString:
				case DataType.AppDate:
				case DataType.AppDateTime:
					wkNext.SetValByKey(attr.getKey(), val);
					break;
				case DataType.AppInt:
				case DataType.AppBoolean:
					wkNext.SetValByKey(attr.getKey(), Integer.parseInt(val));
					break;
				case DataType.AppMoney:
				case DataType.AppDouble:
				case DataType.AppRate:
				case DataType.AppFloat:
					wkNext.SetValByKey(attr.getKey(), Float.parseFloat(val));
					break;
				default:
					wkNext.SetValByKey(attr.getKey(), val);
					break;
				}
			}

			wkNext.DirectUpdate();

			GERpt rtp = fl.getHisGERpt();
			rtp.SetValByKey("OID", wkNext.getOID());
			rtp.RetrieveFromDBSources();
			rtp.Copy(wkNext);
			rtp.DirectUpdate();

			// /#endregion 更新 下一个节点数据。
		}
		return info + err;
	}

	public static String LoadFlowDataWithToSpecEndNode(String xlsFile)
			throws Exception {
		DataTable dt = BP.DA.DBLoad.GetTableByExt(xlsFile);
		DataSet ds = new DataSet();
		ds.Tables.add(dt);
		ds.WriteXml("C:\\已完成.xml");

		String err = "";
		String info = "";
		int idx = 0;
		for (DataRow dr : dt.Rows) {
			String flowPK = dr.getValue("FlowPK").toString().trim();
			if (StringHelper.isNullOrEmpty(flowPK)) {
				continue;
			}

			String starter = dr.getValue("Starter").toString();
			String executer = dr.getValue("Executer").toString();
			int toNode = Integer.parseInt(dr.getValue("ToNodeID").toString()
					.replace("ND", ""));
			Node ndOfEnd = new Node();
			ndOfEnd.setNodeID(toNode);
			if (ndOfEnd.RetrieveFromDBSources() == 0) {
				err += "节点ID错误:" + toNode;
				continue;
			}

			if (ndOfEnd.getIsEndNode() == false) {
				err += "节点ID错误:" + toNode + ", 非结束节点。";
				continue;
			}

			String sql = "SELECT count(*) as Num FROM ND"
					+ Integer.parseInt(ndOfEnd.getFK_Flow())
					+ "01 WHERE FlowPK='" + flowPK + "'";
			int i = DBAccess.RunSQLReturnValInt(sql);
			if (i == 1) {
				continue; // 此数据已经调度了。
			}

			// /#region 检查数据是否完整。
			// 发起人发起。
			BP.Port.Emp emp = new BP.Port.Emp();
			emp.setNo(executer);
			if (emp.RetrieveFromDBSources() == 0) {
				err += "@账号:" + starter + ",不存在。";
				continue;
			}

			if (StringHelper.isNullOrEmpty(emp
					.getFK_Dept())) {
				err += "@账号:" + starter + ",没有设置部门。";
				continue;
			}

			emp = new BP.Port.Emp();
			emp.setNo(starter);
			if (emp.RetrieveFromDBSources() == 0) {
				err += "@账号:" + starter + ",不存在。";
				continue;
			} else {
				emp.RetrieveFromDBSources();
				if (StringHelper.isNullOrEmpty(emp
						.getFK_Dept())) {
					err += "@账号:" + starter + ",没有设置部门。";
					continue;
				}
			}
			// /#endregion 检查数据是否完整。

			BP.Web.WebUser.SignInOfGener(emp);
			Flow fl = ndOfEnd.getHisFlow();
			Work wk = fl.NewWork();
			for (DataColumn dc : dt.Columns) {
				wk.SetValByKey(dc.ColumnName.trim(), dr.getValue(dc.ColumnName)
						.toString().trim());
			}

			wk.SetValByKey(WorkAttr.Rec, BP.Web.WebUser.getNo());
			wk.SetValByKey(StartWorkAttr.FK_Dept, BP.Web.WebUser.getFK_Dept());
			wk.SetValByKey("FK_NY", DataType.getCurrentYearMonth());
			wk.SetValByKey(WorkAttr.MyNum, 1);
			wk.Update();

			Node ndStart = fl.getHisStartNode();
			WorkNode wn = new WorkNode(wk, ndStart);
			try {
				info += "<hr>" + wn.NodeSend(ndOfEnd, executer).ToMsgOfHtml();
			} catch (RuntimeException ex) {
				err += "<hr>启动错误:" + ex.getMessage();
				DBAccess.RunSQL("DELETE FROM ND"
						+ Integer.parseInt(ndOfEnd.getFK_Flow())
						+ "01 WHERE FlowPK='" + flowPK + "'");
				WorkFlow wf = new WorkFlow(fl, wk.getOID());
				wf.DoDeleteWorkFlowByReal(true);
				continue;
			}

			// 结束点结束。
			emp = new BP.Port.Emp(executer);
			BP.Web.WebUser.SignInOfGener(emp);

			Work wkEnd = ndOfEnd.GetWork(wk.getOID());
			for (DataColumn dc : dt.Columns) {
				wkEnd.SetValByKey(dc.ColumnName.trim(),
						dr.getValue(dc.ColumnName).toString().trim());
			}

			wkEnd.SetValByKey(WorkAttr.Rec, BP.Web.WebUser.getNo());
			wkEnd.SetValByKey(StartWorkAttr.FK_Dept,
					BP.Web.WebUser.getFK_Dept());
			wkEnd.SetValByKey("FK_NY", DataType.getCurrentYearMonth());
			wkEnd.SetValByKey(WorkAttr.MyNum, 1);
			wkEnd.Update();

			try {
				WorkNode wnEnd = new WorkNode(wkEnd, ndOfEnd);
				// wnEnd.AfterNodeSave();
				info += "<hr>" + wnEnd.NodeSend().ToMsgOfHtml();
			} catch (RuntimeException ex) {
				err += "<hr>结束错误(系统直接删除它):" + ex.getMessage();
				WorkFlow wf = new WorkFlow(fl, wk.getOID());
				wf.DoDeleteWorkFlowByReal(true);
				continue;
			}
		}
		return info + err;
	}

	/**
	 * 判断是否登录当前UserNo
	 * 
	 * @param userNo
	 */
	public static void IsSingleUser(String userNo) {
		if (StringHelper
				.isNullOrEmpty(WebUser.getNo())
				|| !userNo.equals(WebUser.getNo())) {
			if (!StringHelper.isNullOrEmpty(userNo)) {
				BP.WF.Dev2Interface.Port_Login(userNo);
			}
		}
	}

	// public static void ResetFlowView()
	// {
	// string sql = "DROP VIEW V_WF_Data ";
	// try
	// {
	// BP.DA.DBAccess.RunSQL(sql);
	// }
	// catch
	// {
	// }

	// Flows fls = new Flows();
	// fls.RetrieveAll();
	// sql = "CREATE VIEW V_WF_Data AS ";
	// foreach (Flow fl in fls)
	// {
	// fl.CheckRpt();
	// sql += "\t\n SELECT '" + fl.getNo() + "' as FK_Flow, '" + fl.getName() +
	// "' AS FlowName, '" + fl.FK_FlowSort +
	// "' as FK_FlowSort,CDT,Emps,FID,FK_Dept,FK_NY,";
	// sql += "MyNum,OID,RDT,Rec,Title,WFState,FlowEmps,";
	// sql +=
	// "FlowStarter,FlowStartRDT,FlowEnder,FlowEnderRDT,FlowDaySpan FROM ND" +
	// int.Parse(fl.getNo()) + "Rpt";
	// sql += "\t\n  UNION";
	// }
	// sql = sql.Substring(0, sql.Length - 6);
	// sql += "\t\n GO";
	// BP.DA.DBAccess.RunSQL(sql);
	// }
	public static void Rtf2PDF(Object pathOfRtf, Object pathOfPDF) {
		// Object Nothing = System.Reflection.Missing.Value;
		// //创建一个名为WordApp的组件对象
		// Microsoft.Office.Interop.Word.Application wordApp =
		// new Microsoft.Office.Interop.Word.ApplicationClass();
		// //创建一个名为WordDoc的文档对象并打开
		// Microsoft.Office.Interop.Word.Document doc =
		// wordApp.Documents.Open(ref pathOfRtf, ref Nothing, ref Nothing, ref
		// Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref
		// Nothing);

		// //设置保存的格式
		// object filefarmat =
		// Microsoft.Office.Interop.Word.WdSaveFormat.wdFormatPDF;

		// //保存为PDF
		// doc.SaveAs(ref pathOfPDF, ref filefarmat, ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref
		// Nothing, ref Nothing,
		// ref Nothing, ref Nothing, ref Nothing);
		// //关闭文档对象
		// doc.Close(ref Nothing, ref Nothing, ref Nothing);
		// //推出组建
		// wordApp.Quit(ref Nothing, ref Nothing, ref Nothing);
		// GC.Collect();
	}

	// /#endregion 常用方法

	// /#region 属性
	/**
	 * 消息
	 */
	public static String getSessionMsg() {
		Paras p = new Paras();
		p.SQL = "SELECT Msg FROM WF_Emp where No="
				+ SystemConfig.getAppCenterDBVarStr() + "FK_Emp";
		p.AddFK_Emp();
		return DBAccess.RunSQLReturnString(p);

		// string SQL =
		// "SELECT Msg FROM WF_Emp where No='"+BP.Web.WebUser.getNo()+"'";
		// return DBAccess.RunSQLReturnString(SQL);
	}

	public static void setSessionMsg(String value) {
		if (StringHelper.isNullOrEmpty(value) == true) {
			return;
		}

		Paras p = new Paras();
		p.SQL = "UPDATE WF_Emp SET Msg=" + SystemConfig.getAppCenterDBVarStr()
				+ "v WHERE No=" + SystemConfig.getAppCenterDBVarStr()
				+ "FK_Emp";
		p.Add("v", value);
		p.AddFK_Emp();

		int i = DBAccess.RunSQL(p);
		if (i == 0) {
			/* 如果没有更新到. */
			BP.WF.Port.WFEmp emp = new BP.WF.Port.WFEmp();
			emp.setNo(BP.Web.WebUser.getNo());
			emp.setName(BP.Web.WebUser.getName());
			emp.setFK_Dept(BP.Web.WebUser.getFK_Dept());
			emp.Insert();
			DBAccess.RunSQL(p);
		}

		// string SQL = "UPDATE WF_Emp SET Msg='" + value + "' WHERE No='" +
		// BP.Web.WebUser.getNo() + "'";
		// DBAccess.RunSQL(SQL);
	}

	private static String _FromPageType = null;

	public static String getFromPageType() {
		_FromPageType = null;
		if (_FromPageType == null) {
			try {
				String url = BP.Sys.Glo.getRequest().getRemoteAddr();
				int i = url.lastIndexOf("/") + 1;
				int i2 = url.indexOf(".jsp") - 6;

				url = url.substring(i);
				url = url.substring(0, url.indexOf(".jsp"));
				_FromPageType = url;
				if (_FromPageType.contains("SmallSingle")) {
					_FromPageType = "SmallSingle";
				} else if (_FromPageType.contains("Small")) {
					_FromPageType = "Small";
				} else {
					_FromPageType = "";
				}
			} catch (RuntimeException ex) {
				_FromPageType = "";
				// throw new Exception(ex.Message + url + " i=" + i + " i2=" +
				// i2);
			}
		}
		return _FromPageType;
	}

	private static Hashtable _SendHTOfTemp = null;

	/**
	 * 临时的发送传输变量.
	 */
	public static Hashtable getSendHTOfTemp() {
		if (_SendHTOfTemp == null) {
			_SendHTOfTemp = new Hashtable();
		}
		return (Hashtable) ((_SendHTOfTemp.get(BP.Web.WebUser.getNo()) instanceof Hashtable) ? _SendHTOfTemp
				.get(BP.Web.WebUser.getNo()) : null);
	}

	public static void setSendHTOfTemp(Hashtable value) {
		if (_SendHTOfTemp == null) {
			_SendHTOfTemp = new Hashtable();
		}
		_SendHTOfTemp.put(BP.Web.WebUser.getNo(), value);
	}

	/**
	 * 报表属性集合
	 */
	private static Attrs _AttrsOfRpt = null;

	/**
	 * 报表属性集合
	 */
	public static Attrs getAttrsOfRpt() {
		if (_AttrsOfRpt == null) {
			_AttrsOfRpt = new Attrs();
			_AttrsOfRpt.AddTBInt(GERptAttr.OID, 0, "WorkID", true, true);
			_AttrsOfRpt.AddTBInt(GERptAttr.FID, 0, "FlowID", false, false);

			_AttrsOfRpt.AddTBString(GERptAttr.Title, null, "标题", true, false,
					0, 10, 10);
			_AttrsOfRpt.AddTBString(GERptAttr.FlowStarter, null, "发起人", true,
					false, 0, 10, 10);
			_AttrsOfRpt.AddTBString(GERptAttr.FlowStartRDT, null, "发起时间", true,
					false, 0, 10, 10);
			_AttrsOfRpt.AddTBString(GERptAttr.WFState, null, "状态", true, false,
					0, 10, 10);

			// Attr attr = new Attr();
			// attr.Desc = "流程状态";
			// attr.Key = "WFState";
			// attr.MyFieldType = FieldType.Enum;
			// attr.UIBindKey = "WFState";
			// attr.UITag = "@0=进行中@1=已经完成";

			_AttrsOfRpt.AddDDLSysEnum(GERptAttr.WFState, 0, "流程状态", true, true,
					GERptAttr.WFState);
			_AttrsOfRpt.AddTBString(GERptAttr.FlowEmps, null, "参与人", true,
					false, 0, 10, 10);
			_AttrsOfRpt.AddTBString(GERptAttr.FlowEnder, null, "结束人", true,
					false, 0, 10, 10);
			_AttrsOfRpt.AddTBString(GERptAttr.FlowEnderRDT, null, "结束时间", true,
					false, 0, 10, 10);
			_AttrsOfRpt.AddTBDecimal(GERptAttr.FlowEndNode, new BigDecimal(0),
					"结束节点", true, false);
			_AttrsOfRpt.AddTBDecimal(GERptAttr.FlowDaySpan, new BigDecimal(0),
					"跨度(天)", true, false);
			// _AttrsOfRpt.AddTBString(GERptAttr.FK_NY, null, "隶属月份", true,
			// false, 0, 10, 10);
		}
		return _AttrsOfRpt;
	}

	// /#endregion 属性

	// /#region 其他配置.

	/**
	 * 帮助
	 * 
	 * @param id1
	 * @param id2
	 * @return
	 */
	public static String GenerHelpCCForm(String text, String id1, String id2) {
		if (id1 == null) {
			return "<div style='float:right' ><a href='http://ccform.mydoc.io' target=_blank><img src='/WF/Img/Help.gif'>"
					+ text + "</a></div>";
		} else {
			return "<div style='float:right' ><a href='" + id1
					+ "' target=_blank><img src='"+getCCFlowAppPath()+"WF/Img/Help.gif'>" + text
					+ "</a></div>";
		}
	}

	public static String GenerHelpCCFlow(String text, String id1, String id2) {
		return "<div style='float:right' ><a href='" + id1
				+ "' target=_blank><img src='/WF/Img/Help.gif'>" + text
				+ "</a></div>";
	}

	public static String getNodeImagePath() {
		return Glo.getIntallPath() + "/Data/Node/";
	}

	public static void ClearDBData() {
		String sql = "DELETE FROM WF_GenerWorkFlow WHERE fk_flow not in (select no from wf_flow )";
		BP.DA.DBAccess.RunSQL(sql);

		sql = "DELETE FROM WF_GenerWorkerlist WHERE fk_flow not in (select no from wf_flow )";
		BP.DA.DBAccess.RunSQL(sql);
	}

	public static String OEM_Flag = "CCS";

	public static String getFlowFileBill() {
		return Glo.getIntallPath() + "/DataUser/Bill/";
	}

	public static String getFlowFileTemp() {
		return Glo.getIntallPath() + "/Temp/";
	}

	private static String _IntallPath = null;

	public static String getIntallPath() {
		if (_IntallPath == null) {
			if (SystemConfig.getIsBSsystem() == true) {
				// _IntallPath =
				// System.Web.HttpContext.Current.Request.PhysicalApplicationPath;
				_IntallPath = ContextHolderUtils.getRequest().getSession()
						.getServletContext().getRealPath("/");
			}
		}

		if (_IntallPath == null) {
			throw new RuntimeException("@没有实现如何获得 cs 下的根目录.");
		}

		return _IntallPath;
	}

	public static void setIntallPath(String value) {
		_IntallPath = value;
	}

	private static String _ServerIP = null;

	public static String getServerIP() {
		if (_ServerIP == null) {
			// String ip = "127.0.0.1";
			// System.Net.IPAddress[] addressList =
			// System.Net.Dns.GetHostByName(System.Net.Dns.GetHostName()).AddressList;
			// if (addressList.length > 1)
			// {
			// _ServerIP = addressList[1].toString();
			// }
			// else
			// {
			// _ServerIP = addressList[0].toString();
			// }
			String ip = getHostURL();
		}
		return _ServerIP;
	}

	public static void setServerIP(String value) {
		_ServerIP = value;
	}

	/**
	 * 流程控制器按钮
	 */
	public static String getFlowCtrlBtnPos() {
		String s = (String) ((BP.Sys.SystemConfig.getAppSettings().get(
				"FlowCtrlBtnPos") instanceof String) ? BP.Sys.SystemConfig
				.getAppSettings().get("FlowCtrlBtnPos") : null);
		if (s == null || s.equals("Top")) {
			return "Top";
		}
		return "Bottom";
	}

	/**
	 * 全局的安全验证码
	 */
	public static String getGloSID() {
		String s = (String) ((BP.Sys.SystemConfig.getAppSettings()
				.get("GloSID") instanceof String) ? BP.Sys.SystemConfig
				.getAppSettings().get("GloSID") : null);
		if (s == null || s.equals("")) {
			s = "sdfq2erre-2342-234sdf23423-323";
		}
		return s;
	}

	/**
	 * 是否启用检查用户的状态? 如果启用了:在MyFlow.aspx中每次都会检查当前的用户状态是否被禁
	 * 用，如果禁用了就不能执行任何操作了。启用后，就意味着每次都要 访问数据库。
	 */
	public static boolean getIsEnableCheckUseSta() {
		String s = (String) ((BP.Sys.SystemConfig.getAppSettings().get(
				"IsEnableCheckUseSta") instanceof String) ? BP.Sys.SystemConfig
				.getAppSettings().get("IsEnableCheckUseSta") : null);
		if (s == null || s.equals("0")) {
			return false;
		}
		return true;
	}

	/**
	 * 是否启用显示节点名称
	 */
	public static boolean getIsEnableMyNodeName() {
		String s = (String) ((BP.Sys.SystemConfig.getAppSettings().get(
				"IsEnableMyNodeName") instanceof String) ? BP.Sys.SystemConfig
				.getAppSettings().get("IsEnableMyNodeName") : null);
		if (s == null || s.equals("0")) {
			return false;
		}
		return true;
	}

	/**
	 * 检查一下当前的用户是否仍旧有效使用？
	 * 
	 * @return
	 * @throws Exception
	 */
	public static boolean CheckIsEnableWFEmp() throws Exception {
		Paras ps = new Paras();
		ps.SQL = "SELECT UseSta FROM WF_Emp WHERE No="
				+ SystemConfig.getAppCenterDBVarStr() + "FK_Emp";
		ps.AddFK_Emp();
		String s = DBAccess.RunSQLReturnStringIsNull(ps, "1");
		if (s.equals("1") || s == null) {
			return true;
		}
		return false;
	}

	/**
	 * 语言
	 */
	public static String Language = "CH";

	public static boolean getIsQL() {
		String s = BP.Sys.SystemConfig.getAppSettings().get("IsQL").toString();
		if (s == null || s.equals("0")) {
			return false;
		}
		return true;
	}

	/**
	 * 是否启用共享任务池？
	 */
	public static boolean getIsEnableTaskPool() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsEnableTaskPool", false);
	}

	/**
	 * 是否显示标题
	 */
	public static boolean getIsShowTitle() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsShowTitle", false);
	}

	/**
	 * 是否为工作增加一个优先级
	 */
	public static boolean getIsEnablePRI() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsEnablePRI", false);
	}

	/**
	 * 用户信息显示格式
	 */
	public static UserInfoShowModel getUserInfoShowModel() {
		return UserInfoShowModel.forValue(BP.Sys.SystemConfig.GetValByKeyInt(
				"UserInfoShowModel", 0));
	}

	/**
	 * 产生用户数字签名
	 * 
	 * @return
	 */
	public static String GenerUserSigantureHtml(String userNo, String userName) {
		return "<img src='" + getCCFlowAppPath() + "DataUser/Siganture/"
				+ userNo + ".jpg' title='" + userName
				+ "' border=0 onerror=\"src='" + getCCFlowAppPath()
				+ "DataUser/UserIcon/DefaultSmaller.png'\" />";
	}

	/**
	 * 产生用户小图片
	 * 
	 * @return
	 */
	public static String GenerUserImgSmallerHtml(String userNo, String userName) {
		return "<img src='"
				+ getCCFlowAppPath()
				+ "DataUser/UserIcon/"
				+ userNo
				+ "Smaller.png' border=0 width='15px' height='15px' style='padding-right:5px;vertical-align:middle;'  onerror=\"src='"
				+ getCCFlowAppPath()
				+ "DataUser/UserIcon/DefaultSmaller.png'\" />" + userName;
	}

	/**
	 * 产生用户大图片
	 * 
	 * @return
	 */
	public static String GenerUserImgHtml(String userNo, String userName) {
		return "<img src='"
				+ getCCFlowAppPath()
				+ "DataUser/UserIcon/"
				+ userNo
				+ ".png'  style='padding-right:5px;width:60px;height:60px;border:0px;text-align:middle' onerror=\"src='"
				+ getCCFlowAppPath()
				+ "DataUser/UserIcon/Default.png'\" /><br>" + userName;
	}

	/**
	 * 更新主表的SQL
	 */
	public static String getUpdataMainDeptSQL() {
		return BP.Sys.SystemConfig.GetValByKey(
				"UpdataMainDeptSQL",
				"UPDATE Port_Emp SET FK_Dept="
						+ BP.Sys.SystemConfig.getAppCenterDBVarStr()
						+ "FK_Dept WHERE No="
						+ BP.Sys.SystemConfig.getAppCenterDBVarStr() + "No");
	}

	/**
	 * 更新SID的SQL
	 */
	public static String getUpdataSID() {
		return BP.Sys.SystemConfig.GetValByKey(
				"UpdataSID",
				"UPDATE Port_Emp SET SID="
						+ BP.Sys.SystemConfig.getAppCenterDBVarStr()
						+ "SID WHERE No="
						+ BP.Sys.SystemConfig.getAppCenterDBVarStr() + "No");
	}

	/**
	 * 下载sl的地址
	 */
	public static String getSilverlightDownloadUrl() {
		return BP.Sys.SystemConfig.GetValByKey("SilverlightDownloadUrl",
				"http://go.microsoft.com/fwlink/?LinkID=124807");
	}

	/**
	 * 处理显示格式
	 * 
	 * @param no
	 * @param name
	 * @return 现实格式
	 */
	public static String DealUserInfoShowModel(String no, String name) {
		switch (BP.WF.Glo.getUserInfoShowModel()) {
		case UserIDOnly:
			return "(" + no + ")";
		case UserIDUserName:
			return "(" + no + "," + name + ")";
		case UserNameOnly:
			return "(" + name + ")";
		default:
			throw new RuntimeException("@没有判断的格式类型.");
		}
	}

	/**
	 * 钉钉是否启用
	 */
	public static boolean getIsEnable_DingDing() {
		// 如果两个参数都不为空说明启用
		String corpid = BP.Sys.SystemConfig.GetValByKey("Ding_CorpID", "");
		String corpsecret = BP.Sys.SystemConfig.GetValByKey("Ding_CorpSecret",
				"");
		if (StringHelper.isNullOrEmpty(corpid)
				|| StringHelper
						.isNullOrEmpty(corpsecret)
				|| StringHelper
						.isNullOrWhiteSpace(corpid)
				|| StringHelper
						.isNullOrWhiteSpace(corpsecret)) {
			return false;
		}

		return true;
	}

	/**
	 * 运行模式
	 */
	public static OSModel getOSModel() {
		OSModel os = OSModel.forValue(BP.Sys.SystemConfig.GetValByKeyInt(
				"OSModel", 0));
		return os;
	}

	/**
	 * 是否是集团使用
	 */
	public static boolean getIsUnit() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsUnit", false);
	}

	/**
	 * 是否启用制度
	 */
	public static boolean getIsEnableZhiDu() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsEnableZhiDu", false);
	}

	/**
	 * 是否删除流程注册表数据？
	 */
	public static boolean getIsDeleteGenerWorkFlow() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsDeleteGenerWorkFlow",
				false);
	}

	/**
	 * 是否检查表单树字段填写是否为空
	 */
	public static boolean getIsEnableCheckFrmTreeIsNull() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen(
				"IsEnableCheckFrmTreeIsNull", true);
	}

	/**
	 * 是否启动工作时打开新窗口
	 */
	public static int getIsWinOpenStartWork() {
		return BP.Sys.SystemConfig.GetValByKeyInt("IsWinOpenStartWork", 1);
	}

	/**
	 * 是否打开待办工作时打开窗口
	 */
	public static boolean getIsWinOpenEmpWorks() {
		return BP.Sys.SystemConfig.GetValByKeyBoolen("IsWinOpenEmpWorks", true);
	}

	/**
	 * 是否启用消息系统消息。
	 */
	public static boolean getIsEnableSysMessage() {
		return BP.Sys.SystemConfig
				.GetValByKeyBoolen("IsEnableSysMessage", true);
	}

	/**
	 * 与ccflow流程服务相关的配置: 执行自动任务节点，间隔的时间，以分钟计算，默认为2分钟。
	 */
	public static int getAutoNodeDTSTimeSpanMinutes() {
		return BP.Sys.SystemConfig.GetValByKeyInt("AutoNodeDTSTimeSpanMinutes",
				2);
	}

	/**
	 * ccim集成的数据库. 是为了向ccim写入消息.
	 */
	public static String getCCIMDBName() {
		String baseUrl = BP.Sys.SystemConfig.getAppSettings().get("CCIMDBName")
				.toString();
		if (StringHelper.isNullOrEmpty(baseUrl) == true) {
			baseUrl = "ccPort.dbo";
		}
		return baseUrl;
	}

	/**
	 * 主机
	 */
	public static String getHostURL() {
		String baseUrl = BP.Sys.SystemConfig.getAppSettings().get("HostURL")
				.toString();
		if (StringHelper.isNullOrEmpty(baseUrl) == true) {
			baseUrl = BP.Sys.SystemConfig.getAppSettings().get("BaseURL")
					.toString();
		}

		if (StringHelper.isNullOrEmpty(baseUrl) == true) {
			baseUrl = "http://127.0.0.1/";
		}

		if (!baseUrl.substring(baseUrl.length() - 1).equals("/")) {
			baseUrl = baseUrl + "/";
		}
		return baseUrl;
	}

	public static String getCurrPageID() {
		try {
			String url = BP.Sys.Glo.getRequest().getRequestURI();

			int i = url.lastIndexOf("/") + 1;
			int i2 = url.indexOf(".jsp") - 6;
			try {
				url = url.substring(i);
				return url.substring(0, url.indexOf(".jsp"));

			} catch (RuntimeException ex) {
				throw new RuntimeException(ex.getMessage() + url + " i=" + i
						+ " i2=" + i2);
			}
		} catch (RuntimeException ex) {
			throw new RuntimeException("获取当前PageID错误:" + ex.getMessage());
		}
	}

	// 用户表单风格控制
	public static String getGetUserStyle() {
		// BP.WF.Port.WFEmp emp = new Port.WFEmp(WebUser.getNo());
		// if(string.IsNullOrEmpty(emp.Style) || emp.Style=="0")
		// {
		String userStyle = BP.Sys.SystemConfig.getAppSettings()
				.get("UserStyle").toString();
		if (StringHelper.isNullOrEmpty(userStyle)) {
			return "ccflow默认";
		} else {
			return userStyle;
		}
	}

	// /#endregion

	// /#region 时间计算.
	/**
	 * 设置成工作时间
	 * 
	 * @param DateTime
	 * @return
	 */
	public static java.util.Date SetToWorkTime(java.util.Date dt) {
		if (BP.Sys.GloVar.getHolidays().contains(DateUtils.format(dt, "MM-dd"))) {
			dt = DateUtils.addDay(dt, 1);
			/* 如果当前是节假日，就要从下一个有效期计算。 */
			while (true) {
				if (BP.Sys.GloVar.getHolidays().contains(
						DateUtils.format(dt, "MM-dd")) == false) {
					break;
				}
				dt = DateUtils.addDay(dt, 1);
			}

			// 从下一个上班时间计算.
			dt = DataType.ParseSysDate2DateTime(DateUtils.format(dt,
					"yyyy-MM-dd") + " " + Glo.getAMFrom());
			return dt;
		}

		int timeInt = Integer.parseInt(DateUtils.format(dt, "HHmm"));

		// 判断是否在A区间, 如果是，就返回A区间的时间点.
		if (Glo.getAMFromInt() >= timeInt) {
			return DataType.ParseSysDate2DateTime(DateUtils.format(dt,
					"yyyy-MM-dd") + " " + Glo.getAMFrom());
		}

		// 判断是否在E区间, 如果是就返回第2天的上班时间点.
		if (Glo.getPMToInt() <= timeInt) {
			return DataType.ParseSysDate2DateTime(DateUtils.format(dt,
					"yyyy-MM-dd") + " " + Glo.getPMTo());
		}

		// 如果在午休时间点中间.
		if (Glo.getAMToInt() <= timeInt && Glo.getPMFromInt() > timeInt) {
			return DataType.ParseSysDate2DateTime(DateUtils.format(dt,
					"yyyy-MM-dd") + " " + Glo.getPMFrom());
		}
		return dt;
	}

	/**
	 * 在指定的日期上增加小时数。 1，扣除午休。 2，扣除节假日。
	 * 
	 * @param dt
	 * @param hours
	 * @return
	 */
	private static java.util.Date AddMinutes(java.util.Date dt, int minutes) {
		// 如果没有设置,就返回.
		if (minutes == 0) {
			return dt;
		}

		// 设置成工作时间.
		dt = SetToWorkTime(dt);

		// 首先判断是否是在一天整的时间完成.
		if (minutes == Glo.getAMPMHours() * 60) {
			/* 如果需要在一天完成 */
			dt = DataType.AddDays(dt, 1);
			return dt;
		}

		// 判断是否是AM.
		boolean isAM = false;
		int timeInt = Integer.parseInt(DateUtils.format(dt, "HHmm"));
		if (Glo.getAMToInt() > timeInt) {
			isAM = true;
		}

		// /#region 如果是当天的情况.
		// 如果规定的时间在 1天之内.
		if (minutes / 60 / Glo.getAMPMHours() < 1) {
			if (isAM == true) {
				/* 如果是中午, 中午到中午休息之间的时间. */

				Date ts = new Date(DataType.ParseSysDateTime2DateTime(
						DateUtils.format(dt, "yyyy-MM-dd") + " "
								+ Glo.getAMTo()).getTime()
						- dt.getTime());
				if (ts.getMinutes() >= minutes) {
					/* 如果剩余的分钟大于 要增加的分钟数，就是说+上分钟后，仍然在中午，就直接增加上这个分钟，让其返回。 */
					return DateUtils.addMinutes(dt, minutes);
				} else {
					// 求出到下班时间的分钟数。
					Date myts = new Date(DataType.ParseSysDateTime2DateTime(
							DateUtils.format(dt, "yyyy-MM-dd") + " "
									+ Glo.getAMTo()).getTime()
							- dt.getTime());

					// 扣除午休的时间.
					int leftMuit = (int) (myts.getMinutes() - Glo
							.getAMPMTimeSpan() * 60);
					if (leftMuit - minutes >= 0) {
						/* 说明还是在当天的时间内. */
						java.util.Date mydt = DataType
								.ParseSysDateTime2DateTime(DateUtils.format(dt,
										"yyyy-MM-dd") + " " + Glo.getPMTo());
						return DateUtils.addMinutes(mydt, (minutes - leftMuit));
					}

					// 说明要跨到第2天上去了.
					dt = DataType.AddDays(dt, 1);
					// return Glo.AddMinutes(DateUtils.format(dt,"yyyy-MM-dd") +
					// " " + Glo.getAMFrom(), minutes - leftMuit);
				}

				// 把当前的时间加上去.
				dt = DateUtils.addMinutes(dt, minutes);

				// 判断是否是中午.
				boolean isInAM = false;
				timeInt = Integer.parseInt(DateUtils.format(dt, "HHmm"));
				if (Glo.getAMToInt() >= timeInt) {
					isInAM = true;
				}

				if (isInAM == true) {
					// 加上时间后仍然是中午就返回.
					return dt;
				}

				// 延迟一个午休时间.
				dt = DateUtils.addHours(dt, (int) Glo.getAMPMTimeSpan());

				// 判断时间点是否落入了E区间.
				timeInt = Integer.parseInt(DateUtils.format(dt, "HHmm"));
				if (Glo.getPMToInt() <= timeInt) {
					/* 如果落入了E区间. */

					// 求出来时间点到，下班之间的分钟数.
					Date tsE = new Date(dt.getTime()
							- DataType.ParseSysDate2DateTime(
									DateUtils.format(dt, "yyyy-MM-dd") + " "
											+ Glo.getPMTo()).getTime());

					// 从次日的上班时间计算+ 这个时间差.
					dt = DataType.ParseSysDate2DateTime(DateUtils.format(dt,
							"yyyy-MM-dd") + " " + Glo.getPMTo());
					return DateUtils.addMinutes(dt, tsE.getMinutes());
				} else {
					/* 过了第2天的情况很少，就不考虑了. */
					return dt;
				}
			} else {
				/* 如果是下午, 计算出来到下午下班还需多少分钟，与增加的分钟数据相比较. */
				Date ts = new Date(DataType.ParseSysDateTime2DateTime(
						DateUtils.format(dt, "yyyy-MM-dd") + " "
								+ Glo.getPMTo()).getTime()
						- dt.getTime());
				if (ts.getMinutes() >= minutes) {
					/* 如果剩余的分钟大于 要增加的分钟数，就直接增加上这个分钟，让其返回。 */
					return DateUtils.addMinutes(dt, minutes);
				} else {

					// 剩余的分钟数 = 总分钟数 - 今天下午剩余的分钟数.
					int leftMin = minutes - (int) ts.getMinutes();

					/* 否则要计算到第2天上去了， 计算时间要从下一个有效的工作日上班时间开始. */
					dt = DataType.AddDays(DataType
							.ParseSysDateTime2DateTime(DateUtils.format(dt,
									"yyyy-MM-dd") + " " + Glo.getAMFrom()), 1);

					// 递归调用,让其在次日的上班时间在增加，分钟数。
					return Glo.AddMinutes(dt, leftMin);
				}

			}
		}
		// /#endregion 如果是当天的情况.

		return dt;
	}

	/**
	 * 增加分钟数.
	 * 
	 * @param sysdt
	 * @param minutes
	 * @return
	 */
	public static java.util.Date AddMinutes(String sysdt, int minutes) {
		java.util.Date dt = DataType.ParseSysDate2DateTime(sysdt);
		return AddMinutes(dt, minutes);
	}

	/**
	 * 在指定的日期上增加n天n小时，并考虑节假日
	 * 
	 * @param sysdt
	 *            指定的日期
	 * @param day
	 *            天数
	 * @param minutes
	 *            分钟数
	 * @return 返回计算后的日期
	 * @throws ParseException
	 */
	public static java.util.Date AddDayHoursSpan(String specDT, int day,
			int minutes) {
		if (specDT == null) {
			return null;
		}
		java.util.Date mydt = DataType.AddDays(specDT, day);
		return Glo.AddMinutes(mydt, minutes);
	}

	/**
	 * 在指定的日期上增加n天n小时，并考虑节假日
	 * 
	 * @param sysdt
	 *            指定的日期
	 * @param day
	 *            天数
	 * @param minutes
	 *            分钟数
	 * @return 返回计算后的日期
	 */
	public static java.util.Date AddDayHoursSpan(java.util.Date specDT,
			int day, int minutes) {
		java.util.Date mydt = BP.DA.DataType.AddDays(specDT, day);
		return Glo.AddMinutes(mydt, minutes);
	}

	// /#endregion ssxxx.

	// /#region 与考核相关.
	/**
	 * 当流程发送下去以后，就开始执行考核。
	 * 
	 * @param fl
	 * @param nd
	 * @param workid
	 * @param fid
	 * @param title
	 */
	public static void InitCH(Flow fl, Node nd, long workid, long fid,
			String title) {
		InitCH(fl, nd, workid, fid, title, null, null, new java.util.Date());
	}

	/**
	 * 当流程发送下去以后，就开始执行考核。
	 * 
	 * @param fl
	 *            流程
	 * @param nd
	 *            节点
	 * @param workid
	 *            工作ID
	 * @param fid
	 *            FID
	 * @param title
	 *            标题
	 * @param dtNow
	 *            计算的当前时间，如果为null,就取当前日期.
	 */
	public static void InitCH(Flow fl, Node nd, long workid, long fid,
			String title, String prvRDT, String sdt, java.util.Date dtNow) {
		// 开始节点不考核.
		if (nd.getIsStartNode()) {
			return;
		}

		// 如果设置为0 则不考核.
		if (nd.getTSpanDay() == 0 && nd.getTSpanHour() == 0) {
			return;
		}

		if (dtNow == null) {
			dtNow = new java.util.Date();
		}

		if (sdt == null || prvRDT == null) {
			String dbstr = SystemConfig.getAppCenterDBVarStr();
			Paras ps = new Paras();
			switch (SystemConfig.getAppCenterDBType()) {
			case MSSQL:
				ps.SQL = "SELECT TOP 1 RDT,SDT FROM WF_GENERWORKERLIST  WHERE WorkID="
						+ dbstr
						+ "WorkID AND FK_Emp="
						+ dbstr
						+ "FK_Emp AND FK_Node="
						+ dbstr
						+ "FK_Node ORDER BY RDT DESC";
				break;
			case Oracle:
				ps.SQL = "SELECT  RDT,SDT FROM WF_GENERWORKERLIST  WHERE WorkID="
						+ dbstr
						+ "WorkID AND FK_Emp="
						+ dbstr
						+ "FK_Emp AND FK_Node="
						+ dbstr
						+ "FK_Node AND ROWNUM=1 ORDER BY RDT DESC ";
				break;
			case MySQL:
				ps.SQL = "SELECT  RDT,SDT FROM WF_GENERWORKERLIST  WHERE WorkID="
						+ dbstr
						+ "WorkID AND FK_Emp="
						+ dbstr
						+ "FK_Emp AND FK_Node="
						+ dbstr
						+ "FK_Node ORDER BY RDT DESC LIMIT 0,1";
				break;
			default:
				break;
			}
			ps.Add("WorkID", workid);
			ps.Add("FK_Emp", WebUser.getNo());
			ps.Add("FK_Node", nd.getNodeID());

			DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(ps);
			if (dt.Rows.size() == 0) {
				return;
			}

			prvRDT = dt.Rows.get(0).getValue(0).toString();
			sdt = dt.Rows.get(0).getValue(1).toString();
		}

		// /#region 初始化基础数据.
		BP.WF.Data.CH ch = new CH();
		ch.setWorkID(workid);
		ch.setFID(fid);
		ch.setTitle(title);

		int hh = (int) nd.getTSpanHour();
		float mm = (nd.getTSpanHour() - hh) * 60;
		ch.setTSpan(nd.getTSpanDay() + "天" + hh + "时" + mm + "分");
		ch.setFK_NY(DateUtils.format(new Date(), "yyyy-MM"));

		ch.setDTFrom(prvRDT); // 任务下达时间.
		ch.setSDT(sdt); // 应该完成时间.

		ch.setFK_Flow(nd.getFK_Flow());
		ch.setFK_FlowT(nd.getFlowName());

		ch.setFK_Node(nd.getNodeID());
		ch.setFK_NodeT(nd.getName());

		ch.setFK_Dept(WebUser.getFK_Dept());
		ch.setFK_DeptT(WebUser.getFK_DeptName());

		ch.setFK_Emp(WebUser.getNo());
		ch.setFK_EmpT(WebUser.getName());

		// 求出是第几个周.
		// ch.Week = (int)dtNow.w;
		// System.Globalization.CultureInfo myCI = new
		// System.Globalization.CultureInfo("zh-CN");
		// ch.setWeekNum(myCI.Calendar.GetWeekOfYear(dtNow,System.Globalization.CalendarWeekRule.FirstDay,java.time.DayOfWeek.MONDAY));

		// mypk.
		ch.setMyPK(nd.getNodeID() + "_" + workid + "_" + fid + "_"
				+ WebUser.getNo());
		// /#endregion 初始化基础数据.

		// 求出结算时间点 dtFrom.
		java.util.Date dtFrom = BP.DA.DataType.ParseSysDateTime2DateTime(ch
				.getDTFrom());
		dtFrom = Glo.SetToWorkTime(dtFrom);

		// 当前时间. -设置结算时间到.
		ch.setDTTo(DateUtils.format(new Date(), DataType.getSysDataTimeFormat())); // dtto..
		dtNow = Glo.SetToWorkTime(dtNow);

		int dtHHmm = 0;
		if (dtFrom.getYear() == dtNow.getYear()
				&& dtFrom.getMonth() == dtNow.getMonth()
				&& dtFrom.getDay() == dtFrom.getDay()) {
			// 计算发送时间是否是中午?
			dtHHmm = Integer.parseInt(DateUtils.format(dtFrom, "HHmm"));
			boolean isSendAM = false;
			if (dtHHmm >= Glo.getAMFromInt() && dtHHmm <= Glo.getAMToInt()) {
				/* 发送人发送时间是上午, 并且处理人处理时间也是上午. */
				isSendAM = true;
			}

			// 计算处理时间是否是中午？
			dtHHmm = Integer.parseInt(DateUtils.format(dtFrom, "HHmm"));
			boolean isCurrAM = false;
			if (dtHHmm >= Glo.getAMFromInt() && dtHHmm <= Glo.getAMToInt()) {
				/* 发送人发送时间是上午, 并且处理人处理时间也是上午. */
				isCurrAM = true;
			}

			/* 如果是同一天. 如果都是中午. */
			if (isSendAM && isCurrAM) {
				Date ts = new Date(dtNow.getTime() - dtFrom.getTime());
				ch.setUseMinutes(ch.getUseMinutes() + (int) ts.getMinutes()); // 得到实际用的时间.
			}

			/* 如果是同一天. 如果都是下午. */
			if (isSendAM == false && isCurrAM == false) {
				Date ts = new Date(dtNow.getTime() - dtFrom.getTime());

				// 两个时间差，并减去午休的时间.
				ch.setUseMinutes(ch.getUseMinutes() + (int) ts.getMinutes()); // 得到实际用的时间.
			}

			/* 如果是同一天. 如果一个是中午一个是下午. */
			if (isSendAM == true && isCurrAM == false) {
				float f60 = 60;
				Date ts = new Date(dtNow.getTime() - dtFrom.getTime());
				// ts.getMinutes()
				float hours = (float) ts.getHours() - Glo.getAMPMTimeSpan(); // 得到实际用的时间.

				// 实际使用时间.
				ch.setUseMinutes(ch.getUseMinutes() + (int) hours * 60);
			}

			// 求超过时限.
			ch.setOverMinutes(ch.getUseMinutes() - nd.getTSpanMinues());

			// 设置时限状态.
			if (ch.getOverMinutes() > 0) {
				/* 如果是正数，就说明它是一个超期完成的状态. */
				if (ch.getOverMinutes() / 2 > nd.getTSpanMinues()) {
					ch.setCHSta(CHSta.ChaoQi); // 如果超过了时间的一半，就是超期.
				} else {
					ch.setCHSta(CHSta.YuQi); // 在规定的时间段以内完成，就是预期。
				}
			} else {
				/* 是负数就是提前完成. */
				if (ch.getOverMinutes() / 2 > -nd.getTSpanMinues()) {
					ch.setCHSta(CHSta.JiShi); // 如果提前了一半的时间，就是及时完成.
				} else {
					ch.setCHSta(CHSta.AnQi); // 否则就是按期完成.
				}
			}

			// /#region 计算出来可以识别的分钟数.
			// 求使用天数.
			float day = ch.getUseMinutes() / 60f / Glo.getAMPMHours();
			int dayInt = (int) day;

			// 求小时数.
			float hour = (ch.getUseMinutes() - dayInt * Glo.getAMPMHours()
					* 60f) / 60f;
			int hourInt = (int) hour;

			// 求分钟数.
			float minute = (hour - hourInt) * 60;

			// 使用时间.
			ch.setUseTime(dayInt + "天" + hourInt + "时" + minute + "分");

			// 求预期天数.
			int overMinus = Math.abs(ch.getOverMinutes());
			day = overMinus / 60f / Glo.getAMPMHours();
			dayInt = (int) day;

			// 求小时数.
			hour = (overMinus - dayInt * Glo.getAMPMHours() * 60f) / 60f;
			hourInt = (int) hour;

			// 求分钟数.
			minute = (hour - hourInt) * 60;

			// 使用时间.
			if (ch.getOverMinutes() > 0) {
				ch.setOverTime("预期:" + dayInt + "天" + hourInt + "小时"
						+ (int) minute + "分");
			} else {
				ch.setOverTime("提前:" + dayInt + "天" + hourInt + "小时"
						+ (int) minute + "分");
			}

			// /#endregion 计算出来可以识别的分钟数.

			// 执行保存.

			ch.DirectInsert();

		}
	}

	/**
	 * 中午时间从
	 */
	public static String getAMFrom() {
		return BP.Sys.SystemConfig.GetValByKey("AMFrom", "08:30");
	}

	/**
	 * 中午时间从
	 */
	public static int getAMFromInt() {
		return Integer.parseInt(Glo.getAMFrom().replace(":", ""));
	}

	/**
	 * 一天有效的工作小时数 是中午工作小时+下午工作小时.
	 */
	public static float getAMPMHours() {
		return BP.Sys.SystemConfig.GetValByKeyFloat("AMPMHours", 8);
	}

	/**
	 * 中午间隔的小时数
	 */
	public static float getAMPMTimeSpan() {
		return BP.Sys.SystemConfig.GetValByKeyFloat("AMPMTimeSpan", 1);

	}

	/**
	 * 中午时间到
	 */
	public static String getAMTo() {
		return BP.Sys.SystemConfig.GetValByKey("AMTo", "11:30");
	}

	/**
	 * 中午时间到
	 */
	public static int getAMToInt() {
		return Integer.parseInt(Glo.getAMTo().replace(":", ""));
	}

	/**
	 * 下午时间从
	 */
	public static String getPMFrom() {
		return BP.Sys.SystemConfig.GetValByKey("PMFrom", "13:30");
	}

	/**
	 * 到
	 */
	public static int getPMFromInt() {
		return Integer.parseInt(Glo.getPMFrom().replace(":", ""));
	}

	/**
	 * 到
	 */
	public static String getPMTo() {
		return BP.Sys.SystemConfig.GetValByKey("PMTo", "17:30");
	}

	/**
	 * 到
	 */
	public static int getPMToInt() {
		return Integer.parseInt(Glo.getPMTo().replace(":", ""));
	}

	// /#endregion 与考核相关.

	// /#region 其他方法。
	/**
	 * 转到消息显示界面.
	 * 
	 * @param info
	 */
	public static void ToMsg(String info, HttpServletResponse response) {
		// string rowUrl = BP.Sys.Glo.Request.RawUrl;
		// if (rowUrl.contains("&IsClient=1"))
		// {
		// /*说明这是vsto调用的.*/
		// return;
		// }

		// System.Web.HttpContext.Current.Session.setValue("info", info);
		// System.Web.HttpContext.Current.Response.Redirect(Glo.getCCFlowAppPath()
		// + "WF/MyFlowInfo.jsp?Msg=" + DataType.getCurrentDataTime()ss, false);

		ContextHolderUtils.getSession().setAttribute("info", info);
		try {
			response.sendRedirect(Glo.getCCFlowAppPath()
					+ "WF/MyFlowInfo.jsp?Msg=" + info);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void ToMsgErr(String info) {
		// info = "<font color=red>" + info + "</font>";
		// System.Web.HttpContext.Current.Session.setValue("info", info);
		// System.Web.HttpContext.Current.Response.Redirect(Glo.getCCFlowAppPath()
		// + "WF/MyFlowInfo.jsp?Msg=" + DataType.getCurrentDataTime(), false);
		info = "<font color=red>" + info + "</font>";
		ContextHolderUtils.getSession().setAttribute("info", info);
		try {
			ContextHolderUtils.getResponse().sendRedirect(
					Glo.getCCFlowAppPath() + "WF/MyFlowInfo.jsp?Msg=" + info);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 检查流程发起限制
	 * 
	 * @param flow
	 *            流程
	 * @param wk
	 *            开始节点工作
	 * @return
	 */
	public static boolean CheckIsCanStartFlow_InitStartFlow(Flow flow) {
		StartLimitRole role = flow.getStartLimitRole();
		if (role == StartLimitRole.None) {
			return true;
		}

		String sql = "";
		String ptable = flow.getPTable();

		// /#region 按照时间的必须是，在表单加载后判断, 不管用户设置是否正确.
		java.util.Date dtNow = new java.util.Date();
		if (role == StartLimitRole.Day) {
			/* 仅允许一天发起一次 */
			sql = "SELECT COUNT(*) as Num FROM " + ptable + " WHERE RDT LIKE '"
					+ DataType.getCurrentData()
					+ "%' AND WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				if (flow.getStartLimitPara().equals("")) {
					return true;
				}

				// 判断时间是否在设置的发起范围内. 配置的格式为 @11:00-12:00@15:00-13:45
				String[] strs = flow.getStartLimitPara().split("[@]", -1);
				for (String str : strs) {
					if (StringHelper
							.isNullOrEmpty(str)) {
						continue;
					}
					String[] timeStrs = str.split("[-]", -1);
					String tFrom = DateUtils.format(new Date(), "yyyy-MM-dd")
							+ " " + timeStrs[0].trim();
					String tTo = DateUtils.format(new Date(), "yyyy-MM-dd")
							+ " " + timeStrs[1].trim();
					if (DataType.ParseSysDateTime2DateTime(tFrom).getTime() <= dtNow
							.getTime()
							&& dtNow.compareTo(DataType
									.ParseSysDateTime2DateTime(tTo)) >= 0) {
						return true;
					}
				}
				return false;
			} else {
				return false;
			}
		}

		if (role == StartLimitRole.Week) {
			/*
			 * 1, 找出周1 与周日分别是第几日. 2, 按照这个范围去查询,如果查询到结果，就说明已经启动了。
			 */
			sql = "SELECT COUNT(*) as Num FROM " + ptable + " WHERE RDT >= '"
					+ DataType.WeekOfMonday(dtNow)
					+ "' AND WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				if (flow.getStartLimitPara().equals("")) {
					return true; // 如果没有时间的限制.
				}

				// 判断时间是否在设置的发起范围内.
				// 配置的格式为 @Sunday,11:00-12:00@Monday,15:00-13:45,
				// 意思是.周日，周一的指定的时间点范围内可以启动流程.

				String[] strs = flow.getStartLimitPara().split("[@]", -1);
				for (String str : strs) {
					if (StringHelper
							.isNullOrEmpty(str)) {
						continue;
					}

					// String weekStr = new
					// java.util.Date().getDayOfWeek().toString().toLowerCase();
					String[] weekDays = { "Sunday", "Monday", "Tuesday",
							"Wednesday", "Thursday", "Friday", "Saturday" };
					Calendar cal = Calendar.getInstance();
					cal.setTime(new Date());
					int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
					if (w < 0)
						w = 0;
					String weekStr = weekDays[w].toLowerCase();
					if (str.toLowerCase().contains(weekStr) == false) {
						continue; // 判断是否当前的周.
					}

					String[] timeStrs = str.split("[,]", -1);
					String tFrom = DateUtils.format(new Date(), "yyyy-MM-dd")
							+ " " + timeStrs[0].trim();
					String tTo = DateUtils.format(new Date(), "yyyy-MM-dd")
							+ " " + timeStrs[1].trim();
					if (DataType.ParseSysDateTime2DateTime(tFrom).getTime() <= dtNow
							.getTime()
							&& dtNow.compareTo(DataType
									.ParseSysDateTime2DateTime(tTo)) >= 0) {
						return true;
					}
				}
				return false;
			} else {
				return false;
			}
		}

		// #warning 没有考虑到周的如何处理.

		if (role == StartLimitRole.Month) {
			sql = "SELECT COUNT(*) as Num FROM " + ptable + " WHERE FK_NY = '"
					+ DataType.getCurrentYearMonth()
					+ "' AND WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				if (flow.getStartLimitPara().equals("")) {
					return true;
				}

				// 判断时间是否在设置的发起范围内. 配置格式: @-01 12:00-13:11@-15 12:00-13:11 ,
				// 意思是：在每月的1号,15号 12:00-13:11可以启动流程.
				String[] strs = flow.getStartLimitPara().split("[@]", -1);
				for (String str : strs) {
					if (StringHelper
							.isNullOrEmpty(str)) {
						continue;
					}
					String[] timeStrs = str.split("[-]", -1);
					String tFrom = DateUtils.format(new Date(), "yyyy-MM-")
							+ " " + timeStrs[0].trim();
					String tTo = DateUtils.format(new Date(), "yyyy-MM-") + " "
							+ timeStrs[1].trim();
					if (DataType.ParseSysDateTime2DateTime(tFrom).getTime() <= dtNow
							.getTime()
							&& dtNow.compareTo(DataType
									.ParseSysDateTime2DateTime(tTo)) >= 0) {
						return true;
					}
				}
				return false;
			} else {
				return false;
			}
		}

		if (role == StartLimitRole.JD) {
			sql = "SELECT COUNT(*) as Num FROM " + ptable + " WHERE FK_NY = '"
					+ DataType.getCurrentAPOfJD()
					+ "' AND WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				if (flow.getStartLimitPara().equals("")) {
					return true;
				}

				// 判断时间是否在设置的发起范围内.
				String[] strs = flow.getStartLimitPara().split("[@]", -1);
				for (String str : strs) {
					if (StringHelper
							.isNullOrEmpty(str)) {
						continue;
					}
					String[] timeStrs = str.split("[-]", -1);
					String tFrom = DateUtils.format(new Date(), "yyyy-") + " "
							+ timeStrs[0].trim();
					String tTo = DateUtils.format(new Date(), "yyyy-") + " "
							+ timeStrs[1].trim();
					if (DataType.ParseSysDateTime2DateTime(tFrom).getTime() <= dtNow
							.getTime()
							&& dtNow.compareTo(DataType
									.ParseSysDateTime2DateTime(tTo)) >= 0) {
						return true;
					}
				}
				return false;
			} else {
				return false;
			}
		}

		if (role == StartLimitRole.Year) {
			sql = "SELECT COUNT(*) as Num FROM " + ptable
					+ " WHERE FK_NY LIKE '" + DataType.getCurrentYear()
					+ "%' AND WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				if (flow.getStartLimitPara().equals("")) {
					return true;
				}

				// 判断时间是否在设置的发起范围内.
				String[] strs = flow.getStartLimitPara().split("[@]", -1);
				for (String str : strs) {
					if (StringHelper
							.isNullOrEmpty(str)) {
						continue;
					}
					String[] timeStrs = str.split("[-]", -1);
					String tFrom = DateUtils.format(new Date(), "yyyy-") + " "
							+ timeStrs[0].trim();
					String tTo = DateUtils.format(new Date(), "yyyy-") + " "
							+ timeStrs[1].trim();
					if (DataType.ParseSysDateTime2DateTime(tFrom).getTime() <= dtNow
							.getTime()
							&& dtNow.compareTo(DataType
									.ParseSysDateTime2DateTime(tTo)) >= 0) {
						return true;
					}
				}
				return false;
			} else {
				return false;
			}
		}
		// /#endregion 按照时间的必须是，在表单加载后判断, 不管用户设置是否正确.

		return true;
	}

	/**
	 * 当要发送是检查流程是否可以允许发起.
	 * 
	 * @param flow
	 *            流程
	 * @param wk
	 *            开始节点工作
	 * @return
	 */
	public static boolean CheckIsCanStartFlow_SendStartFlow(Flow flow, Work wk) {
		StartLimitRole role = flow.getStartLimitRole();
		if (role == StartLimitRole.None) {
			return true;
		}

		String sql = "";
		String ptable = flow.getPTable();

		if (role == StartLimitRole.ColNotExit) {
			/* 指定的列名集合不存在，才可以发起流程。 */

			// 求出原来的值.
			String[] strs = flow.getStartLimitPara().split("[,]", -1);
			String val = "";
			for (String str : strs) {
				if (StringHelper.isNullOrEmpty(str) == true) {
					continue;
				}
				try {
					val += wk.GetValStringByKey(str);
				} catch (RuntimeException ex) {
					throw new RuntimeException("@流程设计错误,您配置的检查参数("
							+ flow.getStartLimitPara() + "),中的列(" + str
							+ ")已经不存在表单里.");
				}
			}

			// 找出已经发起的全部流程.
			sql = "SELECT " + flow.getStartLimitPara() + " FROM " + ptable
					+ " WHERE  WFState NOT IN(0,1) AND FlowStarter='"
					+ WebUser.getNo() + "'";
			DataTable dt = DBAccess.RunSQLReturnTable(sql);
			for (DataRow dr : dt.Rows) {
				String v = String.valueOf(dr.getValue(0))
						+ String.valueOf(dr.getValue(1)) + dr.getValue(2);
				if (val.equals(v)) {
					return false;
				}
			}
			return true;
		}

		// 配置的sql,执行后,返回结果是 0 .
		if (role == StartLimitRole.ResultIsZero) {
			sql = BP.WF.Glo.DealExp(flow.getStartLimitPara(), wk, null);
			if (DBAccess.RunSQLReturnValInt(sql, 0) == 0) {
				return true;
			} else {
				return false;
			}
		}

		// 配置的sql,执行后,返回结果是 <> 0 .
		if (role == StartLimitRole.ResultIsNotZero) {
			sql = BP.WF.Glo.DealExp(flow.getStartLimitPara(), wk, null);
			if (DBAccess.RunSQLReturnValInt(sql, 0) != 0) {
				return true;
			} else {
				return false;
			}
		}
		return true;
	}
	// /#endregion 其他方法。
	/**
	 * 产生消息,senderEmpNo是为了保证写入消息的唯一性，receiveid才是真正的接收者.
	 * @param fromEmpNo 发送人
	 * @param sendToEmpNo 接受人
	 * @param msg 消息内容
	 * @param now 发送时间
	 */
	public static void SendMessageToCCIM(String fromEmpNo, String sendToEmpNo, String msg, String now)
	{
		if (fromEmpNo == null)
		{
			fromEmpNo = "";
		}

		if (sendToEmpNo == null || sendToEmpNo.equals(""))
		{
			return;
		}

		// throw new Exception("@接受人不能为空");

		String dbStr = SystemConfig.getAppCenterDBVarStr();
		//保存系统通知消息
		StringBuilder strHql1 = new StringBuilder();
		//加密处理
		msg = SecurityDES.encrypt(msg);

		Paras ps = new Paras();
		String sql = "INSERT INTO CCIM_RecordMsg (OID,SendID,MsgDateTime,MsgContent,ImageInfo,FontName,FontSize,FontBold,FontColor,InfoClass,GroupID,SendUserID) VALUES (";
		sql += dbStr + "OID,";
		sql += "'SYSTEM',";
		sql += dbStr + "MsgDateTime,";
		sql += dbStr + "MsgContent,";
		sql += dbStr + "ImageInfo,";
		sql += dbStr + "FontName,";
		sql += dbStr + "FontSize,";
		sql += dbStr + "FontBold,";
		sql += dbStr + "FontColor,";
		sql += dbStr + "InfoClass,";
		sql += dbStr + "GroupID,";
		sql += dbStr + "SendUserID)";
		ps.SQL = sql;

		long messgeID = BP.DA.DBAccess.GenerOID("RecordMsgUser");

		ps.Add("OID", messgeID);
		ps.Add("MsgDateTime", now);
		ps.Add("MsgContent", msg);
		ps.Add("ImageInfo", "");
		ps.Add("FontName", "宋体");
		ps.Add("FontSize", 10);
		ps.Add("FontBold", 0);
		ps.Add("FontColor", -16777216);
		ps.Add("InfoClass", 15);
		ps.Add("GroupID", -1);
		ps.Add("SendUserID", fromEmpNo);
		BP.DA.DBAccess.RunSQL(ps);

		//保存消息发送对象,这个是消息的接收人表.
		ps = new Paras();
		ps.SQL = "INSERT INTO CCIM_RecordMsgUser (OID,MsgId,ReceiveID) VALUES ( ";
		ps.SQL += dbStr + "OID,";
		ps.SQL += dbStr + "MsgId,";
		ps.SQL += dbStr + "ReceiveID)";

		ps.Add("OID", messgeID);
		ps.Add("MsgId", messgeID);
		ps.Add("ReceiveID", sendToEmpNo);
		BP.DA.DBAccess.RunSQL(ps);
	}
	
	/** 
	 * 短消息写入类型
	 */
	public static ShortMessageWriteTo getShortMessageWriteTo()
	{
		return  ShortMessageWriteTo.forValue(SystemConfig.GetValByKeyInt("ShortMessageWriteTo", 0));
	}
}