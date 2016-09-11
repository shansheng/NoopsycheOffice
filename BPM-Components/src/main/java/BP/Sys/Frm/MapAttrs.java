package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.En.QueryObject;

/**
 * 实体属性s
 */
public class MapAttrs extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 实体属性s
	 */
	public MapAttrs()
	{
	}
	
	@SuppressWarnings("unchecked")
	public static ArrayList<MapAttr> convertMapAttrs(Object obj)
	{
		return (ArrayList<MapAttr>) obj;
	}
	public List<MapAttr> ToJavaList()
	{
		return (List<MapAttr>)(Object)this;
	}
	
	/**
	 * 实体属性s
	 */
	public MapAttrs(String fk_map)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(MapAttrAttr.FK_MapData, fk_map);
		qo.addOrderBy(MapAttrAttr.IDX);
		qo.DoQuery();
	}
	
	public final int SearchMapAttrsYesVisable(String fk_map)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(MapAttrAttr.FK_MapData, fk_map);
		qo.addAnd();
		qo.AddWhere(MapAttrAttr.UIVisible, 1);
		qo.addOrderBy(MapAttrAttr.GroupID, MapAttrAttr.IDX);
		// qo.addOrderBy(MapAttrAttr.IDX);
		return qo.DoQuery();
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new MapAttr();
	}
	
	public final int getWithOfCtl()
	{
		int i = 0;
		for (MapAttr item : convertMapAttrs(this))
		{
			if (!item.getUIVisible())
			{
				continue;
			}
			
			i += item.getUIWidthInt();
		}
		return i;
	}
}