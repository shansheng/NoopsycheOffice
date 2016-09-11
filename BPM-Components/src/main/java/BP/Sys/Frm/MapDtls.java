package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;

/**
 * 明细s
 */
public class MapDtls extends EntitiesNoName
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 明细s
	 */
	public MapDtls()
	{
	}
	
	@SuppressWarnings("unchecked")
	public static ArrayList<MapDtl> convertMapDtls(Object obj)
	{
		return (ArrayList<MapDtl>) obj;
	}
	
	/**
	 * 明细s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public MapDtls(String fk_mapdata)
	{
		this.Retrieve(MapDtlAttr.FK_MapData, fk_mapdata, MapDtlAttr.FK_Node, 0,
				MapDtlAttr.No);
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new MapDtl();
	}

	public List<MapDtl> ToJavaList() {
		return (List<MapDtl>)(Object)this;
	}
}