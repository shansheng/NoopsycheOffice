package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 超连接s
 */
public class FrmLinks extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 超连接s
	 */
	public FrmLinks()
	{
	}
	
	public static ArrayList<FrmLink> convertFrmLinks(Object obj)
	{
		return (ArrayList<FrmLink>) obj;
	}
	public List<FrmLink> ToJavaList()
	{
		return (List<FrmLink>)(Object)this;
	}
	/**
	 * 超连接s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmLinks(String fk_mapdata)
	{
		if (SystemConfig.getIsDebug())
		{
			this.Retrieve(FrmLineAttr.FK_MapData, fk_mapdata);
		} else
		{
			this.RetrieveFromCash(FrmLineAttr.FK_MapData, (Object) fk_mapdata);
		}
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmLink();
	}
}