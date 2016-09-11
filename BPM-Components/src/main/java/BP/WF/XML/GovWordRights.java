package BP.WF.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 公文右边谓词s
*/
public class GovWordRights extends XmlEns
{
		///#region 构造
	/** 
	 考核率的数据元素
	*/
	public GovWordRights()
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
		return new GovWordRight();
	}
	/** 
	 XML文件位置.
	*/
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfWebApp() + "WF/Data/XML/XmlDB.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "GovWordRight";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
		///#endregion
}