package BP.WF.Template;

import BP.En.Entities;
import BP.En.Entity;

/** 
节点集合
*/
public class NodeExts extends Entities
{
	/** 
	 节点集合
	*/
	public NodeExts()
	{
	}

	@Override
	public Entity getGetNewEntity()
	{
		return new NodeExt();
	}
}
