package BP.Sys;

import java.util.ArrayList;
import java.util.List;

import BP.En.EntitiesNoName;
import BP.En.Entity;
import BP.En.QueryObject;
import BP.WF.Entity.ReturnWork;

/**
 * 数据源s
 */
public class SFDBSrcs extends EntitiesNoName
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//  构造
	/**
	 * 数据源s
	 */
	
	public static ArrayList<SFDBSrc> convertSFDBSrcs(Object obj)
	{
		return (ArrayList<SFDBSrc>) obj;
	}
	public List<SFDBSrc> ToJavaList()
	{
		return (List<SFDBSrc>)(Object)this;
	}
	public SFDBSrcs()
	{
	}
	
	/**
	 * 得到它的 Entity
	 */
	@Override
	public Entity getGetNewEntity()
	{
		return new SFDBSrc();
	}
	
	@Override
	public int RetrieveAll()
	{
		int i = this.RetrieveAllFromDBSource();
		if (i == 0)
		{
			SFDBSrc src = new SFDBSrc();
			src.setNo("local");
			src.setName("应用系统主数据库(默认)");
			src.Insert();
			this.AddEntity(src);
			return 1;
		}
		return i;
	}
	
	/** 查询数据源
	 
	 @return 
	 */
	public final int RetrieveDBSrc()
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(SFDBSrcAttr.DBSrcType, " < ", 100);
		return qo.DoQuery();
	}
}