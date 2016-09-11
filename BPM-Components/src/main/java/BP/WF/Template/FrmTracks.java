package BP.WF.Template;

import java.util.List;

import BP.En.Entities;
import BP.En.Entity;
import BP.Sys.SystemConfig;

/** 
 轨迹图标组件s
 
*/
public class FrmTracks extends Entities
{
	//#region 构造
	/** 
	 轨迹图标组件s
	 
	*/
	public FrmTracks()
	{
	}
	/** 
	 轨迹图标组件s
	 
	 @param fk_mapdata s
	*/
	public FrmTracks(String fk_mapdata)
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
		return new FrmTrack();
	}

	/** 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<FrmTrack> ToJavaList()
	{
		return (List<FrmTrack>)(Object)this;
	}

	/** 
	 转化成list
	 
	 @return List
	*/
	public final java.util.ArrayList<FrmTrack> Tolist()
	{
		java.util.ArrayList<FrmTrack> list = new java.util.ArrayList<FrmTrack>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((FrmTrack)this.get(i));
		}
		return list;
	}
}