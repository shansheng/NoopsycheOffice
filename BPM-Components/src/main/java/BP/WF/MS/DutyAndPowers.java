package BP.WF.MS;

import BP.DA.*;
import BP.En.*;
import BP.WF.*;

/** 
 职责与权限s
*/
public class DutyAndPowers extends Entities
{
		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new DutyAndPower();
	}
	/** 
	 职责与权限
	*/
	public DutyAndPowers()
	{
	}
		///#endregion
}