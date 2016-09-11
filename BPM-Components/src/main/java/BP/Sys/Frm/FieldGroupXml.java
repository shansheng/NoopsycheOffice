package BP.Sys.Frm;

import BP.Web.WebUser;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/**
 * 分组内容
 */
public class FieldGroupXml extends XmlEn
{
	// 属性
	public final String getNo()
	{
		return this.GetValStringByKey("No");
	}
	
	public final String getName()
	{
		return this.GetValStringByKey(WebUser.getSysLang());
	}
	
	public final String getDesc()
	{
		return this.GetValStringByKey(WebUser.getSysLang() + "Desc");
	}
	
	// 构造
	/**
	 * 节点扩展信息
	 */
	public FieldGroupXml()
	{
	}
	
	/**
	 * 获取一个实例s
	 */
	@Override
	public XmlEns getGetNewEntities()
	{
		return new FieldGroupXmls();
	}
}