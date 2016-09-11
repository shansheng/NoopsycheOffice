package BP.GPM;

import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;

/**
 * 部门人员信息
 */
public class DeptEmps extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 工作部门人员信息
	 */
	public DeptEmps()
	{
	}
	
	// 方法
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new DeptEmp();
	}
	public List<DeptEmp> ToJavaList()
	{
		return (List<DeptEmp>)(Object)this;
	}
}