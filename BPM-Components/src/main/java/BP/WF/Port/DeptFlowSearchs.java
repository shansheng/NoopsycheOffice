package BP.WF.Port;

import BP.DA.*;
import BP.En.*;
import BP.WF.*;

/** 
 流程部门数据查询权限 
*/
public class DeptFlowSearchs extends Entities
{
		///#region 构造
	/** 
	 流程部门数据查询权限
	*/
	public DeptFlowSearchs()
	{
	}
	/** 
	 流程部门数据查询权限
	 
	 @param FK_Emp FK_Emp
	*/
	public DeptFlowSearchs(String FK_Emp)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(DeptFlowSearchAttr.FK_Emp, FK_Emp);
		qo.DoQuery();
	}
		///#endregion

		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new DeptFlowSearch();
	}
		///#endregion

		///#region 查询方法
		///#endregion
}