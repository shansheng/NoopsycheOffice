package BP.Sys;

import BP.DA.*;
import BP.En.*;
import BP.WF.Template.*;
import BP.WF.*;

/** 
 审核组件s
 
*/
public class FrmWorkChecks extends Entities
{
		///#region 构造.
	/** 
	 审核组件s
	 
	*/
	public FrmWorkChecks()
	{
	}
	/** 
	 审核组件s
	 
	 @param fk_mapdata s
	*/
	public FrmWorkChecks(String fk_mapdata)
	{
		if (SystemConfig.getIsDebug())
		{
			this.Retrieve("No", fk_mapdata);
		}
		else
		{
			this.RetrieveFromCash("No", (Object)fk_mapdata);
		}
	}
	/** 
	 得到它的 Entity
	 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmWorkCheck();
	}
		///#endregion
}