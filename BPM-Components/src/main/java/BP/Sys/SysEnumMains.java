package BP.Sys;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.XML.XmlEn;

/**
 * 纳税人集合
 */
public class SysEnumMains extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public static ArrayList<SysEnumMain> convertSysEnumMains(Object obj)
	{
		return (ArrayList<SysEnumMain>) obj;
	}
	public List<SysEnumMain> ToJavaList()
	{
		return (List<SysEnumMain>)(Object)this;
	}
	/**
	 * SysEnumMains
	 */
	public SysEnumMains()
	{
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new SysEnumMain();
	}
}