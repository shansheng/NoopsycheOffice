package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.Entities;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/**
 * 线s
 */
public class FrmLines extends Entities
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public static ArrayList<FrmLine> convertFrmLines(Object obj)
	{
		return (ArrayList<FrmLine>) obj;
	}
	public List<FrmLine> ToJavaList()
	{
		return (List<FrmLine>)(Object)this;
	}
	// 构造
	/**
	 * 线s
	 */
	public FrmLines()
	{
	}
	
	/**
	 * 线s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmLines(String fk_mapdata)
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
		return new FrmLine();
	}
}