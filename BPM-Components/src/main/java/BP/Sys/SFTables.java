package BP.Sys;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.WF.Entity.ReturnWork;

/**
 * 用户自定义表s
 */
public class SFTables extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public static ArrayList<SFTable> convertSFTables(Object obj)
	{
		return (ArrayList<SFTable>) obj;
	}
	public List<SFTable> ToJavaList()
	{
		return (List<SFTable>)(Object)this;
	}
	//  构造
	/**
	 * 用户自定义表s
	 */
	public SFTables()
	{
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new SFTable();
	}
}