package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;

/**
 * 点对点s
 */
public class MapM2Ms extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 点对点s
	 */
	public MapM2Ms()
	{
	}
	
	public static ArrayList<MapM2M> convertMapM2Ms(Object obj)
	{
		return (ArrayList<MapM2M>) obj;
	}
	public List<MapM2M> ToJavaList()
	{
		return (List<MapM2M>)(Object)this;
	}
	/**
	 * 点对点s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public MapM2Ms(String fk_mapdata)
	{
		this.Retrieve(MapM2MAttr.FK_MapData, fk_mapdata, MapM2MAttr.GroupID);
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new MapM2M();
	}
}