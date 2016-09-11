package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 单选框s
 */
public class FrmRBs extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 单选框s
	 */
	public FrmRBs()
	{
	}
	
	public static ArrayList<FrmRB> convertFrmRBs(Object obj)
	{
		return (ArrayList<FrmRB>) obj;
	}
	public List<FrmRB> ToJavaList()
	{
		return (List<FrmRB>)(Object)this;
	}
	/**
	 * 单选框s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmRBs(String fk_mapdata)
	{
		if (SystemConfig.getIsDebug())
		{
			this.Retrieve(FrmLineAttr.FK_MapData, fk_mapdata);
		} else
		{
			this.RetrieveFromCash(FrmLineAttr.FK_MapData, (Object) fk_mapdata);
		}
	}

	public FrmRBs(String fk_mapdata, String keyOfEn) {
		this.Retrieve(FrmRBAttr.FK_MapData, fk_mapdata,FrmRBAttr.KeyOfEn,keyOfEn);
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmRB();
	}
}