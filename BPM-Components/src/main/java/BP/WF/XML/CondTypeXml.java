package BP.WF.XML;

import BP.XML.XmlEnNoName;
import BP.XML.XmlEns;

/** 
 皮肤
*/
public class CondTypeXml extends XmlEnNoName
{
	public final String getName()
	{
		return this.GetValStringByKey(BP.Web.WebUser.getSysLang());
	}

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public CondTypeXml()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new CondTypeXmls();
	}
		///#endregion
}