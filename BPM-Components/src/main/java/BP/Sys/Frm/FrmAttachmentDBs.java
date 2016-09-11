package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;

/**
 * 附件数据存储s
 */
public class FrmAttachmentDBs extends EntitiesMyPK
{
	public static ArrayList<FrmAttachmentDB> convertFrmAttachmentDBs(Object obj)
	{
		return (ArrayList<FrmAttachmentDB>) obj;
	}
	public List<FrmAttachmentDB> ToJavaList()
	{
		return (List<FrmAttachmentDB>)(Object)this;
	}
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//  构造
	/**
	 * 附件数据存储s
	 */
	public FrmAttachmentDBs()
	{
	}
	
	/**
	 * 附件数据存储s
	 * 
	 * @param fk_mapdata
	 *            s
	 */
	public FrmAttachmentDBs(String fk_mapdata, String pkval)
	{
		this.Retrieve(FrmAttachmentDBAttr.FK_MapData, fk_mapdata,
				FrmAttachmentDBAttr.RefPKVal, pkval);
	}
	
	public FrmAttachmentDBs(String fk_mapdata, long pkval)
	{
		this.Retrieve(FrmAttachmentDBAttr.FK_MapData, fk_mapdata,
				FrmAttachmentDBAttr.RefPKVal, pkval);
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmAttachmentDB();
	}
}