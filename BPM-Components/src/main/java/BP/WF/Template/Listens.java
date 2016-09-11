package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.WF.*;

/** 
 消息收听
*/
public class Listens extends EntitiesOID
{
		///#region 构造.
	/** 
	 消息收听
	*/
	public Listens()
	{
	}
	/** 
	 消息收听
	 
	 @param fk_flow
	*/
	public Listens(String fk_flow)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhereInSQL(ListenAttr.FK_Node, "SELECT NodeID FROM WF_Node WHERE FK_Flow='" + fk_flow + "'");
		qo.DoQuery();
	}
	/** 
	 消息收听
	 
	 @param nodeID
	*/
	public Listens(int nodeID)
	{
		QueryObject qo = new QueryObject(this);
		qo.AddWhere(ListenAttr.FK_Node, nodeID);
		qo.DoQuery();
	}
	/** 
	 得到它的 Entity 
	*/
	@Override
	public Entity getGetNewEntity()
	{
		return new Listen();
	}
		///#endregion 构造.

		///#region 为了适应自动翻译成java的需要,把实体转换成List.
	/** 
	 转化成 java list,C#不能调用.
	 
	 @return List
	*/
	public final List<Listen> ToJavaList()
	{
		return (List<Listen>)(Object)this;
	}
	/** 
	 转化成list
	 
	 @return List
	*/
	public final ArrayList<Listen> Tolist()
	{
		ArrayList<Listen> list = new ArrayList<Listen>();
		for (int i = 0; i < this.size(); i++)
		{
			list.add((Listen)this.get(i));
		}
		return list;
	}
		///#endregion 为了适应自动翻译成java的需要,把实体转换成List.
}