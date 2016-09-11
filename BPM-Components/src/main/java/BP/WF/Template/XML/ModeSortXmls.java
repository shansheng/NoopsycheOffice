package BP.WF.Template.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 模式s
*/
public class ModeSortXmls extends XmlEns
{
		///#region 构造
	/** 
	 模式s
	*/
	public ModeSortXmls()
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
		return new ModeSortXml();
	}
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfWebApp() + "WF/Admin/AccepterRole/AccepterRole.xml";

	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "ModelSort";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
		///#endregion

}