package BP.WF.Port;

import java.util.List;

import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.WF.*;

/** 
 工作人员
*/
public class Emps extends EntitiesNoName
{
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Emp();
	}
	/** 
	 工作人员s
	*/
	public Emps()
	{
	}
	/** 
	 查询全部
	 
	 @return 
	*/
	@Override
	public int RetrieveAll()
	{
	   return super.RetrieveAll();

		//QueryObject qo = new QueryObject(this);
		//qo.AddWhere(EmpAttr.FK_Dept, " like ", BP.Web.WebUser.getFK_Dept() + "%");
		//qo.addOrderBy(EmpAttr.No);
		//return qo.DoQuery();
	}
	public final List<Emp> ToJavaList()
	{
		return (List<Emp>)(Object)this;
	}
}