package BP.WF.XML;

import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 管理员
*/
public class AdminMenu extends XmlEn
{
		///#region 属性
	public final String getNo()
	{
		return this.GetValStringByKey("No");
	}
	public final String getName()
	{
		return this.GetValStringByKey(BP.Web.WebUser.getSysLang());
	}
	public final String getUrl()
	{
		return this.GetValStringByKey("Url");
	}
		///#endregion

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public AdminMenu()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new AdminMenus();
	}
		///#endregion
}