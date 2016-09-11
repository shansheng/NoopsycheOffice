package BP.WF;

import java.util.*;
import BP.Web.*;

/** 
 用户消息
*/
public class UserMsgs
{
		///#region 属性
	/** 
	 _IsOpenSound
	*/
	private boolean _IsOpenSound = false;
	/** 
	 _IsOpenSound
	*/
	public final boolean getIsOpenSound()
	{
		if (this._IsOpenSound == false)
		{
			return false;
		}
		else
		{
			this._IsOpenSound = false;
			return true;
		}
	}
		///#endregion

		///#region 构造
	/** 
	 用户消息
	*/
	public UserMsgs()
	{
	}
	/** 
	 用户消息
	 
	 @param empId
	*/
	public UserMsgs(int empId)
	{
	}
		///#endregion
}