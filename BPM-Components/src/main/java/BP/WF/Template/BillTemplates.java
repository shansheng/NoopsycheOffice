package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.WF.*;

/** 
 单据模板s
*/
public class BillTemplates extends EntitiesNoName
{
		///#region 构造
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new BillTemplate();
	}
	/** 
	 单据模板
	*/
	public BillTemplates()
	{
	}
		///#endregion

		///#region 查询与构造
	/** 
	 按节点查询
	 
	 @param nd
	*/
	public BillTemplates(Node nd)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(BillTemplateAttr.NodeID, nd.getNodeID());
		if (nd.getIsStartNode())
		{
			qo.addOr();
			qo.AddWhere("No", "SLHZ");
		}
		qo.DoQuery();
	}
	/** 
	 按流程查询
	 
	 @param fk_flow 流程编号
	*/
	public BillTemplates(String fk_flow)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhereInSQL(BillTemplateAttr.NodeID, "SELECT NodeID FROM WF_Node WHERE fk_flow='" + fk_flow + "'");
		qo.DoQuery();
	}
	/** 
	 按节点查询
	 
	 @param fk_node 节点ID
	*/
	public BillTemplates(int fk_node)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(BillTemplateAttr.NodeID, fk_node);
		qo.DoQuery();
	}
		///#endregion 查询与构造

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<BillTemplate> ToJavaList()
	{
		return (List<BillTemplate>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<BillTemplate> Tolist()
	{
		ArrayList<BillTemplate> list = new ArrayList<BillTemplate>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((BillTemplate)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}