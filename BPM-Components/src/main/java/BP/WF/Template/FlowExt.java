package BP.WF.Template;

import java.io.IOException;
import java.util.Date;
import java.util.Random;

import BP.DA.DBAccess;
import BP.DA.DataRow;
import BP.DA.DataTable;
import BP.DA.DataType;
import BP.DA.Paras;
import BP.En.EntityNoName;
import BP.En.Map;
import BP.En.RefMethod;
import BP.En.RefMethodType;
import BP.En.UAC;
import BP.Port.Dept;
import BP.Port.Emp;
import BP.Sys.OSModel;
import BP.Sys.PubClass;
import BP.Sys.SystemConfig;
import BP.Sys.Frm.MapData;
import BP.Tools.DateUtils;
import BP.Tools.StringHelper;
import BP.WF.ActionType;
import BP.WF.Flow;
import BP.WF.FlowAppType;
import BP.WF.FlowRunWay;
import BP.WF.GenerWorkFlow;
import BP.WF.GenerWorkFlowAttr;
import BP.WF.GenerWorkFlows;
import BP.WF.GenerWorkerList;
import BP.WF.GenerWorkerListAttr;
import BP.WF.Glo;
import BP.WF.Node;
import BP.WF.Nodes;
import BP.WF.ReturnWork;
import BP.WF.TrackAttr;
import BP.WF.WFState;
import BP.WF.Work;
import BP.WF.WorkAttr;
import BP.WF.WorkNode;
import BP.WF.Works;
import BP.WF.Data.GERpt;
import BP.Web.WebUser;
import cn.jflow.common.util.ContextHolderUtils;

/**
 * 流程
 */
public class FlowExt extends EntityNoName {
	
	///#region 属性.
	/** 
	 * 系统类别（第2级流程树节点编号）
	 */
	public final String getSysType()
	{
		return this.GetValStringByKey(FlowAttr.SysType);
	}
	public final void setSysType(String value)
	{
		this.SetValByKey(FlowAttr.SysType, value);
	}
	
	/**
	 * 流程事件实体
	 */
	public final String getFlowEventEntity() {
		return this.GetValStringByKey(FlowAttr.FlowEventEntity);
	}

	public final void setFlowEventEntity(String value) {
		this.SetValByKey(FlowAttr.FlowEventEntity, value);
	}

	/**
	 * 流程标记
	 */
	public final String getFlowMark() {
		String str = this.GetValStringByKey(FlowAttr.FlowMark);
		if (str.equals("")) {
			return this.getNo();
		}
		return str;
	}

	public final void setFlowMark(String value) {
		this.SetValByKey(FlowAttr.FlowMark, value);
	}

	///#region   前置导航
	/**
	 * 前置导航方式
	 */
	public final StartGuideWay getStartGuideWay() {
		return StartGuideWay.forValue(this.GetValIntByKey(FlowAttr.StartGuideWay));

	}

	public final void setStartGuideWay(StartGuideWay value) {
		this.SetValByKey(FlowAttr.StartGuideWay, value.getValue());
	}

	/**
	 * 前置导航参数1
	 */
	public final String getStartGuidePara1() {
		return this.GetValStringByKey(FlowAttr.StartGuidePara1);
	}

	public final void setStartGuidePara1(String value) {
		this.SetValByKey(FlowAttr.StartGuidePara1, value);
	}

	/**
	 * 前置导航参数2
	 */
	public final String getStartGuidePara2() {
		return this.GetValStringByKey(FlowAttr.StartGuidePara2);
	}

	public final void setStartGuidePara2(String value) {
		this.SetValByKey(FlowAttr.StartGuidePara2, value);
	}

	/**
	 * 前置导航参数3
	 */
	public final String getStartGuidePara3() {
		return this.GetValStringByKey(FlowAttr.StartGuidePara3);
	}

	public final void setStartGuidePara3(String value) {
		this.SetValByKey(FlowAttr.StartGuidePara3, value);
	}

	/**
	 * 启动方式
	 */
	public final FlowRunWay getFlowRunWay() {
		return FlowRunWay.forValue(this.GetValIntByKey(FlowAttr.FlowRunWay));

	}

	public final void setFlowRunWay(FlowRunWay value) {
		this.SetValByKey(FlowAttr.FlowRunWay, value.getValue());
	}

	/**
	 * 运行内容
	 */
	public final String getRunObj() {
		return this.GetValStringByKey(FlowAttr.RunObj);
	}

	public final void setRunObj(String value) {
		this.SetValByKey(FlowAttr.RunObj, value);
	}

	/**
	 * 是否启用开始节点数据重置按钮
	 */
	public final boolean getIsResetData() {
		return this.GetValBooleanByKey(FlowAttr.IsResetData);
	}

	public final void setIsResetData(boolean value) {
		this.SetValByKey(FlowAttr.IsResetData, value);
	}

	/**
	 * 是否自动装载上一笔数据
	 */
	public final boolean getIsLoadPriData() {
		return this.GetValBooleanByKey(FlowAttr.IsLoadPriData);
	}

	public final void setIsLoadPriData(boolean value) {
		this.SetValByKey(FlowAttr.IsLoadPriData, value);
	}

	///#endregion
	/**
	 * 设计者编号
	 */
	public final String getDesignerNo() {
		return this.GetValStringByKey(FlowAttr.DesignerNo);
	}

	public final void setDesignerNo(String value) {
		this.SetValByKey(FlowAttr.DesignerNo, value);
	}

	/**
	 * 设计者名称
	 */
	public final String getDesignerName() {
		return this.GetValStringByKey(FlowAttr.DesignerName);
	}

	public final void setDesignerName(String value) {
		this.SetValByKey(FlowAttr.DesignerName, value);
	}

	/**
	 * 编号生成格式
	 */
	public final String getBillNoFormat() {
		return this.GetValStringByKey(FlowAttr.BillNoFormat);
	}

	public final void setBillNoFormat(String value) {
		this.SetValByKey(FlowAttr.BillNoFormat, value);
	}

	///#endregion 属性.

	///#region 构造方法
	/**
	 * UI界面上的访问控制
	 */
	@Override
	public UAC getHisUAC() {
		UAC uac = new UAC();
		if (("admin").equals(BP.Web.WebUser.getNo()) || this.getDesignerNo().equals(WebUser.getNo())) {
			uac.IsUpdate = true;
		}
		return uac;
	}

	/**
	 * 流程
	 */
	public FlowExt() {}

	/**
	 * 流程
	 * @param _No 编号
	 */
	public FlowExt(String _No) {
		this.setNo(_No);
		if (SystemConfig.getIsDebug()) {
			int i = this.RetrieveFromDBSources();
			if (i == 0) {
				throw new RuntimeException("流程编号不存在");
			}
		} else {
			this.Retrieve();
		}
	}

