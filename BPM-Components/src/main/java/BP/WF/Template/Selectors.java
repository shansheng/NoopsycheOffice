package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.Sys.*;
import BP.En.*;
import BP.WF.Port.*;
import BP.WF.*;

/** 
 Accpter
*/
public class Selectors extends Entities
{
	/** 
	 Accpter
	*/
	public Selectors()
	{
	}
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Selector();
	}

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<Selector> ToJavaList()
	{
		return (List<Selector>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<Selector> Tolist()
	{
		ArrayList<Selector> list = new ArrayList<Selector>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((Selector)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}