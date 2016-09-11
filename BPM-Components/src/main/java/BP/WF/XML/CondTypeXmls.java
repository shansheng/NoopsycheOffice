package BP.WF.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 皮肤s
*/
public class CondTypeXmls extends XmlEns
{
		///#region 构造
	/** 
	 皮肤s
	*/
	public CondTypeXmls()
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
		return new CondTypeXml();
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
		return "CondType";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
		///#endregion

}