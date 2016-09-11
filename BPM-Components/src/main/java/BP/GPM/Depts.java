package BP.GPM;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.WF.Data.Bill;

/**
 * 得到集合
 */
public class Depts extends EntitiesNoName
{
	public static ArrayList<Dept> convertDepts(Object obj)
	{
		return (ArrayList<Dept>) obj;
	}
	public List<Dept> ToJavaList()
	{
		return (List<Dept>)(Object)this;
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 得到一个新实体
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new Dept();
	}
	
	/**
	 * 部门集合
	 */
	public Depts()
	{
		
	}
	
	/**
	 * 部门集合
	 * 
	 * @param parentNo
	 *            父部门No
	 */
	public Depts(String parentNo)
	{
		this.Retrieve(DeptAttr.ParentNo, parentNo);
	}
}