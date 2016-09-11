package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.WF.*;

/** 
 单据类型
*/
public class BillTypes extends SimpleNoNames
{
	/** 
	 单据类型s
	*/
	public BillTypes()
	{
	}
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new BillType();
	}

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<BillType> ToJavaList()
	{
		return (List<BillType>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<BillType> Tolist()
	{
		ArrayList<BillType> list = new ArrayList<BillType>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((BillType)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}