	/**
	 * 重写基类方法
	 */
	@Override
	public Map getEnMap() {
		if (this.get_enMap() != null) {
			return this.get_enMap();
		}

		Map map = new Map("WF_Flow", "流程");

		///#region 基本属性。
		map.AddTBStringPK(FlowAttr.No, null, "编号", true, true, 1, 10, 3);
		map.SetHelperUrl(FlowAttr.No, "http://ccbpm.mydoc.io/?v=5404&t=17023"); //使用alert的方式显示帮助信息.

		map.AddDDLEntities(FlowAttr.FK_FlowSort, "01", "流程类别", new FlowSorts(), true);
		map.SetHelperUrl(FlowAttr.FK_FlowSort, "http://ccbpm.mydoc.io/?v=5404&t=17024");
		map.AddTBString(FlowAttr.Name, null, "名称", true, false, 0, 50, 10, true);

		// add 2013-02-14 唯一确定此流程的标记
		map.AddTBString(FlowAttr.FlowMark, null, "流程标记", true, false, 0, 150, 10);
		map.AddTBString(FlowAttr.FlowEventEntity, null, "流程事件实体", true, true, 0, 150, 10);
		map.SetHelperUrl(FlowAttr.FlowMark, "http://ccbpm.mydoc.io/?v=5404&t=16847");
		map.SetHelperUrl(FlowAttr.FlowEventEntity, "http://ccbpm.mydoc.io/?v=5404&t=17026");

		// add 2013-02-05.
		map.AddTBString(FlowAttr.TitleRole, null, "标题生成规则", true, false, 0, 150, 10, true);
		map.SetHelperUrl(FlowAttr.TitleRole, "http://ccbpm.mydoc.io/?v=5404&t=17040");

		//add  2013-08-30.
		map.AddTBString(FlowAttr.BillNoFormat, null, "单据编号格式", true, false, 0, 50, 10, false);
		map.SetHelperUrl(FlowAttr.BillNoFormat, "http://ccbpm.mydoc.io/?v=5404&t=17041");

		// add 2014-10-19.
		map.AddDDLSysEnum(FlowAttr.ChartType, FlowChartType.Icon.getValue(), "节点图形类型", true, true, "ChartType", "@0=几何图形@1=肖像图片");

		map.AddBoolean(FlowAttr.IsCanStart, true, "可以独立启动否？(独立启动的流程可以显示在发起流程列表里)", true, true, true);
		map.SetHelperUrl(FlowAttr.IsCanStart, "http://ccbpm.mydoc.io/?v=5404&t=17027");

		map.AddBoolean(FlowAttr.IsMD5, false, "是否是数据加密流程(MD5数据加密防篡改)", true, true, true);
		map.SetHelperUrl(FlowAttr.IsMD5, "http://ccbpm.mydoc.io/?v=5404&t=17028");

		map.AddBoolean(FlowAttr.IsFullSA, false, "是否自动计算未来的处理人？", true, true, true);
		map.SetHelperUrl(FlowAttr.IsFullSA, "http://ccbpm.mydoc.io/?v=5404&t=17034");

		map.AddBoolean(FlowAttr.IsAutoSendSubFlowOver, false, "(为子流程时)在流程结束时，是否检查所有子流程完成后，让父流程自动发送到下一步。", true, true, true);
		//map.SetHelperBaidu(FlowAttr.IsAutoSendSubFlowOver, "ccflow 是否检查所有子流程完成后父流程自动发送到下一步");
		map.AddBoolean(FlowAttr.IsGuestFlow, false, "是否外部用户参与流程(非组织结构人员参与的流程)", true, true, false);
		map.SetHelperUrl(FlowAttr.IsGuestFlow, "http://ccbpm.mydoc.io/?v=5404&t=17039");

		//批量发起 add 2013-12-27. 
		map.AddBoolean(FlowAttr.IsBatchStart, false, "是否可以批量发起流程？(如果是就要设置发起的需要填写的字段,多个用逗号分开)", true, true, true);
		map.AddTBString(FlowAttr.BatchStartFields, null, "发起字段", true, false, 0, 500, 10, true);
		map.SetHelperUrl(FlowAttr.IsBatchStart, "http://ccbpm.mydoc.io/?v=5404&t=17047");
		map.AddDDLSysEnum(FlowAttr.FlowAppType, FlowAppType.Normal.getValue(), "流程应用类型", true, true, "FlowAppType",
				"@0=业务流程@1=工程类(项目组流程)@2=公文流程(VSTO)");
		map.SetHelperUrl(FlowAttr.FlowAppType, "http://ccbpm.mydoc.io/?v=5404&t=17035");
		map.AddDDLSysEnum(FlowAttr.TimelineRole, TimelineRole.ByNodeSet.getValue(), "时效性规则", true, true, FlowAttr.TimelineRole,
				"@0=按节点(由节点属性来定义)@1=按发起人(开始节点SysSDTOfFlow字段计算)");
		map.SetHelperUrl(FlowAttr.TimelineRole, "http://ccbpm.mydoc.io/?v=5404&t=17036");
		// 草稿
		map.AddDDLSysEnum(FlowAttr.Draft, DraftRole.None.getValue(), "草稿规则", true, true, FlowAttr.Draft, "@0=无(不设草稿)@1=保存到待办@2=保存到草稿箱");
		map.SetHelperUrl(FlowAttr.Draft, "http://ccbpm.mydoc.io/?v=5404&t=17037");

		// 数据存储.
		map.AddDDLSysEnum(FlowAttr.DataStoreModel, DataStoreModel.ByCCFlow.getValue(), "流程数据存储模式", true, true, FlowAttr.DataStoreModel,
				"@0=数据轨迹模式@1=数据合并模式");
		map.SetHelperUrl(FlowAttr.DataStoreModel, "http://ccbpm.mydoc.io/?v=5404&t=17038");

		//add 2013-05-22.
		map.AddTBString(FlowAttr.HistoryFields, null, "历史查看字段", true, false, 0, 500, 10, true);
		//map.SetHelperBaidu(FlowAttr.HistoryFields, "ccflow 历史查看字段");
		map.AddTBString(FlowAttr.FlowNoteExp, null, "备注的表达式", true, false, 0, 500, 10, true);
		map.SetHelperUrl(FlowAttr.FlowNoteExp, "http://ccbpm.mydoc.io/?v=5404&t=17043");
		map.AddTBString(FlowAttr.Note, null, "流程描述", true, false, 0, 100, 10, true);
		map.AddTBString(FlowAttr.PTable, null, "流程数据存储表", true, false, 0, 30, 10);
		//fieldset
		//map.AddDDLSysEnum(FlowAttr.FlowAppType, FlowAppType.Normal.getValue(), "流程应用类型", true, true, "FlowAppType",
			//	"@0=业务流程@1=工程类(项目组流程)@2=公文流程(VSTO)");

		map.AddTBString(FlowAttr.HelpUrl, null, "帮助文档", true, false, 0, 300, 10, true);

		//移动到这里 by zhoupeng 2016.04.08.
		map.AddBoolean(FlowAttr.IsResetData, false, "是否启用开始节点数据重置按钮？", true, true, true);
		map.AddBoolean(FlowAttr.IsLoadPriData, false, "是否自动装载上一笔数据？", true, true, true);
		
		//为 莲荷科技增加一个系统类型, 用于存储当前所在流程树的第2级流程树编号.
		map.AddTBString(FlowAttr.SysType, null, "系统类型", false, false, 0, 100, 10, false);
		///#endregion 基本属性。

		///#region 启动方式
		//map.AddDDLSysEnum(FlowAttr.FlowRunWay, (int)FlowRunWay.HandWork, "启动方式",
		//    true, true, FlowAttr.FlowRunWay, "@0=手工启动@1=指定人员定时启动@2=定时访问数据集自动启动@3=触发式启动");

		//map.SetHelperUrl(FlowAttr.FlowRunWay, "http://ccbpm.mydoc.io/?v=5404&t=17088");
		//// map.AddTBString(FlowAttr.RunObj, null, "运行内容", true, false, 0, 100, 10, true);
		//map.AddTBStringDoc(FlowAttr.RunObj, null, "运行内容", true, false, true);
		///#endregion 启动方式

		///#region 流程启动限制
		//string role = "@0=不限制";
		//role += "@1=每人每天一次";
		//role += "@2=每人每周一次";
		//role += "@3=每人每月一次";
		//role += "@4=每人每季一次";
		//role += "@5=每人每年一次";
		//role += "@6=发起的列不能重复,(多个列可以用逗号分开)";
		//role += "@7=设置的SQL数据源为空,或者返回结果为零时可以启动.";
		//role += "@8=设置的SQL数据源为空,或者返回结果为零时不可以启动.";
		//map.AddDDLSysEnum(FlowAttr.StartLimitRole, (int)StartLimitRole.None, "启动限制规则", true, true, FlowAttr.StartLimitRole, role, true);
		//map.AddTBString(FlowAttr.StartLimitPara, null, "规则参数", true, false, 0, 500, 10, true);
		//map.AddTBStringDoc(FlowAttr.StartLimitAlert, null, "限制提示", true, false, true);
		//map.SetHelperUrl(FlowAttr.StartLimitRole, "http://ccbpm.mydoc.io/?v=5404&t=17872");

		//   map.AddTBString(FlowAttr.StartLimitAlert, null, "限制提示", true, false, 0, 500, 10, true);
		//    map.AddDDLSysEnum(FlowAttr.StartLimitWhen, (int)StartLimitWhen.StartFlow, "提示时间", true, true, FlowAttr.StartLimitWhen, "@0=启动流程时@1=发送前提示", false);
		///#endregion 流程启动限制

		///#region 发起前导航。
		//map.AddDDLSysEnum(FlowAttr.DataStoreModel, (int)DataStoreModel.ByCCFlow,
		//    "流程数据存储模式", true, true, FlowAttr.DataStoreModel,
		//   "@0=数据轨迹模式@1=数据合并模式");

		//发起前设置规则.
		//map.AddDDLSysEnum(FlowAttr.StartGuideWay, 0, "前置导航方式", true, true,
		//    FlowAttr.StartGuideWay,
		//    "@0=无@1=按系统的URL-(父子流程)单条模式@2=按系统的URL-(子父流程)多条模式@3=按系统的URL-(实体记录,未完成)单条模式@4=按系统的URL-(实体记录,未完成)多条模式@5=从开始节点Copy数据@10=按自定义的Url@11=按用户输入参数", true);
		//map.SetHelperUrl(FlowAttr.StartGuideWay, "http://ccbpm.mydoc.io/?v=5404&t=17883");

		//map.AddTBStringDoc(FlowAttr.StartGuidePara1, null, "参数1", true, false, true);
		//map.AddTBStringDoc(FlowAttr.StartGuidePara2, null, "参数2", true, false, true);
		//map.AddTBStringDoc(FlowAttr.StartGuidePara3, null, "参数3", true, false, true);

		//map.AddBoolean(FlowAttr.IsResetData, false, "是否启用开始节点数据重置按钮？", true, true, true);
		////     map.AddBoolean(FlowAttr.IsImpHistory, false, "是否启用导入历史数据按钮？", true, true, true);
		//map.AddBoolean(FlowAttr.IsLoadPriData, false, "是否自动装载上一笔数据？", true, true, true);
		///#endregion 发起前导航。

		///#region 延续流程。
		////延续流程.
		//map.AddDDLSysEnum(FlowAttr.CFlowWay, (int)CFlowWay.None, "延续流程", true, true,
		//    FlowAttr.CFlowWay, "@0=无:非延续类流程@1=按照参数@2=按照字段配置");
		//map.AddTBStringDoc(FlowAttr.CFlowPara, null, "延续流程参数", true, false, true);
		//map.SetHelperUrl(FlowAttr.CFlowWay, "http://ccbpm.mydoc.io/?v=5404&t=17891");

		//// add 2013-03-24.
		//map.AddTBString(FlowAttr.DesignerNo, null, "设计者编号", false, false, 0, 32, 10);
		//map.AddTBString(FlowAttr.DesignerName, null, "设计者名称", false, false, 0, 100, 10);
		///#endregion 延续流程。

		///#region 数据同步方案
		////数据同步方式.
		//map.AddDDLSysEnum(FlowAttr.DTSWay, (int)FlowDTSWay.None, "同步方式", true, true,
		//    FlowAttr.DTSWay, "@0=不同步@1=同步");
		//map.SetHelperUrl(FlowAttr.DTSWay, "http://ccbpm.mydoc.io/?v=5404&t=17893");

		//map.AddDDLEntities(FlowAttr.DTSDBSrc, "", "数据库", new BP.Sys.SFDBSrcs(), true);

		//map.AddTBString(FlowAttr.DTSBTable, null, "业务表名", true, false, 0, 50, 50, false);

		//map.AddTBString(FlowAttr.DTSBTablePK, null, "业务表主键", true, false, 0, 50, 50, false);
		//map.SetHelperAlert(FlowAttr.DTSBTablePK, "如果同步方式设置了按照业务表主键字段计算,那么需要在流程的节点表单里设置一个同名同类型的字段，系统将会按照这个主键进行数据同步。");

		//map.AddTBString(FlowAttr.DTSFields, null, "要同步的字段s,中间用逗号分开.", false, false, 0, 200, 100, false);

		//map.AddDDLSysEnum(FlowAttr.DTSTime, (int)FlowDTSTime.AllNodeSend, "执行同步时间点", true, true,
		//   FlowAttr.DTSTime, "@0=所有的节点发送后@1=指定的节点发送后@2=当流程结束时");
		//map.SetHelperUrl(FlowAttr.DTSTime, "http://ccbpm.mydoc.io/?v=5404&t=17894");

		//map.AddTBString(FlowAttr.DTSSpecNodes, null, "指定的节点ID", true, false, 0, 50, 50, false);
		//map.SetHelperAlert(FlowAttr.DTSSpecNodes, "如果执行同步时间点选择了按指定的节点发送后,多个节点用逗号分开.比如: 101,102,103");

		//map.AddDDLSysEnum(FlowAttr.DTSField, (int)DTSField.SameNames, "要同步的字段计算方式", true, true,
		// FlowAttr.DTSField, "@0=字段名相同@1=按设置的字段匹配");
		//map.SetHelperUrl(FlowAttr.DTSField, "http://ccbpm.mydoc.io/?v=5404&t=17895");

		//map.AddTBString(FlowAttr.getPTable(), null, "流程数据存储表", true, false, 0, 30, 10);
		//map.SetHelperUrl(FlowAttr.getPTable(), "http://ccbpm.mydoc.io/?v=5404&t=17897");
		///#endregion 数据同步方案

		///#region 权限控制.
		//map.AddBoolean(FlowAttr.PStarter, true, "发起人可看(必选)", true, false,true);
		//map.AddBoolean(FlowAttr.PWorker, true, "参与人可看(必选)", true, false, true);
		//map.AddBoolean(FlowAttr.PCCer, true, "被抄送人可看(必选)", true, false, true);

		//map.AddBoolean(FlowAttr.PMyDept, true, "本部门人可看", true, true, true);
		//map.AddBoolean(FlowAttr.PPMyDept, true, "直属上级部门可看(比如:我是)", true, true, true);

		//map.AddBoolean(FlowAttr.PPDept, true, "上级部门可看", true, true, true);
		//map.AddBoolean(FlowAttr.PSameDept, true, "平级部门可看", true, true, true);

		//map.AddBoolean(FlowAttr.PSpecDept, true, "指定部门可看", true, true, false);
		//map.AddTBString(FlowAttr.PSpecDept + "Ext", null, "部门编号", true, false, 0, 200, 100, false);

		//map.AddBoolean(FlowAttr.PSpecSta, true, "指定的岗位可看", true, true, false);
		//map.AddTBString(FlowAttr.PSpecSta + "Ext", null, "岗位编号", true, false, 0, 200, 100, false);

		//map.AddBoolean(FlowAttr.PSpecGroup, true, "指定的权限组可看", true, true, false);
		//map.AddTBString(FlowAttr.PSpecGroup + "Ext", null, "权限组", true, false, 0, 200, 100, false);

		//map.AddBoolean(FlowAttr.PSpecEmp, true, "指定的人员可看", true, true, false);
		//map.AddTBString(FlowAttr.PSpecEmp + "Ext", null, "指定的人员编号", true, false, 0, 200, 100, false);
		///#endregion 权限控制.

		//查询条件.
		map.AddSearchAttr(FlowAttr.FK_FlowSort);
		map.AddSearchAttr(FlowAttr.TimelineRole);

		///#region 基本功能.
		//map.AddRefMethod(rm);
		RefMethod rm = new RefMethod();
		rm = new RefMethod();
		rm.Title = "调试运行"; // "设计检查报告";
		//rm.ToolTip = "检查流程设计的问题。";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/EntityFunc/Flow/Run.png";
		rm.ClassMethodName = this.toString() + ".DoRunIt";
		rm.refMethodType = RefMethodType.LinkeWinOpen;
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "检查报告"; // "设计检查报告";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/EntityFunc/Flow/CheckRpt.png";
		rm.ClassMethodName = this.toString() + ".DoCheck";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "设计报表"; // "报表运行";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/Rpt.gif";
		rm.ClassMethodName = this.toString() + ".DoOpenRpt()";
		rm.refMethodType = RefMethodType.LinkeWinOpen;
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "自动发起";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/AutoStart.png";
		rm.ClassMethodName = this.toString() + ".DoSetStartFlowDataSources()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "发起限制规则";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Limit.png";
		rm.ClassMethodName = this.toString() + ".DoLimit()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "发起前置导航";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/StartGuide.png";
		rm.ClassMethodName = this.toString() + ".DoStartGuide()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = "批量修改节点属性";
		//rm.Icon = Glo.CCFlowAppPath + "WF/Img/Btn/DTS.gif";
		//rm.ClassMethodName = this.ToString() + ".DoFeatureSetUI()";
		//rm.refMethodType = RefMethodType.RightFrameOpen;
		//map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "流程事件&消息"; // "调用事件接口";
		rm.ClassMethodName = this.toString() + ".DoAction";
		rm.Icon = BP.WF.Glo.getCCFlowAppPath() + "WF/Img/Event.png";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = "与业务表数据同步"; // "抄送规则";
		//rm.ClassMethodName = this.ToString() + ".DoBTable";
		//rm.Icon = Glo.CCFlowAppPath + "WF/Admin/CCBPMDesigner/Img/DTS.png";
		//rm.RefAttrLinkLabel = "业务表字段同步配置";
		//rm.refMethodType = RefMethodType.LinkeWinOpen;
		//rm.Target = "_blank";
		//map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = "独立表单树";
		//rm.Icon = Glo.CCFlowAppPath + "WF/Img/Btn/DTS.gif";
		//rm.ClassMethodName = this.ToString() + ".DoFlowFormTree()";
		//map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "数据源管理(如果新增数据源后需要关闭重新打开)"; // "抄送规则";
		rm.ClassMethodName = this.toString() + ".DoDBSrc";
		rm.Icon = BP.WF.Glo.getCCFlowAppPath() + "WF/Img/Btn/DTS.gif";
		//设置相关字段.
		rm.RefAttrKey = FlowAttr.DTSDBSrc;
		rm.RefAttrLinkLabel = "数据源管理";
		rm.refMethodType = RefMethodType.LinkeWinOpen;
		rm.Target = "_blank";
		map.AddRefMethod(rm);
		///#endregion 流程设置.

		///#region 开发接口.
		/*rm = new RefMethod();
		rm.Title = "字段视图";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Field.png";
		rm.ClassMethodName = this.toString() + ".DoFlowFields()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "开发接口";
		map.AddRefMethod(rm);*/

		rm = new RefMethod();
		rm.Title = "与业务表数据同步";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/DTS.png";

		rm.ClassMethodName = this.toString() + ".DoDTSBTable()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "开发接口";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "URL调用接口";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/URL.png";
		rm.ClassMethodName = this.toString() + ".DoAPI()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "开发接口";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "SKD开发接口";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/API.png";
		rm.ClassMethodName = this.toString() + ".DoAPICode()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "开发接口";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "代码事件开发接口";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/API.png";
		rm.ClassMethodName = this.toString() + ".DoAPICodeFEE()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "开发接口";
		map.AddRefMethod(rm);
		///#endregion 开发接口.

		///#region 报表设计.
		rm = new RefMethod();
		rm.Title = "报表设计";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/DesignRpt.png";
		rm.ClassMethodName = this.toString() + ".DoDRpt()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "流程查询";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Search.png";
		rm.ClassMethodName = this.toString() + ".DoDRptSearch()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "自定义查询";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/SQL.png";
		rm.ClassMethodName = this.toString() + ".DoDRptSearchAdv()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "分组分析";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Group.png";
		rm.ClassMethodName = this.toString() + ".DoDRptGroup()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "交叉报表";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/D3.png";
		rm.ClassMethodName = this.toString() + ".DoDRptD3()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "对比分析";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Contrast.png";
		rm.ClassMethodName = this.toString() + ".DoDRptContrast()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "报表设计";
		map.AddRefMethod(rm);
		///#endregion 报表设计.

		///#region 流程运行维护.
		rm = new RefMethod();
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/DTS.gif";
		rm.Title = "重生成报表数据"; // "删除数据";
		rm.Warning = "您确定要执行吗? 注意:此方法耗费资源。"; // "您确定要执行删除流程数据吗？";
		rm.ClassMethodName = this.toString() + ".DoReloadRptData";
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "重生成流程标题";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/DTS.gif";
		rm.ClassMethodName = this.toString() + ".DoGenerTitle()";
		//设置相关字段.
		//rm.RefAttrKey = FlowAttr.TitleRole;
		rm.RefAttrLinkLabel = "重新生成流程标题";
		rm.refMethodType = RefMethodType.Func;
		rm.Target = "_blank";
		rm.Warning = "您确定要根据新的规则重新产生标题吗？";
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "重生成FlowEmps字段";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/DTS.gif";
		rm.ClassMethodName = this.toString() + ".DoGenerFlowEmps()";
		rm.RefAttrLinkLabel = "补充修复emps字段，包括wf_generworkflow,NDxxxRpt字段.";
		rm.refMethodType = RefMethodType.Func;
		rm.Target = "_blank";
		rm.Warning = "您确定要重新生成吗？";
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);

