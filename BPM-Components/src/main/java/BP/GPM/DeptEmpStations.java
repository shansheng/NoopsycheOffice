package BP.GPM;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesMyPK;
import BP.En.Entity;

/**
 * 部门岗位人员对应
 */
public class DeptEmpStations extends EntitiesMyPK
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 构造
	/**
	 * 工作部门岗位人员对应
	 */
	public DeptEmpStations()
	{
	}
	
	@SuppressWarnings("unchecked")
	public static ArrayList<DeptEmpStation> convertDeptEmpStations(Object obj)
	{
		return (ArrayList<DeptEmpStation>) obj;
	}
	public List<DeptEmpStation> ToJavaList()
	{
		return (List<DeptEmpStation>)(Object)this;
	}
	// 方法
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new DeptEmpStation();
	}
}