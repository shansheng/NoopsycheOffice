package BP.WF.Data;

import java.util.*;
import BP.En.*;
import BP.Sys.*;
import BP.WF.*;

/** 
 报表集合
*/
public class FlowDatas extends BP.En.EntitiesOID
{
	/** 
	 报表集合
	*/
	public FlowDatas()
	{
	}

	@Override
	public Entity getGetNewEntity()
	{
		return new FlowData();
	}
		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<FlowData> ToJavaList()
	{
		return (List<FlowData>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<FlowData> Tolist()
	{
		ArrayList<FlowData> list = new ArrayList<FlowData>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((FlowData)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}