package BP.WF.XML;

import java.util.List;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.WF.Port.WFEmp;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 经典模式左侧菜单s
*/
public class ClassicMenus extends XmlEns
{
		///#region 构造
	/** 
	 考核率的数据元素
	*/
	public ClassicMenus()
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
		return new ClassicMenu();
	}
	@Override
	public String getFile()
	{
		//return SystemConfig.getPathOfDataUser() + "XML\\Menu.xml";
		return SystemConfig.getPathOfDataUser() + "XML/LeftEnum.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "ClassicMenu";
	}
	@Override
	public Entities getRefEns()
	{
		return null; //new BP.ZF1.AdminTools();
	}
	public List<ClassicMenu> ToJavaList()
	{
		return (List<ClassicMenu>)(Object)this;
	}
}