		//带有参数的方法.
		rm = new RefMethod();
		rm.GroupName = "流程维护";
		rm.Title = "重命名节点表单字段";
		//  rm.Warning = "您确定要处理吗？";
		rm.getHisAttrs().AddTBString("FieldOld", null, "旧字段英文名", true, false, 0, 100, 100);
		rm.getHisAttrs().AddTBString("FieldNew", null, "新字段英文名", true, false, 0, 100, 100);
		rm.getHisAttrs().AddTBString("FieldNewName", null, "新字段中文名", true, false, 0, 100, 100);
		rm.getHisAttrs().AddBoolen("thisFlowOnly", true, "仅仅当前流程");

		rm.ClassMethodName = this.toString() + ".DoChangeFieldName()";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "节点表单字段视图";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Field.png";
		rm.ClassMethodName = this.toString() + ".DoFlowFields()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/Delete.gif";
		rm.Title = "删除全部流程数据"; // this.ToE("DelFlowData", "删除数据"); // "删除数据";
		rm.Warning = "您确定要执行删除流程数据吗? \t\n该流程的数据删除后，就不能恢复，请注意删除的内容。"; // "您确定要执行删除流程数据吗？";
		rm.ClassMethodName = this.toString() + ".DoDelData()";
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/Delete.gif";
		rm.Title = "按工作ID删除"; // this.ToE("DelFlowData", "删除数据"); // "删除数据";
		rm.GroupName = "流程维护";
		rm.ClassMethodName = this.toString() + ".DoDelDataOne()";
		rm.getHisAttrs().AddTBInt("WorkID", 0, "输入工作ID", true, false);
		rm.getHisAttrs().AddTBString("beizhu", null, "删除备注", true, false, 0, 100, 100);
		map.AddRefMethod(rm);
		
