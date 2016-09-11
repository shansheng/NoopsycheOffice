package BP.Sys.Frm;

import org.apache.commons.lang.StringUtils;

import BP.DA.Depositary;
import BP.En.EnType;
import BP.En.EntityMyPK;
import BP.En.Map;
import BP.Sys.SystemConfig;

/**
 * 附件
 */
public class FrmAttachment extends EntityMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 属性
	/**
	 * 是否可见？
	 */
	public final boolean getIsVisable()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsVisable, true);
	}
	
	public final void setIsVisable(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsVisable, value);
	}
	
	public final int getIsDeleteInt()
	{
		return this.GetValIntByKey(FrmAttachmentAttr.IsDelete);
	}
	
	public final void setIsDeleteInt(int value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsDelete, value);
	}
	
	/*
	 * 
	 * 是否可以排序
	 */
	public final boolean getIsOrder()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsOrder);
	}
	
	public final void setIsOrder(Boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsOrder, value);
	}
	
	/**
	 * 节点编号
	 */
	public final int getFK_Node()
	{
		return this.GetValIntByKey(FrmAttachmentAttr.FK_Node);
	}
	
	public final void setFK_Node(int value)
	{
		this.SetValByKey(FrmAttachmentAttr.FK_Node, value);
	}
	
	/**
	 * 上传类型（单个的，多个，指定的）
	 */
	public final AttachmentUploadType getUploadType()
	{
		return AttachmentUploadType.forValue(this
				.GetValIntByKey(FrmAttachmentAttr.UploadType));
	}
	
	public final void setUploadType(AttachmentUploadType value)
	{
		this.SetValByKey(FrmAttachmentAttr.UploadType, value.getValue());
	}
	
	/**
	 * 类型名称
	 */
	public final String getUploadTypeT()
	{
		if (this.getUploadType() == AttachmentUploadType.Multi)
		{
			return "多附件";
		}
		if (this.getUploadType() == AttachmentUploadType.Single)
		{
			return "单附件";
		}
		if (this.getUploadType() == AttachmentUploadType.Specifically)
		{
			return "指定的";
		}
		return "XXXXX";
	}
	/** 
	 是否汇总到合流节点上去？
	*/
	public final boolean getIsToHeLiuHZ()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsToHeLiuHZ);
	}
	
	public final void setIsToHeLiuHZ(Boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsToHeLiuHZ, value);
	}
	/** 
	 是否是合流汇总
	*/
	public final boolean getIsHeLiuHuiZong()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsHeLiuHuiZong);
	}
	
	public final void setIsHeLiuHuiZong(Boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsHeLiuHuiZong, value);
	}
	
	/**
	 * 是否可以上传
	 */
	public final boolean getIsUpload()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsUpload);
	}
	
	public final void setIsUpload(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsUpload, value);
	}
	
	/**
	 * 是否可以下载
	 */
	public final boolean getIsDownload()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsDownload);
	}
	
	public final void setIsDownload(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsDownload, value);
	}
	
	/**
	 * 是否可以删除
	 */
	public final boolean getIsDelete()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsDelete);
	}
	
	public final void setIsDelete(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsDelete, value);
	}
	
	/**
	 * 自动控制大小
	 */
	public final boolean getIsAutoSize()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsAutoSize);
	}
	
	public final void setIsAutoSize(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsAutoSize, value);
	}
	
	/**
	 * IsShowTitle
	 */
	public final boolean getIsShowTitle()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsShowTitle);
	}
	
	public final void setIsShowTitle(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsShowTitle, value);
	}
	/** 
	 是否是节点表单.
	 
	*/
	public final boolean getIsNodeSheet() {
		if (this.getFK_MapData().startsWith("ND") == true) {
			return true;
		}
		return false;
	}

	/**
	 * 备注列
	 */
	public final boolean getIsNote()
	{
		return this.GetValBooleanByKey(FrmAttachmentAttr.IsNote);
	}
	
	public final void setIsNote(boolean value)
	{
		this.SetValByKey(FrmAttachmentAttr.IsNote, value);
	}
	
	/**
	 * 附件名称
	 */
	public final String getName()
	{
		return this.GetValStringByKey(FrmAttachmentAttr.Name);
	}
	
	public final void setName(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.Name, value);
	}
	
	/**
	 * 类别
	 */
	public final String getSort()
	{
		return this.GetValStringByKey(FrmAttachmentAttr.Sort);
	}
	
	public final void setSort(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.Sort, value);
	}
	/** 
	 使用上传附件的 - 控件类型
	 0=批量.
	 1=单个。
	 
	*/
	public final int getUploadCtrl() {
		return this.GetParaInt(FrmAttachmentAttr.UploadCtrl);
	}
	public final void setUploadCtrl(int value) {
		this.SetPara(FrmAttachmentAttr.UploadCtrl, value);
	}

	/** 
	 上传校验
	 0=不校验.
	 1=不能为空.
	 2=每个类别下不能为空.
	 
	*/
	public final UploadFileNumCheck  getUploadFileNumCheck() {
		return UploadFileNumCheck .forValue(this.GetParaInt(FrmAttachmentAttr.UploadFileNumCheck));
	}
	public final void setUploadFileNumCheck(UploadFileNumCheck value) {
		this.SetPara(FrmAttachmentAttr.UploadFileNumCheck, value.getValue());
	}

	/** 
	 上传校验,方式.
	 
	*/
	public enum UploadFileNumCheck {
		/** 
		 不校验
		 
		*/
		None,
		/** 
		 不能为空
		 
		*/
		NotEmpty,
		/** 
		 每个类别不能为空.
		 
		*/
		EverySortNoteEmpty;

		public int getValue() {
			return this.ordinal();
		}

		public static UploadFileNumCheck forValue(int value) {
			return values()[value];
		}
	}
	/**
	 * 文件数据存储方式
	 */
	public final int getSaveWay(){
		return this.GetValIntByKey(FrmAttachmentAttr.SaveWay);
	}
	public final void setSaveWay(int value){
		this.SetValByKey(FrmAttachmentAttr.SaveWay,value);
	}
	
	
	/**
	 * 要求的格式
	 */
	public final String getExts()
	{
		return this.GetValStringByKey(FrmAttachmentAttr.Exts);
	}
	
	public final void setExts(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.Exts, value);
	}
	
	public final String getSaveTo()
	{
		String s = this.GetValStringByKey(FrmAttachmentAttr.SaveTo);
		if (s.equals("") || s == null)
		{
			s = SystemConfig.getPathOfDataUser() + "/UploadFile/"
					+ this.getFK_MapData() + "/";
		}
		return s;
	}
	
	public final void setSaveTo(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.SaveTo, value);
	}
	
	/**
	 * 附件编号
	 */
	public final String getNoOfObj()
	{
		return this.GetValStringByKey(FrmAttachmentAttr.NoOfObj);
	}
	
	public final void setNoOfObj(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.NoOfObj, value);
	}
	
	/**
	 * Y
	 */
	public final float getY()
	{
		return this.GetValFloatByKey(FrmAttachmentAttr.Y);
	}
	
	public final void setY(float value)
	{
		this.SetValByKey(FrmAttachmentAttr.Y, value);
	}
	
	/**
	 * X
	 */
	public final float getX()
	{
		return this.GetValFloatByKey(FrmAttachmentAttr.X);
	}
	
	public final void setX(float value)
	{
		this.SetValByKey(FrmAttachmentAttr.X, value);
	}
	
	/**
	 * W
	 */
	public final float getW()
	{
		return this.GetValFloatByKey(FrmAttachmentAttr.W);
	}
	
	public final void setW(float value)
	{
		this.SetValByKey(FrmAttachmentAttr.W, value);
	}
	
	/**
	 * H
	 */
	public final float getH()
	{
		return this.GetValFloatByKey(FrmAttachmentAttr.H);
	}
	
	public final void setH(float value)
	{
		this.SetValByKey(FrmAttachmentAttr.H, value);
	}
	
	public final int getRowIdx()
	{
		return this.GetValIntByKey(FrmAttachmentAttr.RowIdx);
	}
	
	public final void setRowIdx(int value)
	{
		this.SetValByKey(FrmAttachmentAttr.RowIdx, value);
	}
	
	public final int getGroupID()
	{
		return this.GetValIntByKey(FrmAttachmentAttr.GroupID);
	}
	
	public final void setGroupID(int value)
	{
		this.SetValByKey(FrmAttachmentAttr.GroupID, value);
	}
	
	/**
	 * 数据控制方式
	 */
	public final AthCtrlWay getHisCtrlWay()
	{
		return AthCtrlWay.forValue(this
				.GetValIntByKey(FrmAttachmentAttr.CtrlWay));
	}
	
	public final void setHisCtrlWay(AthCtrlWay value)
	{
		this.SetValByKey(FrmAttachmentAttr.CtrlWay, value.getValue());
	}
	
	/**
	 * 文件展现方式
	 */
	public final FileShowWay getFileShowWay()
	{
		return FileShowWay.forValue(this
				.GetParaInt(FrmAttachmentAttr.FileShowWay));
	}
	
	public final void setFileShowWay(FileShowWay value)
	{
		this.SetPara(FrmAttachmentAttr.FileShowWay, value.getValue());
	}
	
	/**
	 * 上传方式（对于父子流程有效）
	 */
	public final AthUploadWay getAthUploadWay()
	{
		return AthUploadWay.forValue(this
				.GetValIntByKey(FrmAttachmentAttr.AthUploadWay));
	}
	
	public final void setAthUploadWay(AthUploadWay value)
	{
		this.SetValByKey(FrmAttachmentAttr.AthUploadWay, value.getValue());
	}
	
	/**
	 * FK_MapData
	 */
	public final String getFK_MapData()
	{
		return this.GetValStrByKey(FrmAttachmentAttr.FK_MapData);
	}
	
	public final void setFK_MapData(String value)
	{
		this.SetValByKey(FrmAttachmentAttr.FK_MapData, value);
	}
	
	// weboffice文档属性(参数属性)
	
	/**
	 * 是否启用锁定行
	 */
	public final boolean getIsRowLock()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsRowLock, false);
	}
	
	public final void setIsRowLock(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsRowLock, value);
	}
	
	/**
	 * 是否启用打印
	 */
	public final boolean getIsWoEnablePrint()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnablePrint);
	}
	
	public final void setIsWoEnablePrint(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnablePrint, value);
	}
	
	/**
	 * 是否启用只读
	 */
	public final boolean getIsWoEnableReadonly()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableReadonly);
	}
	
	public final void setIsWoEnableReadonly(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableReadonly, value);
	}
	
	/**
	 * 是否启用修订
	 */
	public final boolean getIsWoEnableRevise()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableRevise);
	}
	
	public final void setIsWoEnableRevise(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableRevise, value);
	}
	
	/**
	 * 是否启用保存
	 */
	public final boolean getIsWoEnableSave()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableSave);
	}
	
	public final void setIsWoEnableSave(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableSave, value);
	}
	
	/**
	 * 是否查看用户留痕
	 */
	public final boolean getIsWoEnableViewKeepMark()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableViewKeepMark);
	}
	
	public final void setIsWoEnableViewKeepMark(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableViewKeepMark, value);
	}
	
	/**
	 * 是否启用weboffice
	 */
	public final boolean getIsWoEnableWF()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableWF);
	}
	
	public final void setIsWoEnableWF(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableWF, value);
	}
	
	/**
	 * 是否启用套红
	 */
	public final boolean getIsWoEnableOver()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableOver);
	}
	
	public final void setIsWoEnableOver(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableOver, value);
	}
	
	
	/**
	 * 是否启用签章
	 */
	public final boolean getIsWoEnableSeal()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableSeal);
	}
	
	public final void setIsWoEnableSeal(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableSeal, value);
	}
	
	/**
	 * 是否启用公文模板
	 */
	public final boolean getIsWoEnableTemplete()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableTemplete);
	}
	
	public final void setIsWoEnableTemplete(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableTemplete, value);
	}
	
	/**
	 * 是否记录节点信息
	 */
	public final boolean getIsWoEnableCheck()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableCheck);
	}
	
	public final void setIsWoEnableCheck(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableCheck, value);
	}
	
	/**
	 * 是否插入流程图
	 */
	public final boolean getIsWoEnableInsertFlow()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableInsertFlow);
	}
	
	public final void setIsWoEnableInsertFlow(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableInsertFlow, value);
	}
	
	/**
	 * 是否插入风险点
	 */
	public final boolean getIsWoEnableInsertFengXian()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableInsertFengXian);
	}
	
	public final void setIsWoEnableInsertFengXian(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableInsertFengXian, value);
	}
	
	/**
	 * 是否启用留痕模式
	 */
	public final boolean getIsWoEnableMarks()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableMarks);
	}
	
	public final void setIsWoEnableMarks(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableMarks, value);
	}
	
	/**
	 * 是否插入风险点
	 */
	public final boolean getIsWoEnableDown()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.IsWoEnableDown);
	}
	
	public final void setIsWoEnableDown(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.IsWoEnableDown, value);
	}
	
	// weboffice文档属性
	
	// 快捷键
	/**
	 * 是否启用快捷键
	 */
	public final boolean getFastKeyIsEnable()
	{
		return this.GetParaBoolen(FrmAttachmentAttr.FastKeyIsEnable);
	}
	
	public final void setFastKeyIsEnable(boolean value)
	{
		this.SetPara(FrmAttachmentAttr.FastKeyIsEnable, value);
	}
	
	/**
	 * 启用规则
	 */
	public final String getFastKeyGenerRole()
	{
		return this.GetParaString(FrmAttachmentAttr.FastKeyGenerRole);
	}
	
	public final void setFastKeyGenerRole(String value)
	{
		this.SetPara(FrmAttachmentAttr.FastKeyGenerRole, value);
	}
	
	// 快捷键
	
	// 构造方法
	/**
	 * 附件
	 */
	public FrmAttachment()
	{
	}
	
	/**
	 * 附件
	 * 
	 * @param mypk
	 */
	public FrmAttachment(String mypk)
	{
		this.setMyPK(mypk);
		this.Retrieve();
	}
	
	/**
	 * EnMap
	 */
	@Override
	public Map getEnMap()
	{
		if (this.get_enMap() != null)
		{
			return this.get_enMap();
		}
		Map map = new Map("Sys_FrmAttachment");
		
		map.setDepositaryOfEntity(Depositary.None);
		map.setDepositaryOfMap(Depositary.Application);
		map.setEnDesc("附件");
		map.setEnType(EnType.Sys);
		map.AddMyPK();
		
		map.AddTBString(FrmAttachmentAttr.FK_MapData, null, "表单ID", true,
				false, 1, 30, 20);
		map.AddTBString(FrmAttachmentAttr.NoOfObj, null, "附件编号", true, false,
				0, 50, 20);
		map.AddTBInt(FrmAttachmentAttr.FK_Node, 0, "节点控制(对sln有效)", false, false);
		
		map.AddTBString(FrmAttachmentAttr.Name, null, "名称", true, false, 0, 50,
				20);
		map.AddTBString(FrmAttachmentAttr.Exts, null, "要求上传的格式", true, false,
				0, 50, 20);
		map.AddTBString(FrmAttachmentAttr.SaveTo, null, "保存到", true, false, 0,
				150, 20);
		map.AddTBString(FrmAttachmentAttr.Sort, null, "类别(可为空)", true, false,
				0, 500, 20);
		
		map.AddTBFloat(FrmAttachmentAttr.X, 5, "X", true, false);
		map.AddTBFloat(FrmAttachmentAttr.Y, 5, "Y", false, false);
		map.AddTBFloat(FrmAttachmentAttr.W, 40, "TBWidth", false, false);
		map.AddTBFloat(FrmAttachmentAttr.H, 150, "H", false, false);
		
		map.AddBoolean(FrmAttachmentAttr.IsUpload, true, "是否可以上传", false, false);
		map.AddTBInt(FrmAttachmentAttr.IsDelete, 1,
				"附件删除规则(0=不能删除1=删除所有2=只能删除自己上传的)", false, false);
		map.AddBoolean(FrmAttachmentAttr.IsDownload, true, "是否可以下载", false,
				false);
		map.AddBoolean(FrmAttachmentAttr.IsOrder, false, "是否可以排序", false, false);
		
		map.AddBoolean(FrmAttachmentAttr.IsAutoSize, true, "自动控制大小", false,
				false);
		map.AddBoolean(FrmAttachmentAttr.IsNote, true, "是否增加备注", false, false);
		map.AddBoolean(FrmAttachmentAttr.IsShowTitle, true, "是否显示标题列", false,
				false);
		map.AddTBInt(FrmAttachmentAttr.UploadType, 0, "上传类型0单个1多个2指定", false,
				false);
		
		// 对于父子流程有效.
		map.AddTBInt(FrmAttachmentAttr.CtrlWay, 0,
				"控制呈现控制方式0=PK,1=FID,2=ParentID", false, false);
		map.AddTBInt(FrmAttachmentAttr.AthUploadWay, 0,
				"控制上传控制方式0=继承模式,1=协作模式.", false, false);
		
		// 参数属性.
		map.AddTBAtParas(3000);
		
		map.AddTBInt(FrmAttachmentAttr.RowIdx, 0, "RowIdx", false, false);
		map.AddTBInt(FrmAttachmentAttr.GroupID, 0, "GroupID", false, false);
		map.AddTBString(FrmAttachmentAttr.GUID, null, "GUID", true, false, 0,
				128, 20);
		
		this.set_enMap(map);
		return this.get_enMap();
	}
	
	public boolean IsUse = false;
	
	@Override
	protected boolean beforeUpdateInsertAction()
	{
		if (this.getFK_Node() == 0)
        {
            //适应设计器新的规则 by dgq 
            if (!StringUtils.isBlank(this.getNoOfObj()) && this.getNoOfObj().contains(this.getFK_MapData()))
                this.setMyPK(this.getNoOfObj());
            else
                this.setMyPK(this.getFK_MapData() + "_" + this.getNoOfObj());
        }
        else
            this.setMyPK(this.getFK_MapData() + "_" + this.getNoOfObj() + "_" + this.getFK_Node());
		
		return super.beforeUpdateInsertAction();
	}
	
	@Override
	protected boolean beforeInsert()
	{
		this.setIsWoEnableWF(true);
		
		this.setIsWoEnableSave(false);
		this.setIsWoEnableReadonly(false);
		this.setIsWoEnableRevise(false);
		this.setIsWoEnableViewKeepMark(false);
		this.setIsWoEnablePrint(false);
		this.setIsWoEnableOver(false);
		this.setIsWoEnableSeal(false);
		this.setIsWoEnableTemplete(false);

        if (this.getFK_Node() == 0)
            this.setMyPK(this.getFK_MapData() + "_" + this.getNoOfObj());
        else
            this.setMyPK(this.getFK_MapData() + "_" + this.getNoOfObj() + "_" + this.getFK_Node());
        
		return super.beforeInsert();
	}
}