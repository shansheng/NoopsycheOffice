package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;
import BP.GPM.Dept;
import BP.Sys.SystemConfig;

/**
 * 按钮s
 */
public class FrmBtns extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 按钮s
	 */
	public FrmBtns()
	{
	}
	
	/**
	 * 按钮s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmBtns(String fk_mapdata)
	{
		if (SystemConfig.getIsDebug())
		{
			this.Retrieve(FrmLineAttr.FK_MapData, fk_mapdata);
		} else
		{
			this.RetrieveFromCash(FrmLineAttr.FK_MapData, (Object) fk_mapdata);
		}
	}
	
	public static ArrayList<FrmBtn> convertFrmBtns(Object obj)
	{
		return (ArrayList<FrmBtn>) obj;
	}
	public List<FrmBtn> ToJavaList()
	{
		return (List<FrmBtn>)(Object)this;
	}
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmBtn();
	}
}