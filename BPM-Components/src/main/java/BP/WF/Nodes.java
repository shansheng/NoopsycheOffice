package BP.WF;

import java.util.*;
import BP.DA.*;
import BP.Sys.*;
import BP.En.*;
import BP.Port.*;
import BP.WF.Data.*;
import BP.WF.Template.*;
import BP.WF.Port.*;

/** 
 节点集合
*/
public class Nodes extends EntitiesOID
{
		///#region 方法
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Node();
	}
		///#endregion

		///#region 构造方法
	/** 
	 节点集合
	*/
	public Nodes()
	{
	}
	/** 
	 节点集合.
	 
	 @param FlowNo
	*/
	public Nodes(String fk_flow)
	{
		// Nodes nds = new Nodes();
		this.Retrieve(NodeAttr.FK_Flow, fk_flow, NodeAttr.Step);
		// this.AddEntities(NodesCash.GetNodes(fk_flow));
		return;
	}
		///#endregion

		///#region 查询方法
	/** 
	 RetrieveAll
	 
	 @return 
	*/
	@Override
	public int RetrieveAll()
	{
		Object tempVar = Cash.GetObj(this.toString(), Depositary.Application);
		Nodes nds = (Nodes)((tempVar instanceof Nodes) ? tempVar : null);
		if (nds == null)
		{
			nds = new Nodes();
			QueryObject qo = new QueryObject(nds);
			qo.AddWhereInSQL(NodeAttr.NodeID, " SELECT Node FROM WF_Direction ");
			qo.addOr();
			qo.AddWhereInSQL(NodeAttr.NodeID, " SELECT ToNode FROM WF_Direction ");
			qo.DoQuery();

			Cash.AddObj(this.toString(), Depositary.Application, nds);
			Cash.AddObj(this.getGetNewEntity().toString(), Depositary.Application, nds);
		}

		this.clear();
		this.AddEntities(nds);
		return this.size();
	}
	/** 
	 开始节点
	*/
	public final void RetrieveStartNode()
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(NodeAttr.NodePosType, NodePosType.Start.getValue());
		qo.addAnd();
		qo.AddWhereInSQL(NodeAttr.NodeID, "SELECT FK_Node FROM WF_NodeStation WHERE FK_STATION IN (SELECT FK_STATION FROM Port_EmpSTATION WHERE FK_Emp='" + BP.Web.WebUser.getNo() + "')");

		qo.addOrderBy(NodeAttr.FK_Flow);
		qo.DoQuery();
	}
		///#endregion

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<Node> ToJavaList()
	{
		return (List<Node>)(Object)this;
	}
	/** 
	 转化成list 为了翻译成java的需要
	 
	 @return List
	*/
	public final ArrayList<BP.WF.Node> Tolist()
	{
		ArrayList<BP.WF.Node> list = new ArrayList<BP.WF.Node>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((BP.WF.Node)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.

}