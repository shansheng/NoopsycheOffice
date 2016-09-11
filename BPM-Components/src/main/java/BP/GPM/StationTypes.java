package BP.GPM;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.Sys.SFDBSrc;

/**
 * 岗位类型
 */
public class StationTypes extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 岗位类型s
	 */
	public StationTypes()
	{
	}
	
	public static ArrayList<StationType> convertStationTypes(Object obj)
	{
		return (ArrayList<StationType>) obj;
	}
	public List<StationType> ToJavaList()
	{
		return (List<StationType>)(Object)this;
	}
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new StationType();
	}
}