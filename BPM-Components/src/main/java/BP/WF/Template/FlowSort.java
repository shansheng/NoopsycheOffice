package BP.WF.Template;

import BP.DA.DBAccess;
import BP.DA.DataTable;
import BP.En.EntityTree;
import BP.En.Map;
import BP.Sys.OSModel;
import BP.Sys.SystemConfig;
import BP.WF.Flow;
import BP.WF.Flows;
import BP.WF.Glo;

/** 
  流程类别
*/
public class FlowSort extends EntityTree
{
		///#region 构造方法
	/** 
	 流程类别
	*/
	public FlowSort()
	{
	}
	/** 
	 流程类别
	 
	 @param _No
	*/
	public FlowSort(String _No)
	{
		super(_No);
	}
		///#endregion

	/** 
	 流程类别Map
	*/
	@Override
	public Map getEnMap()
	{
		if (this.get_enMap() != null)
		{
			return this.get_enMap();
		}

		Map map = new Map("WF_FlowSort", "流程类别");

		map.AddTBStringPK(FlowSortAttr.No, null, "编号", true, true, 1, 10, 20);
		map.AddTBString(FlowSortAttr.Name, null, "名称", true, false, 0, 100, 30);
		map.AddTBString(FlowSortAttr.ParentNo, null, "父节点No", false, false, 0, 100, 30);
		map.AddTBString(FlowSortAttr.TreeNo, null, "TreeNo", false, false, 0, 100, 30);

		map.AddTBInt(FlowSortAttr.Idx, 0, "Idx", false, false);
		map.AddTBInt(FlowSortAttr.IsDir, 0, "IsDir", false, false);

		this.set_enMap(map);
		return this.get_enMap();
	}

		///#region 重写方法
	public final void WritToGPM()
	{
		return;
	}

	@Override
	protected boolean beforeInsert()
	{
		this.WritToGPM();
		return super.beforeInsert();
	}

	@Override
	protected boolean beforeDelete()
	{
		try
		{
			//删除权限管理
			if (BP.WF.Glo.getOSModel() == OSModel.OneMore)
			{
				DBAccess.RunSQL("DELETE FROM GPM_Menu WHERE Flag='FlowSort" + this.getNo() + "' AND FK_App='" + SystemConfig.getSysNo() + "'");
			}
		}
		catch (java.lang.Exception e)
		{
		}
		return super.beforeDelete();
	}

	@Override
	protected boolean beforeUpdate()
	{
		//修改权限管理
		if (BP.WF.Glo.getOSModel() == OSModel.OneMore)
		{
			DBAccess.RunSQL("UPDATE  GPM_Menu SET Name='" + this.getName() + "' WHERE Flag='FlowSort" + this.getNo() + "' AND FK_App='" + SystemConfig.getSysNo() + "'");
		}
		return super.beforeUpdate();
	}
		///#endregion 重写方法

		///#region 扩展方法
	/** 
	 子文件夹
	*/
	public final FlowSorts getHisSubFlowSorts()
	{
		try
		{
			FlowSorts flowSorts = new FlowSorts();
			flowSorts.RetrieveByAttr(FlowSortAttr.ParentNo, this.getNo());
			return flowSorts;
		}
		catch (java.lang.Exception e)
		{
		}
		return null;
	}

	/** 
	 类别下所包含流程
	*/
	public final Flows getHisFlows()
	{
		try
		{
			Flows flows = new Flows();
			flows.RetrieveByAttr(FlowAttr.FK_FlowSort, this.getNo());
			return flows;
		}
		catch (java.lang.Exception e)
		{
		}
		return null;
	}
	/** 
	 强制删除该流程类别下子项，递归
	 
	 @return 
	*/
	public final boolean DeleteFlowSortSubNode_Force()
	{
		try
		{
			//删除流程
			for (Flow flow : this.getHisFlows().ToJavaList())
			{
				flow.DoDelete();
			}
			//删除类别
			for (FlowSort flowSort : this.getHisSubFlowSorts().ToJavaListFs())
			{
				Delete_FlowSort_SubNodes(flowSort);
			}

			return true;
		}
		catch (RuntimeException ex)
		{
			throw new RuntimeException(ex.getMessage());
		}
	}

	/** 
	 删除类别下所有项，子流程类别、流程
	 
	 @param FK_FlowSort 流程类别编号
	 @return true false
	*/
	private boolean Delete_FlowSort_SubNodes(FlowSort sub_FlowSort)
	{
		try
		{
			//删除流程
			for (Flow flow : sub_FlowSort.getHisFlows().ToJavaList())
			{
				flow.DoDelete();
			}
			//删除类别
			for (FlowSort flowSort : sub_FlowSort.getHisSubFlowSorts().ToJavaListFs())
			{
				Delete_FlowSort_SubNodes(flowSort);
			}

			sub_FlowSort.Delete();
			return true;
		}
		catch (RuntimeException ex)
		{
			throw new RuntimeException(ex.getMessage());
		}
	}
		///#endregion
}