package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 标签s
 */
public class FrmLabs extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public static ArrayList<FrmLab> convertFrmLabs(Object obj)
	{
		return (ArrayList<FrmLab>) obj;
	}
	public List<FrmLab> ToJavaList()
	{
		return (List<FrmLab>)(Object)this;
	}
	// 构造
	/**
	 * 标签s
	 */
	public FrmLabs()
	{
	}
	
	/**
	 * 标签s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmLabs(String fk_mapdata)
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
		return new FrmLab();
	}
}