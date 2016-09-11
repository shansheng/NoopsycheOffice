package BP.WF.Port;

import java.util.List;

import BP.DA.*;
import BP.En.*;
import BP.WF.*;
import BP.Port.*;
import BP.Web.*;
import BP.XML.XmlEn;

/** 
 操作员s 
*/
public class WFEmps extends EntitiesNoName
{
		///#region 构造
	/** 
	 操作员s
	*/
	public WFEmps()
	{
	}
	/** 
	 得到它的 Entity
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new WFEmp();
	}

	@Override
	public int RetrieveAll()
	{
		return super.RetrieveAll("FK_Dept","Idx");
	}
	public List<WFEmp> ToJavaList()
	{
		return (List<WFEmp>)(Object)this;
	}
}