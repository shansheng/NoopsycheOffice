package BP.WF.Data;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.Web.*;
import BP.Sys.*;
import BP.WF.*;

/** 
 完成状态
*/
public enum CHSta
{
	/** 
	 及时完成
	*/
	
	JiShi,
	
	/** 
	 按期完成
	*/
	AnQi,
	
	/** 
	 预期完成
	*/
	YuQi,
	/** 
	 超期完成
	*/
	ChaoQi;

	public int getValue()
	{
		return this.ordinal();
	}

	public static CHSta forValue(int value)
	{
		return values()[value];
	}
}