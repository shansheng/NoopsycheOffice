package BP.WF.MS;

import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.WF.*;

/** 
 目录s
*/
public class Sorts extends Entities
{
		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Sort();
	}
	/** 
	 目录
	*/
	public Sorts()
	{
	}
		///#endregion
}