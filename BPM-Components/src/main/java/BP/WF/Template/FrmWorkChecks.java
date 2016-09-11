package BP.WF.Template;

import java.util.ArrayList;
import java.util.List;

import BP.En.Entities;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/** 
 审核组件s
*/
public class FrmWorkChecks extends Entities
{
		///#region 构造
	/** 
	 审核组件s
	*/
	public FrmWorkChecks()
	{
	}
	/** 
	 审核组件s
	 
	 @param fk_mapdata s
	*/
	public FrmWorkChecks(String fk_mapdata)
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
		return new FrmWorkCheck();
	}

	//#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<FrmWorkCheck> ToJavaList()
	{
		return (List<FrmWorkCheck>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<FrmWorkCheck> Tolist()
	{
		ArrayList<FrmWorkCheck> list = new ArrayList<FrmWorkCheck>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((FrmWorkCheck)this.get(i));
		}
		return list;
	}
	//#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}