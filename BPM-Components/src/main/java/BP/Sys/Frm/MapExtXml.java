package BP.Sys.Frm;

import BP.Web.WebUser;
import BP.XML.XmlEnNoName;
import BP.XML.XmlEns;

public class MapExtXml extends XmlEnNoName
{
	// 属性
	public final String getName()
	{
		return this.GetValStringByKey(WebUser.getSysLang());
	}
	
	public final String getURL()
	{
		return this.GetValStringByKey("URL");
	}
	
	// 构造
	/**
	 * 节点扩展信息
	 */
	public MapExtXml()
	{
	}
	
	/**
	 * 获取一个实例
	 */
	@Override
	public XmlEns getGetNewEntities()
	{
		return new MapExtXmls();
	}
}