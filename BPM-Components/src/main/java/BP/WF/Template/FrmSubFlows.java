package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.WF.Template.*;
import BP.WF.*;
import BP.Sys.*;

/** 
 父子流程s
*/
public class FrmSubFlows extends Entities
{
		///#region 构造
	/** 
	 父子流程s
	*/
	public FrmSubFlows()
	{
	}
	/** 
	 父子流程s
	 
	 @param fk_mapdata s
	*/
	public FrmSubFlows(String fk_mapdata)
	{
		if (SystemConfig.getIsDebug())
		{
			this.Retrieve("No", fk_mapdata);
		}
		else
		{
			this.RetrieveFromCash("No", (Object)fk_mapdata);
		}
	}
	/** 
	 得到它的 Entity
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new FrmSubFlow();
	}
		///#endregion

		///#region 为了适应自动翻译成java的需要,把实体转换成List /// <summary>
	/** 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<FrmSubFlow> ToJavaList()
	{
		return (List<FrmSubFlow>)(Object)this;
	}

	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<FrmSubFlow> Tolist()
	{
		ArrayList<FrmSubFlow> list = new ArrayList<FrmSubFlow>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((FrmSubFlow)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}