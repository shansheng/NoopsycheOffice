package BP.WF.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 流程一户式s
*/
public class RptXmls extends XmlEns
{
		///#region 构造
	/** 
	 流程一户式s
	*/
	public RptXmls()
	{
	}
		///#endregion

		///#region 重写基类属性或方法。
	/** 
	 得到它的 Entity 
	*/
	@Override
	public XmlEn getGetNewEntity()
	{
		return new RptXml();
	}
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfData() + "Xml/WFAdmin.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "RptFlow";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
		///#endregion
}