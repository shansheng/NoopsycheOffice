package BP.WF.MS;

import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.WF.*;

/** 
 制度s
*/
public class ZhiDus extends Entities
{
		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new ZhiDu();
	}
	/** 
	 制度
	*/
	public ZhiDus()
	{
	}
		///#endregion
}