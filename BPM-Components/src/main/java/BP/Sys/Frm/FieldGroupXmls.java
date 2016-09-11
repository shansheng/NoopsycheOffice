package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.WF.XML.FeatureSet;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/**
 * 分组内容s
 */
public class FieldGroupXmls extends XmlEns
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 分组内容s
	 */
	public FieldGroupXmls()
	{
	}
	
	public static ArrayList<FieldGroupXml> convertFieldGroupXmls(Object obj)
	{
		return (ArrayList<FieldGroupXml>) obj;
	}
	
	// 重写基类属性或方法。
	/**
	 * 得到它的 Entity
	 */
	@Override
	public XmlEn getGetNewEntity()
	{
		return new FieldGroupXml();
	}
	
	@Override
	public String getFile()
	{
		// return SystemConfig.getPathOfWebApp() + "\\WF\\MapDef\\Style\\XmlDB.xml";
		return SystemConfig.getPathOfData() + "/XML/XmlDB.xml";
		// \MapDef\\Style\
	}
	
	/**
	 * 物理表名
	 */
	@Override
	public String getTableName()
	{
		return "FieldGroup";
	}
	
	@Override
	public Entities getRefEns()
	{
		return null; // new BP.ZF1.AdminTools();
	}
	public List<FieldGroupXml> ToJavaList()
	{
		return (List<FieldGroupXml>)(Object)this;
	}
}