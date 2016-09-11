package BP.Sys;

import BP.DA.*;
import BP.En.*;
import BP.WF.Template.*;
import BP.WF.*;

/** 
 父子流程s
 
*/
public class FrmSubFlows extends Entities
{
		///#region 构造
	/** 
	 父子流程s
	 
	*/
	public FrmSubFlows()
	{
	}
	/** 
	 父子流程s
	 
	 @param fk_mapdata s
	*/
	public FrmSubFlows(String fk_mapdata)
	{
		if ( SystemConfig.getIsDebug())
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
		return new FrmSubFlow();
	}
		///#endregion
}