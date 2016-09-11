package BP.WF.Data;

import java.util.*;
import BP.DA.*;
import BP.WF.*;
import BP.Port.*;
import BP.Sys.*;
import BP.En.*;

/** 
 我参与的流程s
*/
public class MyFlows extends Entities
{
		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new MyFlow();
	}
	/** 
	 我参与的流程集合
	*/
	public MyFlows()
	{
	}
		///#endregion

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<MyFlow> ToJavaList()
	{
		return (List<MyFlow>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<MyFlow> Tolist()
	{
		ArrayList<MyFlow> list = new ArrayList<MyFlow>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((MyFlow)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}