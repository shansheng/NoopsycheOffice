package BP.WF.XML;

import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 移动菜单
*/
public class Mobile extends XmlEn
{
		///#region 属性
	/** 
	 编号
	*/
	public final String getNo()
	{
		return this.GetValStringByKey("No");
	}
	/** 
	 名称
	*/
	public final String getName()
	{
		return this.GetValStringByKey("Name");
	}
		///#endregion

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public Mobile()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new Mobiles();
	}
		///#endregion
}