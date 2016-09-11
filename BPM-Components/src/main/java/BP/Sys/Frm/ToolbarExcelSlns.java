package BP.Sys.Frm;

import BP.En.EntitiesMyPK;
import BP.En.Entity;

public class ToolbarExcelSlns extends EntitiesMyPK
{
	/**
	 * 功能控制
	 * 
	 * @return
	 */
	public ToolbarExcelSlns()
	{
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new ToolbarExcelSln();
	}
}