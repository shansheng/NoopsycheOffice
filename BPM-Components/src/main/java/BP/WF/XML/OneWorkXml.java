package BP.WF.XML;

import BP.XML.XmlEnNoName;
import BP.XML.XmlEns;

/** 
 工作一户式
*/
public class OneWorkXml extends XmlEnNoName
{
		///#region 属性.
	public final String getName()
	{
		return this.GetValStringByKey(BP.Web.WebUser.getSysLang());
	}
	public final String getURL()
	{
		return this.GetValStringByKey("No");
	}
		///#endregion 属性.

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public OneWorkXml()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new OneWorkXmls();
	}
		///#endregion
}