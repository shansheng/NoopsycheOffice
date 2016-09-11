package BP.WF.XML;

import BP.XML.XmlEnNoName;
import BP.XML.XmlEns;

/** 
 工作明细选项
*/
public class WorkOptDtlXml extends XmlEnNoName
{
	public final String getName()
	{
		return this.GetValStringByKey(BP.Web.WebUser.getSysLang());
	}
	public final String getURL()
	{
		return this.GetValStringByKey("URL");
	}

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public WorkOptDtlXml()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new WorkOptDtlXmls();
	}
		///#endregion
}