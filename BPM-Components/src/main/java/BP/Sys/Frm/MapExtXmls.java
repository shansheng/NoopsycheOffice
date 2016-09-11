package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.WF.XML.FeatureSet;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 
 
*/
public class MapExtXmls extends XmlEns
{
	public static ArrayList<MapExtXml> convertMapExtXmls(Object obj)
	{
		return (ArrayList<MapExtXml>) obj;
	}
	public List<MapExtXml> ToJavaList()
	{
		return (List<MapExtXml>)(Object)this;
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 考核率的数据元素
	 */
	public MapExtXmls()
	{
	}
	
	// 重写基类属性或方法。
	/**
	 * 得到它的 Entity
	 */
	@Override
	public XmlEn getGetNewEntity()
	{
		return new MapExtXml();
	}
	
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfXML() + "MapExt.xml";
	}
	
	/**
	 * 物理表名
	 */
	@Override
	public String getTableName()
	{
		return "FieldExt";
	}
	
	@Override
	public Entities getRefEns()
	{
		return null; // new BP.ZF1.AdminTools();
	}
}