		 //带有参数的方法.
        rm = new RefMethod();
        rm.GroupName = "流程维护";
        rm.Title = "删除指定日期范围内的流程";
        rm.Warning = "您确定要删除吗？";
        rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/Delete.gif";
        rm.getHisAttrs().AddTBDateTime("DTFrom", null, "时间从", true, false);
        rm.getHisAttrs().AddTBDateTime("DTTo", null, "时间到", true, false);
        rm.getHisAttrs().AddBoolen("thisFlowOnly", true, "仅仅当前流程");
        rm.ClassMethodName = this.toString() + ".DoDelFlows";
        map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "回滚流程";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/Back.png";
		rm.ClassMethodName = this.toString() + ".DoRebackFlowData()";
		// rm.Warning = "您确定要回滚它吗？";
		rm.getHisAttrs().AddTBInt("workid", 0, "请输入要会滚WorkID", true, false);
		rm.getHisAttrs().AddTBInt("nodeid", 0, "回滚到的节点ID", true, false);
		rm.getHisAttrs().AddTBString("note", null, "回滚原因", true, false, 0, 600, 200);
		rm.GroupName = "流程维护";
		map.AddRefMethod(rm);
		///#endregion 流程运行维护.

		///#region 流程监控.

		rm = new RefMethod();
		rm.Title = "监控面板";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Monitor.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_Welcome()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "流程查询";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Search.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "节点列表";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/flows.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_Nodes()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "综合查询";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Search.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_Search()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "综合分析";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Group.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_Group()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "实例增长分析";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Grow.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_InstanceGrowOneFlow()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "逾期未完成实例";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Warning.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_InstanceWarning()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "逾期已完成实例";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/overtime.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_InstanceOverTimeOneFlow()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "删除日志";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/log.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_DeleteLog()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "数据订阅";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/RptOrder.png";
		rm.ClassMethodName = this.toString() + ".DoDataManger_RptOrder()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程监控";
		map.AddRefMethod(rm);
		///#endregion 流程监控.

		//rm = new RefMethod();
		//rm.Title = "执行流程数据表与业务表数据手工同步"; 
		//rm.ClassMethodName = this.ToString() + ".DoBTableDTS";
		//rm.Icon = BP.WF.Glo.CCFlowAppPath + "WF/Img/Btn/DTS.gif";
		//rm.Warning = "您确定要执行吗？如果执行了可能会对业务表数据造成错误。";
		////设置相关字段.
		//rm.RefAttrKey = FlowAttr.DTSSpecNodes;
		//rm.RefAttrLinkLabel = "业务表字段同步配置";
		//rm.refMethodType = RefMethodType.Func;
		//rm.Target = "_blank";
		////  map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = "设置自动发起"; // "报表运行";
		//rm.Icon = "/WF/Img/Btn/View.gif";
		//rm.ClassMethodName = this.ToString() + ".DoOpenRpt()";
		////rm.Icon = "/WF/Img/Btn/Table.gif"; 
		//map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = this.ToE("Event", "事件"); // "报表运行";
		//rm.Icon = "/WF/Img/Btn/View.gif";
		//rm.ClassMethodName = this.ToString() + ".DoOpenRpt()";
		////rm.Icon = "/WF/Img/Btn/Table.gif";
		//map.AddRefMethod(rm);

