package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 图片s
 */
public class FrmImgs extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//  构造
	
	public static ArrayList<FrmImg> convertFrmImgs(Object obj)
	{
		return (ArrayList<FrmImg>) obj;
	}
	public List<FrmImg> ToJavaList()
	{
		return (List<FrmImg>)(Object)this;
	}
	/**
	 * 图片s
	 */
	public FrmImgs()
	{
	}
	
	/**
	 * 图片s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmImgs(String fk_mapdata)
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
		return new FrmImg();
	}
}