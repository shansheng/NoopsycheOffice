package BP.GPM;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.Sys.Frm.MapExt;

/**
 * 岗位s
 */
public class Stations extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 岗位
	 */
	public Stations()
	{
	}
	
	public static ArrayList<Station> convertStations(Object obj)
	{
		return (ArrayList<Station>) obj;
	}
	public List<Station> ToJavaList()
	{
		return (List<Station>)(Object)this;
	}
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new BP.GPM.Station();
	}
}