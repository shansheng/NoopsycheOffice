package BP.WF.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 
*/
public class Mobiles extends XmlEns
{
		///#region 构造
	/** 
	 考核率的数据元素
	*/
	public Mobiles()
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
		return new Mobile();
	}
	@Override
	public String getFile()
	{
		return SystemConfig.getCCFlowAppPath() + "DataUser/XML/Mobiles.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "Item";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
		///#endregion

}