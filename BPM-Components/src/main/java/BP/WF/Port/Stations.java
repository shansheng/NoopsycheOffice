package BP.WF.Port;

import java.util.List;

import BP.DA.*;
import BP.En.*;
import BP.WF.*;

 /** 
  岗位s
 */
public class Stations extends EntitiesNoName
{
	/** 
	 岗位
	*/
	public Stations()
	{
	}
	/** 
	 得到它的 Entity
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Station();
	}
	public List<Station> ToJavaList() {
		return (List<Station>)(Object)this;
	}
}