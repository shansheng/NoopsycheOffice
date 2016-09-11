package BP.WF;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.Web.*;
import BP.Sys.*;
import BP.WF.Port.*;

/** 
 消息s
*/
public class SMSs extends Entities
{
	@Override
	public Entity getGetNewEntity()
	{
		return new SMS();
	}
	public SMSs()
	{
	}

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<SMS> ToJavaList()
	{
		return (List<SMS>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<SMS> Tolist()
	{
		ArrayList<SMS> list = new ArrayList<SMS>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((SMS)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}