		//rm = new RefMethod();
		//rm.Title = this.ToE("FlowExtDataOut", "数据转出定义");  //"数据转出定义";
		////  rm.Icon = "/WF/Img/Btn/Table.gif";
		//rm.ToolTip = "在流程完成时间，流程数据转储存到其它系统中应用。";
		//rm.ClassMethodName = this.ToString() + ".DoExp";
		//map.AddRefMethod(rm);

		///#region 流程模版管理.
		rm = new RefMethod();
		rm.Title = "模版导入";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/redo.png";
		rm.ClassMethodName = this.toString() + ".DoImp()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程模版";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "模版导出";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/undo.png";
		rm.ClassMethodName = this.toString() + ".DoExps()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "流程模版";
		map.AddRefMethod(rm);
		///#endregion 流程模版管理.

		rm = new RefMethod();
		rm.Title = "流程轨迹表单";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Btn/DTS.gif";
		rm.ClassMethodName = this.toString() + ".DoBindFlowExt()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "实验中的功能";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "批量设置节点";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Admin/CCBPMDesigner/Img/Node.png";
		rm.ClassMethodName = this.toString() + ".DoNodeAttrs()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "实验中的功能";
		map.AddRefMethod(rm);

		rm = new RefMethod();
		rm.Title = "轨迹查看权限";
		rm.Icon = Glo.getCCFlowAppPath() + "WF/Img/Setting.png";
		rm.ClassMethodName = this.toString() + ".DoTruckRight()";
		rm.refMethodType = RefMethodType.RightFrameOpen;
		rm.GroupName = "实验中的功能";
		map.AddRefMethod(rm);

