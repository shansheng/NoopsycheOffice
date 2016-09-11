package BP.WF.XML;

import BP.XML.XmlEnNoName;
import BP.XML.XmlEns;

/** 
 默认值
*/
public class DefVal extends XmlEnNoName
{
		///#region 属性
	public final String getVal()
	{
		return this.GetValStringByKey("Val");
	}
		///#endregion

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public DefVal()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new DefVals();
	}
		///#endregion
}