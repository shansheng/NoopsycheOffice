package BP.WF.XML;

import java.util.List;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 皮肤s
*/
public class Skins extends XmlEns
{
		///#region 构造
	/** 
	 皮肤s
	*/
	public Skins()
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
		return new Skin();
	}
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfWebApp() + "WF/Style/Tools.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "Skin";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
	public List<Skin> ToJavaList()
	{
		return (List<Skin>)(Object)this;
	}

}