		this.set_enMap(map);
		return this.get_enMap();
	}

	///#endregion
	/**
	 * 批量重命名字段.
	 * @param FieldOld
	 * @param FieldNew
	 * @param FieldNewName
	 * @return
	 */
	public final String DoChangeFieldName(String fieldOld, String fieldNew, String FieldNewName, String thisFlowOnly) {

		if (thisFlowOnly.equals("1")) {
			return DoChangeFieldNameOne(this, fieldOld, fieldNew, FieldNewName);
		}

		FlowExts fls = new FlowExts();
		fls.RetrieveAll();

		String resu = "";
		for (FlowExt item : fls.ToJavaList()) {
			resu += "   ====   " + DoChangeFieldNameOne(item, fieldOld, fieldNew, FieldNewName);

		}
		return resu;
	}

	public final String DoChangeFieldNameOne(FlowExt flow, String fieldOld, String fieldNew, String FieldNewName) {
		String result = "开始执行对字段:" + fieldOld + " ，进行重命名。";
		result += "<br> ===============================================================   ";
		Nodes nds = new Nodes(flow.getNo());
		for (Node nd : nds.ToJavaList()) {
			result += " @ 执行节点:" + nd.getName() + " 结果如下. <br>";
			result += "<br> ------------------------------------------------------------------------ ";
			MapDataExt md = new MapDataExt("ND" + nd.getNodeID());
			result += "\t\n @" + md.DoChangeFieldName(fieldOld, fieldNew, FieldNewName);
		}

		result += "@ 执行Rpt结果如下. <br>";
		MapDataExt rptMD = new MapDataExt("ND" + Integer.parseInt(flow.getNo()) + "Rpt");
		result += "\t\n@ " + rptMD.DoChangeFieldName(fieldOld, fieldNew, FieldNewName);

		result += "@ 执行MyRpt结果如下. <br>";
		rptMD = new MapDataExt("ND" + Integer.parseInt(flow.getNo()) + "MyRpt");

		if (rptMD.Retrieve() > 0) {
			result += "\t\n@ " + rptMD.DoChangeFieldName(fieldOld, fieldNew, FieldNewName);
		}

		return result;
	}

	///#region 流程监控.
	public final String DoDataManger_Welcome() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/CCBPMDesigner/App/OneFlow/Welcome.jsp?FK_Flow=" + this.getNo();
	}

	public final String DoDataManger_Nodes() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/CCBPMDesigner/App/OneFlow/Nodes.jsp?FK_Flow=" + this.getNo();
	}

	public final String DoDataManger_Search() {
		return SystemConfig.getCCFlowWebPath() + "WF/Comm/Search.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&FK_Flow=" + this.getNo() + "&WFSta=all";
	}

	public final String DoDataManger_Group() {
		return SystemConfig.getCCFlowWebPath() + "WF/Comm/Group.jsp?EnsName=BP.WF.Data.GenerWorkFlowViews&FK_Flow=" + this.getNo() + "&WFSta=all";
	}

	public final String DoDataManger_InstanceGrowOneFlow() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/FlowDB/InstanceGrowOneFlow.jsp?anaTime=mouth&FK_Flow=" + this.getNo();
	}

	public final String DoDataManger_InstanceWarning() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/FlowDB/InstanceWarning.jsp?anaTime=mouth&FK_Flow=" + this.getNo();
	}

	public final String DoDataManger_InstanceOverTimeOneFlow() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/FlowDB/InstanceOverTimeOneFlow.jsp?anaTime=mouth&FK_Flow=" + this.getNo();
	}

	public final String DoDataManger_DeleteLog() {
		return SystemConfig.getCCFlowWebPath() + "WF/Comm/Search.jsp?EnsName=BP.WF.WorkFlowDeleteLogs&FK_Flow=" + this.getNo() + "&WFSta=all";
	}

	/**
	 * 数据订阅
	 * @return
	 */
	public final String DoDataManger_RptOrder() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/CCBPMDesigner/App/RptOrder.jsp?anaTime=mouth&FK_Flow=" + this.getNo();
	}

	///#endregion 流程监控.

	///#region 报表设计.
	public final String DoDRpt() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/OneFlow.jsp?FK_Flow=" + this.getNo() + "&FK_MapData=ND" + Integer.parseInt(this.getNo())
				+ "MyRpt";
	}

	public final String DoDRptSearch() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/Search.jsp?FK_Flow=" + this.getNo() + "&RptNo=ND" + Integer.parseInt(this.getNo()) + "MyRpt";
	}

	public final String DoDRptSearchAdv() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/SearchAdv.jsp?FK_Flow=" + this.getNo() + "&RptNo=ND" + Integer.parseInt(this.getNo())
				+ "MyRpt";
	}

	public final String DoDRptGroup() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/Group.jsp?FK_Flow=" + this.getNo() + "&RptNo=ND" + Integer.parseInt(this.getNo()) + "MyRpt";
	}

	public final String DoDRptD3() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/D3.jsp?FK_Flow=" + this.getNo() + "&RptNo=ND" + Integer.parseInt(this.getNo()) + "MyRpt";
	}

	public final String DoDRptContrast() {
		return SystemConfig.getCCFlowWebPath() + "WF/Rpt/Contrast.jsp?FK_Flow=" + this.getNo() + "&RptNo=ND" + Integer.parseInt(this.getNo())
				+ "MyRpt";
	}

	///#endregion 报表设计.

	///#region 开发接口.
	/**
	 * 字段视图
	 * @return
	 */
	public final String DoFlowFields() {
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/FlowFields.jsp?FK_Flow=" + this.getNo();
	}

	/**
	 * 与业务表数据同步
	 * @return
	 */
	public final String DoDTSBTable() {
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/DTSBTable.jsp?FK_Flow=" + this.getNo();
	}

	public final String DoAPI() {
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/API.jsp?FK_Flow=" + this.getNo();
	}

	public final String DoAPICode() {
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/APICode.jsp?FK_Flow=" + this.getNo();
	}

	public final String DoAPICodeFEE() {
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/APICodeFEE.jsp?FK_Flow=" + this.getNo();
	}

	///#endregion 开发接口

	///#region  基本功能
	/**
	 * 事件
	 * @return
	 */
	public final String DoAction() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/Action.jsp?NodeID=0&FK_Flow=" + this.getNo() + "&tk=" + (new Random()).nextDouble();
	}

	public final String DoDBSrc() {
		return SystemConfig.getCCFlowWebPath() + "WF/Comm/Search.jsp?EnsName=BP.Sys.SFDBSrcs";
	}

	public final String DoBTable() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/DTSBTable.jsp?s=d34&ShowType=FlowFrms&FK_Node=" + Integer.parseInt(this.getNo())
				+ "01&FK_Flow=" + this.getNo() + "&ExtType=StartFlow&RefNo=" + DataType.getCurrentDataTime();
	}

	/**
	 * 批量修改节点属性.
	 * @return
	 */
	public final String DoFeatureSetUI() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/FeatureSetUI.jsp?s=d34&ShowType=FlowFrms&FK_Node=" + Integer.parseInt(this.getNo())
				+ "01&FK_Flow=" + this.getNo() + "&ExtType=StartFlow&RefNo=" + DataType.getCurrentDataTime();
	}

	/**
	 * 批量修改节点属性
	 * @return
	 */
	public final String DoNodeAttrs() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/NodeAttrs.jsp?NodeID=0&FK_Flow=" + this.getNo() + "&tk="
				+ (new Random()).nextDouble();
	}

	public final String DoBindFlowExt() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/BindFrms.jsp?s=d34&ShowType=FlowFrms&FK_Node=0&FK_Flow=" + this.getNo()
				+ "&ExtType=StartFlow";
	}

	/**
	 * 轨迹查看权限
	 * @return
	 */
	public final String DoTruckRight() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/TruckViewPower.jsp?FK_Flow=" + this.getNo();
	}

	/**
	 * 批量发起字段
	 * @return
	 */
	public final String DoBatchStartFields() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/BatchStartFields.jsp?s=d34&FK_Flow=" + this.getNo() + "&ExtType=StartFlow";
	}

	/**
	 * 执行流程数据表与业务表数据手工同步
	 * @return
	 * @throws Exception
	 */
	public final String DoBTableDTS() throws Exception {
		Flow fl = new Flow(this.getNo());
		return fl.DoBTableDTS();

	}

	/**
	 * 恢复已完成的流程数据到指定的节点，如果节点为0就恢复到最后一个完成的节点上去.
	 * @param workid 要恢复的workid
	 * @param backToNodeID 恢复到的节点编号，如果是0，标示回复到流程最后一个节点上去.
	 * @param note
	 * @return
	 */
	public final String DoRebackFlowData(long workid, int backToNodeID, String note) {
		if (note.length() <= 2) {
			return "请填写恢复已完成的流程原因.";
		}

		Flow fl = new Flow(this.getNo());
		GERpt rpt = new GERpt("ND" + Integer.parseInt(this.getNo()) + "Rpt");
		rpt.setOID(workid);
		int i = rpt.RetrieveFromDBSources();
		if (i == 0) {
			throw new RuntimeException("@错误，流程数据丢失。");
		}
		if (backToNodeID == 0) {
			backToNodeID = rpt.getFlowEndNode();
		}

		Emp empStarter = new Emp(rpt.getFlowStarter());

		// 最后一个节点.
		Node endN = new Node(backToNodeID);
		GenerWorkFlow gwf = null;
		boolean isHaveGener = false;
		try {
			///#region 创建流程引擎主表数据.
			gwf = new GenerWorkFlow();
			gwf.setWorkID(workid);
			if (gwf.RetrieveFromDBSources() == 1) {
				isHaveGener = true;
				//判断状态
				if (gwf.getWFState() != WFState.Complete) {
					throw new RuntimeException("@当前工作ID为:" + workid + "的流程没有结束,不能采用此方法恢复。");
				}
			}

			gwf.setFK_Flow(this.getNo());
			gwf.setFlowName(this.getName());
			gwf.setWorkID(workid);
			gwf.setPWorkID(rpt.getPWorkID());
			gwf.setPFlowNo(rpt.getPFlowNo());
			gwf.setPNodeID(rpt.getPNodeID());
			gwf.setPEmp(rpt.getPEmp());

			gwf.setFK_Node(backToNodeID);
			gwf.setNodeName(endN.getName());

			gwf.setStarter(rpt.getFlowStarter());
			gwf.setStarterName(empStarter.getName());
			gwf.setFK_FlowSort(fl.getFK_FlowSort());
			gwf.setSysType(fl.getSysType());
			gwf.setTitle(rpt.getTitle());
			gwf.setWFState(WFState.ReturnSta); //设置为退回的状态
			gwf.setFK_Dept(rpt.getFK_Dept());

			Dept dept = new Dept(empStarter.getFK_Dept());

			gwf.setDeptName(dept.getName());
			gwf.setPRI(1);

			Date date = DateUtils.addDay(new Date(), 3);
			String dttime = DateUtils.format(date, DateUtils.YMDHMS_PATTERN);

			gwf.setSDTOfNode(dttime);
			gwf.setSDTOfFlow(dttime);
			if (isHaveGener) {
				gwf.Update();
			} else {
				gwf.Insert(); //插入流程引擎数据.
			}

			///#endregion 创建流程引擎主表数据
			String ndTrack = "ND" + Integer.parseInt(this.getNo()) + "Track";
			String actionType = ActionType.Forward.getValue() + "," + ActionType.FlowOver.getValue() + "," + ActionType.ForwardFL.getValue() + ","
					+ ActionType.ForwardHL.getValue();
			String sql = "SELECT  * FROM " + ndTrack + " WHERE   ActionType IN (" + actionType + ")  and WorkID=" + workid
					+ " ORDER BY RDT DESC, NDFrom ";
			DataTable dt = DBAccess.RunSQLReturnTable(sql);
			if (dt.Rows.size() == 0) {
				throw new RuntimeException("@工作ID为:" + workid + "的数据不存在.");
			}

//			String starter = "";
//			boolean isMeetSpecNode = false;
			GenerWorkerList currWl = new GenerWorkerList();
			for (DataRow dr : dt.Rows) {
				int ndFrom = Integer.parseInt(dr.getValue("NDFrom").toString());
				Node nd = new Node(ndFrom);

				String ndFromT = dr.getValue("NDFromT").toString();
				String EmpFrom = dr.getValue(TrackAttr.EmpFrom).toString();
				String EmpFromT = dr.getValue(TrackAttr.EmpFromT).toString();

				// 增加上 工作人员的信息.
				GenerWorkerList gwl = new GenerWorkerList();
				gwl.setWorkID(workid);
				gwl.setFK_Flow(this.getNo());

				gwl.setFK_Node(ndFrom);
				gwl.setFK_NodeText(ndFromT);

				if (gwl.getFK_Node() == backToNodeID) {
					gwl.setIsPass(false);
					currWl = gwl;
				}

				gwl.setFK_Emp(EmpFrom);
				gwl.setFK_EmpText(EmpFromT);
				if (gwl.getIsExits()) {
					continue; //有可能是反复退回的情况.
				}

				Emp emp = new Emp(gwl.getFK_Emp());
				gwl.setFK_Dept(emp.getFK_Dept());

				gwl.setRDT(dr.getValue("RDT").toString());
				gwl.setSDT(dr.getValue("RDT").toString());
				gwl.setDTOfWarning(gwf.getSDTOfNode());
				gwl.setWarningHour(nd.getWarningHour());
				gwl.setIsEnable(true);
				gwl.setWhoExeIt(nd.getWhoExeIt());
				gwl.Insert();
			}

			///#region 加入退回信息, 让接受人能够看到退回原因.
			ReturnWork rw = new ReturnWork();
			rw.setWorkID(workid);
			rw.setReturnNode(backToNodeID);
			rw.setReturnNodeName(endN.getName());
			rw.setReturner(WebUser.getNo());
			rw.setReturnerName(WebUser.getName());

			rw.setReturnToNode(currWl.getFK_Node());
			rw.setReturnToEmp(currWl.getFK_Emp());
			rw.setNote(note);
			rw.setRDT(DataType.getCurrentDataTime());
			rw.setIsBackTracking(false);
			rw.setMyPK(BP.DA.DBAccess.GenerGUID());
			///#endregion   加入退回信息, 让接受人能够看到退回原因.

			//更新流程表的状态.
			rpt.setFlowEnder(currWl.getFK_Emp());
			rpt.setWFState(WFState.ReturnSta); //设置为退回的状态
			rpt.setFlowEndNode(currWl.getFK_Node());
			rpt.Update();

			// 向接受人发送一条消息.
			BP.WF.Dev2Interface.Port_SendMsg(currWl.getFK_Emp(), "工作恢复:" + gwf.getTitle(), "工作被:" + WebUser.getNo() + " 恢复." + note, "ReBack"
					+ workid, BP.WF.SMSMsgType.ToDo, this.getNo(), Integer.parseInt(this.getNo() + "01"), workid, 0);

			//写入该日志.
			WorkNode wn = new WorkNode(workid, currWl.getFK_Node());
			wn.AddToTrack(ActionType.RebackOverFlow, currWl.getFK_Emp(), currWl.getFK_EmpText(), currWl.getFK_Node(), currWl.getFK_NodeText(), note);

			return "@已经还原成功,现在的流程已经复原到(" + currWl.getFK_NodeText() + "). @当前工作处理人为(" + currWl.getFK_Emp() + " , " + currWl.getFK_EmpText()
					+ ")  @请通知他处理工作.";
		} catch (RuntimeException ex) {
			//此表的记录删除已取消
			//gwf.Delete();
			GenerWorkerList wl = new GenerWorkerList();
			wl.Delete(GenerWorkerListAttr.WorkID, workid);

			String sqls = "";
			sqls += "@UPDATE " + fl.getPTable() + " SET WFState=" + WFState.Complete.getValue() + " WHERE OID=" + workid;
			DBAccess.RunSQLs(sqls);
			return "<font color=red>会滚期间出现错误</font><hr>" + ex.getMessage();
		}
	}

	/**
	 * 重新产生标题，根据新的规则.
	 */
	public final String DoGenerFlowEmps() {
		if (!WebUser.getNo().equals("admin")) {
			return "非admin用户不能执行。";
		}

		Flow fl = new Flow(this.getNo());

		GenerWorkFlows gwfs = new GenerWorkFlows();
		gwfs.Retrieve(GenerWorkFlowAttr.FK_Flow, this.getNo());

		for (GenerWorkFlow gwf : gwfs.ToJavaList()) {
			String emps = "";
			String sql = "SELECT EmpFrom FROM ND" + Integer.parseInt(this.getNo()) + "Track  WHERE WorkID=" + gwf.getWorkID();

			DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(sql);
			for (DataRow dr : dt.Rows) {
				if (emps.contains("," + dr.getValue(0).toString() + ",")) {
					continue;
				}
			}

			sql = "UPDATE " + fl.getPTable() + " SET FlowEmps='" + emps + "' WHERE OID=" + gwf.getWorkID();
			DBAccess.RunSQL(sql);

			sql = "UPDATE WF_GenerWorkFlow SET Emps='" + emps + "' WHERE WorkID=" + gwf.getWorkID();
			DBAccess.RunSQL(sql);
		}

		Node nd = fl.getHisStartNode();
		Works wks = nd.getHisWorks();
		wks.RetrieveAllFromDBSource(WorkAttr.Rec);
		String table = nd.getHisWork().getEnMap().getPhysicsTable();
		String tableRpt = "ND" + Integer.parseInt(this.getNo()) + "Rpt";
		MapData md = new MapData(tableRpt);
		for (Work wk : wks.ToJavaList()) {
			if (!wk.getRec().equals(WebUser.getNo())) {
				BP.Web.WebUser.Exit();
				try {
					Emp emp = new Emp(wk.getRec());
					BP.Web.WebUser.SignInOfGener(emp);
				} catch (java.lang.Exception e) {
					continue;
				}
			}
			String sql = "";
			String title = WorkNode.GenerTitle(fl, wk);
			Paras ps = new Paras();
			ps.Add("Title", title);
			ps.Add("OID", wk.getOID());
			ps.SQL = "UPDATE " + table + " SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE OID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE " + md.getPTable() + " SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE OID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE WF_GenerWorkFlow SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE WorkID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE WF_GenerFH SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE FID=" + SystemConfig.getAppCenterDBVarStr()
					+ "OID";
			DBAccess.RunSQLs(sql);
		}
		Emp emp1 = new Emp("admin");
		BP.Web.WebUser.SignInOfGener(emp1);

		return "全部生成成功,影响数据(" + wks.size() + ")条";
	}

	/**
	 * 重新产生标题，根据新的规则.
	 */
	public final String DoGenerTitle() {
		if (!WebUser.getNo().equals("admin")) {
			return "非admin用户不能执行。";
		}
		Flow fl = new Flow(this.getNo());
		Node nd = fl.getHisStartNode();
		Works wks = nd.getHisWorks();
		wks.RetrieveAllFromDBSource(WorkAttr.Rec);
		String table = nd.getHisWork().getEnMap().getPhysicsTable();
		String tableRpt = "ND" + Integer.parseInt(this.getNo()) + "Rpt";
		MapData md = new MapData(tableRpt);
		for (Work wk : wks.ToJavaList()) {

			if (!wk.getRec().equals(WebUser.getNo())) {
				BP.Web.WebUser.Exit();
				try {
					Emp emp = new Emp(wk.getRec());
					BP.Web.WebUser.SignInOfGener(emp);
				} catch (java.lang.Exception e) {
					continue;
				}
			}
			String sql = "";
			String title = WorkNode.GenerTitle(fl, wk);
			Paras ps = new Paras();
			ps.Add("Title", title);
			ps.Add("OID", wk.getOID());
			ps.SQL = "UPDATE " + table + " SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE OID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE " + md.getPTable() + " SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE OID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE WF_GenerWorkFlow SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE WorkID="
					+ SystemConfig.getAppCenterDBVarStr() + "OID";
			DBAccess.RunSQL(ps);

			ps.SQL = "UPDATE WF_GenerFH SET Title=" + SystemConfig.getAppCenterDBVarStr() + "Title WHERE FID=" + SystemConfig.getAppCenterDBVarStr()
					+ "OID";
			DBAccess.RunSQLs(sql);
		}
		Emp emp1 = new Emp("admin");
		BP.Web.WebUser.SignInOfGener(emp1);

		return "全部生成成功,影响数据(" + wks.size() + ")条";
	}

	/**
	 * 流程监控
	 * @return
	 */
	public final String DoDataManger() {
		return Glo.getCCFlowAppPath() + "WF/Comm/Search.jsp?s=d34&EnsName=BP.WF.Data.GenerWorkFlowViews&FK_Flow=" + this.getNo()
				+ "&ExtType=StartFlow&RefNo=";
	}

	/**
	 * 绑定独立表单
	 * @return
	 */
	public final String DoFlowFormTree() {
		try {
			PubClass.WinOpen(ContextHolderUtils.getResponse(), Glo.getCCFlowAppPath() + "WF/Admin/FlowFormTree.jsp?s=d34&FK_Flow=" + this.getNo()
					+ "&ExtType=StartFlow&RefNo=" + DataType.getCurrentDataTime(), 700, 500);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 定义报表
	 * @return
	 * @throws Exception
	 */
	public final String DoAutoStartIt() throws Exception {
		Flow fl = new Flow();
		fl.setNo(this.getNo());
		fl.RetrieveFromDBSources();
		return fl.DoAutoStartIt();
	}

	/**
	 * 删除流程
	 * @param workid
	 * @param sd
	 * @return
	 */
	public final String DoDelDataOne(int workid, String note) {
		try {
			BP.WF.Dev2Interface.Flow_DoDeleteFlowByReal(this.getNo(), workid, true);
			return "删除成功 workid=" + workid + "  理由:" + note;
		} catch (RuntimeException ex) {
			return "删除失败:" + ex.getMessage();
		}
	}
	
	 /// <summary>
    /// 执行删除指定日期范围内的流程
    /// </summary>
    /// <param name="dtFrom">日期从</param>
    /// <param name="dtTo">日期到</param>
    /// <param name="isOk">仅仅删除当前流程？1=删除当前流程, 0=删除全部流程.</param>
    /// <returns></returns>
    public String DoDelFlows(String dtFrom, String dtTo, String isDelCurrFlow)
    {
        if (BP.Web.WebUser.getNo() != "admin")
            return "非admin用户，不能删除。";

        	String sql = "";
        if (isDelCurrFlow=="1")
            sql = "SELECT WorkID, FK_Flow FROM WF_GenerWorkFlow  WHERE RDT >= '" + dtFrom + "' AND RDT <= '" + dtTo + "'  AND FK_Flow='" + this.getNo() + "' ";
        else
            sql = "SELECT WorkID, FK_Flow FROM WF_GenerWorkFlow  WHERE RDT >= '" + dtFrom + "' AND RDT <= '" + dtTo + "' ";

        DataTable dt = BP.DA.DBAccess.RunSQLReturnTable(sql);

        String msg = "如下流程ID被删除:";
        for(DataRow dr:dt.Rows)
        {
            int workid = Integer.parseInt(dr.getValue("WorkId").toString());
            String fk_flow = dr.getValue("FK_Flow").toString();
            BP.WF.Dev2Interface.Flow_DoDeleteFlowByReal(fk_flow, workid, false);
            msg += " " + workid;
        }	
        return msg;
    }

	/**
	 * 设置发起数据源
	 * @return
	 */
	public final String DoSetStartFlowDataSources() {
//		String flowID = Integer.parseInt(this.getNo()) + "01";
		return Glo.getCCFlowAppPath() + "WF/Admin/AttrFlow/AutoStart.jsp?s=d34&FK_Flow=" + this.getNo() + "&ExtType=StartFlow&RefNo=";
		//return Glo.CCFlowAppPath + "WF/MapDef/MapExt.jsp?s=d34&FK_MapData=ND" + flowID + "&ExtType=StartFlow&RefNo=";
	}

	public final String DoCCNode() {
		try {
			PubClass.WinOpen(ContextHolderUtils.getResponse(), Glo.getCCFlowAppPath() + "WF/Admin/CCNode.jsp?FK_Flow=" + this.getNo(), 400, 500);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 执行运行
	 * @return
	 */
	public final String DoRunIt() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/TestFlow.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 执行检查
	 * @return
	 */
	public final String DoCheck() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/CheckFlow.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 启动限制规则
	 * @return 返回URL
	 */
	public final String DoLimit() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/Limit.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 设置发起前置导航
	 * @return
	 */
	public final String DoStartGuide() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/StartGuide.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 执行数据同步
	 * @return
	 */
	public final String DoDTS() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/DTSBTable.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 导入
	 * @return
	 */
	public final String DoImp() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/imp.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 导出
	 * @return
	 */
	public final String DoExps() {
		return SystemConfig.getCCFlowWebPath() + "WF/Admin/AttrFlow/Exp.jsp?FK_Flow=" + this.getNo() + "&Lang=CH";
	}

	/**
	 * 执行重新装载数据
	 * @return
	 * @throws Exception
	 */
	public final String DoReloadRptData() throws Exception {
		Flow fl = new Flow();
		fl.setNo(this.getNo());
		fl.RetrieveFromDBSources();
		return fl.DoReloadRptData();
	}

	/**
	 * 删除数据.
	 * @return
	 */
	public final String DoDelData() {
		Flow fl = new Flow();
		fl.setNo(this.getNo());
		fl.RetrieveFromDBSources();
		return fl.DoDelData();
	}

	/**
	 * 运行报表
	 * @return
	 */
	public final String DoOpenRpt() {
		return Glo.getCCFlowAppPath() + "WF/Rpt/OneFlow.jsp?FK_Flow=" + this.getNo() + "&DoType=Edit&FK_MapData=ND" + Integer.parseInt(this.getNo())
				+ "Rpt";
	}

	/**
	 * 更新之后的事情，也要更新缓存。
	 */
	@Override
	protected void afterUpdate() {
		// Flow fl = new Flow();
		// fl.No = this.getNo();
		// fl.RetrieveFromDBSources();
		//fl.Update();

		if (Glo.getOSModel() == OSModel.OneMore) {
			DBAccess.RunSQL("UPDATE  GPM_Menu SET Name='" + this.getName() + "' WHERE Flag='Flow" + this.getNo() + "' AND FK_App='"
					+ SystemConfig.getSysNo() + "'");
		}
	}

	@Override
	protected boolean beforeUpdate() {
		//更新流程版本
		Flow.UpdateVer(this.getNo());

		///#region 同步事件实体.
		try {
			this.setFlowEventEntity(BP.WF.Glo.GetFlowEventEntityStringByFlowMark(this.getFlowMark(), this.getNo()));
		} catch (java.lang.Exception e) {
			this.setFlowEventEntity("");
		}
		///#endregion 同步事件实体.

		//更新缓存数据。
		Flow fl = new Flow(this.getNo());
		fl.Copy(this);

		///#region 检查数据完整性 - 同步业务表数据。
		// 检查业务是否存在.
		if (fl.getDTSWay() != FlowDTSWay.None) {
			/*检查业务表填写的是否正确.*/
			String sql = "select count(*) as Num from  " + fl.getDTSBTable() + " where 1=2";
			try {
				DBAccess.RunSQLReturnValInt(sql, 0);
			} catch (RuntimeException e2) {
				throw new RuntimeException("@业务表配置无效，您配置业务数据表[" + fl.getDTSBTable()
						+ "]在数据中不存在，请检查拼写错误如果是跨数据库请加上用户名比如: for sqlserver: HR.dbo.Emps, For oracle: HR.Emps");
			}

			sql = "select " + fl.getDTSBTablePK() + " from " + fl.getDTSBTable() + " where 1=2";
			try {
				DBAccess.RunSQLReturnValInt(sql, 0);
			} catch (RuntimeException e3) {
				throw new RuntimeException("@业务表配置无效，您配置业务数据表[" + fl.getDTSBTablePK() + "]的主键不存在。");
			}

			//检查节点配置是否符合要求.
			if (fl.getDTSTime() == FlowDTSTime.SpecNodeSend) {
				// 检查节点ID，是否符合格式.
				String nodes = fl.getDTSSpecNodes();
				nodes = nodes.replace("，", ",");
				this.SetValByKey(FlowAttr.DTSSpecNodes, nodes);

				if (StringHelper.isNullOrEmpty(nodes) == true) {
					throw new RuntimeException("@业务数据同步数据配置错误，您设置了按照指定的节点配置，但是您没有设置节点,节点的设置格式如下：101,102,103");
				}

				String[] strs = nodes.split("[,]", -1);
				for (String str : strs) {
					if (StringHelper.isNullOrEmpty(str) == true) {
						continue;
					}

					if (BP.DA.DataType.IsNumStr(str) == false) {
						throw new RuntimeException("@业务数据同步数据配置错误，您设置了按照指定的节点配置，但是节点格式错误[" + nodes + "]。正确的格式如下：101,102,103");
					}

					Node nd = new Node();
					nd.setNodeID(Integer.parseInt(str));
					if (nd.getIsExits() == false) {
						throw new RuntimeException("@业务数据同步数据配置错误，您设置的节点格式错误，节点[" + str + "]不是有效的节点。");
					}

					nd.RetrieveFromDBSources();
					if (!nd.getFK_Flow().equals(this.getNo())) {
						throw new RuntimeException("@业务数据同步数据配置错误，您设置的节点[" + str + "]不再本流程内。");
					}
				}
			}

			//检查流程数据存储表是否正确
			if (!StringHelper.isNullOrEmpty(fl.getPTable())) {
				/*检查流程数据存储表填写的是否正确.*/
				sql = "select count(*) as Num from  " + fl.getPTable() + " where 1=2";
				try {
					DBAccess.RunSQLReturnValInt(sql, 0);
				} catch (RuntimeException e4) {
					throw new RuntimeException("@流程数据存储表配置无效，您配置流程数据存储表[" + fl.getPTable()
							+ "]在数据中不存在，请检查拼写错误如果是跨数据库请加上用户名比如: for sqlserver: HR.dbo.Emps, For oracle: HR.Emps");
				}
			}
		}
		///#endregion 检查数据完整性. - 同步业务表数据。

		return super.beforeUpdate();
	}

	@Override
	protected void afterInsertUpdateAction() {
		//同步流程数据表.
		String ndxxRpt = "ND" + Integer.parseInt(this.getNo()) + "Rpt";
		Flow fl = new Flow(this.getNo());
		if (!fl.getPTable().equals("ND" + Integer.parseInt(this.getNo()) + "Rpt")) {
			MapData md = new MapData(ndxxRpt);
			if (!fl.getPTable().equals(md.getPTable())) {
				md.Update();
			}
		}

		//systype设置，当前所在节点的第2级别目录。
		FlowSort fs = new FlowSort(fl.getFK_FlowSort());
		if ("99".equals(fs.getParentNo()) || "0".equals(fs.getParentNo()))
		{
			this.setSysType(fl.getFK_FlowSort());
		}
		else
		{
			FlowSort fsP = new FlowSort(fs.getParentNo());
			if ("99".equals(fsP.getParentNo()) || "0".equals(fs.getParentNo()))
			{
				this.setSysType(fsP.getNo());
			}
			else
			{
				FlowSort fsPP = new FlowSort(fsP.getParentNo());
				this.setSysType(fsPP.getNo());
			}
		}
		super.afterInsertUpdateAction();
	}
	///#endregion
}