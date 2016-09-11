package BP.WF.Template;

import java.util.ArrayList;
import java.util.List;

import BP.En.Entities;
import BP.En.Entity;
import BP.Sys.SystemConfig;

public class FrmNodeComponents extends Entities{
	
	/** 
	 节点表单组件s
	*/
	public FrmNodeComponents()
	{
	}
	/** 
	 节点表单组件s
	 
	 @param fk_mapdata s
	*/
	public FrmNodeComponents(String fk_mapdata)
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
		return new FrmNodeComponent();
	}

//#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 *转化成 java list,C#不能调用.
	 @return List
	*/
	public final List<FrmNodeComponent> ToJavaList()
	{
		return (List<FrmNodeComponent>)(Object)this;
	}
	/** 
	* 转化成list
	* @return List
	*/
	public final ArrayList<FrmNodeComponent> Tolist()
	{
		ArrayList<FrmNodeComponent> list = new ArrayList<FrmNodeComponent>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((FrmNodeComponent)this.get(i));
		}
		return list;
	}

}
