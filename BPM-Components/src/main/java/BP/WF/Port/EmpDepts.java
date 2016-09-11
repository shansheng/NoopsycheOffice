package BP.WF.Port;

import BP.En.Entities;
import BP.En.Entity;
import BP.En.QueryObject;

/**
 * 操作员与工作部门
 */
public class EmpDepts extends Entities
{
	// 构造
	/**
	 * 工作人员与部门集合
	 */
	public EmpDepts()
	{
	}
	
	/**
	 * 工作人员与部门集合
	 * 
	 * @param FK_Emp
	 *            FK_Emp
	 */
	public EmpDepts(String FK_Emp)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(EmpDeptAttr.FK_Emp, FK_Emp);
		qo.DoQuery();
	}
	
	// 方法
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new EmpDept();
	}
}