package BP.GPM;

import BP.En.Entities;
import BP.En.Entity;
import BP.En.QueryObject;

/**
 * 部门职务
 */
public class DeptDutys extends Entities
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 部门职务
	 */
	public DeptDutys()
	{
	}
	
	/**
	 * 工作人员与职务集合
	 */
	public DeptDutys(String DutyNo)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(DeptDutyAttr.FK_Duty, DutyNo);
		qo.DoQuery();
	}
	
	// 方法
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new DeptDuty();
	}
	// 查询方法
}