package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 图片附件s
 */
public class FrmImgAths extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	
	public static ArrayList<FrmImgAth> convertFrmImgAths(Object obj)
	{
		return (ArrayList<FrmImgAth>) obj;
	}
	public List<FrmImgAth> ToJavaList()
	{
		return (List<FrmImgAth>)(Object)this;
	}
	/**
	 * 图片附件s
	 */
	public FrmImgAths()
	{
	}
	
	/**
	 * 图片附件s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmImgAths(String fk_mapdata)
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
		return new FrmImgAth();
	}
}