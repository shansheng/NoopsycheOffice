package BP.WF.XML;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 
*/
public class AdminMenus extends XmlEns
{
		///#region 构造
	/** 
	 考核率的数据元素
	*/
	public AdminMenus()
	{
	}
		///#endregion

		///#region 重写基类属性或方法。
	/** 
	 得到它的 Entity 
	*/
	public XmlEn getGetNewEntity()
	{
		return new AdminMenu();
	}
	public String getFile()
	{
		return SystemConfig.getPathOfWebApp() + "WF/Admin/Port/AdminMenu.xml";
	}
	/** 
	 物理表名
	*/
	public String getTableName()
	{
		return "Item";
	}
	public Entities getRefEns()
	{
		return null; //new BP.ZF1.AdminAdminMenus();
	}
		///#endregion

}