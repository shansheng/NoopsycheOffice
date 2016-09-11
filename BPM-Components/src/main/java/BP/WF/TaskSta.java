package BP.WF;

import java.util.*;
import BP.DA.*;
import BP.WF.*;
import BP.Port.*;
import BP.Sys.*;
import BP.En.*;
import BP.WF.Template.*;

/** 
 任务状态
*/
public enum TaskSta
{
	/** 
	 无
	*/
	None,
	/** 
	 共享
	*/
	Sharing,
	/** 
	 已经取走
	*/
	Takeback;

	public int getValue()
	{
		return this.ordinal();
	}

	public static TaskSta forValue(int value)
	{
		return values()[value];
	}
}