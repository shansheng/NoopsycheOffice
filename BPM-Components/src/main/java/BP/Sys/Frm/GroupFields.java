package BP.Sys.Frm;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesOID;
import BP.En.Entity;
import BP.En.QueryObject;

/**
 * GroupFields
 */
public class GroupFields extends EntitiesOID
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public static ArrayList<GroupField> convertGroupFields(Object obj)
	{
		return (ArrayList<GroupField>) obj;
	}
	public List<GroupField> ToJavaList()
	{
		return (List<GroupField>)(Object)this;
	}
	//  构造
	/**
	 * GroupFields
	 */
	public GroupFields()
	{
	}
	
	/**
	 * GroupFields
	 * 
	 * @param EnName
	 *            s
	 */
	public GroupFields(String EnName)
	{
		int i = this
				.Retrieve(GroupFieldAttr.EnName, EnName, GroupFieldAttr.Idx);
		if (i == 0)
		{
			GroupField gf = new GroupField();
			gf.setEnName(EnName);
			MapData md = new MapData();
			md.setNo(EnName);
			if (md.RetrieveFromDBSources() == 0)
			{
				gf.setLab("基础信息");
			} else
			{
				gf.setLab(md.getName());
			}
			gf.setIdx(0);
			gf.Insert();
			this.AddEntity(gf);
		}
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new GroupField();
	}
	
	/** 
	 查询
	 
	 @param enName
	 @return 
	*/
	public final int RetrieveFieldGroup(String enName)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(GroupFieldAttr.EnName, enName);
		qo.addAnd();
		qo.AddWhereIsNull(GroupFieldAttr.CtrlID);
		//qo.AddWhereLen(GroupFieldAttr.CtrlID, " = ", 0, SystemConfig.AppCenterDBType);
		int num = qo.DoQuery();

		if (num == 0)
		{
			GroupField gf = new GroupField();
			gf.setEnName(enName);
			MapData md = new MapData();
			md.setNo(enName);
			if (md.RetrieveFromDBSources() == 0)
			{
				gf.setLab("基础信息");
			}
			else
			{
				gf.setLab(md.getName());
			}
			gf.setIdx(0);
			gf.Insert();
			this.AddEntity(gf);
			return 1;
		}
		return num;
	}

}