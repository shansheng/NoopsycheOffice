package BP.WF.XML;

import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 经典模式左侧菜单-高级功能
*/
public class ClassicMenuAdvFunc extends XmlEn
{
		///#region 属性
	public final String getNo()
	{
		return this.GetValStringByKey("No");
	}
	public final String getName()
	{
		String no = this.getNo();
		if (no.equals("EmpWorks"))
		{
			return this.GetValStringByKey(BP.Web.WebUser.getSysLang()) + "(" + BP.WF.Dev2Interface.getTodolist_EmpWorks() + ")";
		} else if (no.equals("Sharing"))
		{
			return this.GetValStringByKey(BP.Web.WebUser.getSysLang()) + "(" + BP.WF.Dev2Interface.getTodolist_Sharing() + ")";
		} else if (no.equals("CC"))
		{
			return this.GetValStringByKey(BP.Web.WebUser.getSysLang()) + "(" + BP.WF.Dev2Interface.getTodolist_CCWorks() + ")";
		} else
		{
			return this.GetValStringByKey(BP.Web.WebUser.getSysLang());
		}
	}
	/** 
	 图片
	*/
	public final String getImg()
	{
		return this.GetValStringByKey("Img");
	}
	public final String getTitle()
	{
		return this.GetValStringByKey("Title");
	}
	public final String getUrl()
	{
		return this.GetValStringByKey("Url");
	}
	public final boolean getEnable()
	{
		return this.GetValBoolByKey("Enable");
	}
		///#endregion

		///#region 构造
	/** 
	 节点扩展信息
	*/
	public ClassicMenuAdvFunc()
	{
	}
	/** 
	 获取一个实例
	*/
	@Override
	public XmlEns getGetNewEntities()
	{
		return new ClassicMenuAdvFuncs();
	}
		///#endregion
}