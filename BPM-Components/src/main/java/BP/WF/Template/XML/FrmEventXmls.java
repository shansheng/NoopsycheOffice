package BP.WF.Template.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 表单事件
*/
public class FrmEventXmls extends XmlEns
{
		///#region 构造
	/** 
	 考核率的数据元素
	*/
	public FrmEventXmls()
	{
	}
		///#endregion

		///#region 重写基类属性或方法。
	/** 
	 得到它的 Entity 
	*/
	public XmlEn getGetNewEntity()
	{
		return new FrmEventXml();
	}
	public String getFile()
	{
		   // return SystemConfig.getPathOfWebApp() + "\\WF\\MapDef\\Style\\XmlDB.xml";

		return SystemConfig.getPathOfData() + "XML/XmlDB.xml";

	}
	/** 
	 物理表名
	*/
	public String getTableName()
	{
		return "FrmEvent";
	}
	public Entities getRefEns()
	{
		return null; //new BP.ZF1.AdminTools();
	}
		///#endregion

}