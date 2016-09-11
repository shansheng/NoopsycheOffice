package BP.WF.Template;

import BP.DA.DataType;
import BP.En.Entity;
import BP.En.Map;
import BP.En.UAC;

/** 
 流转自定义组件
 
*/
public class FrmTransferCustom extends Entity
{
	//#region 属性
	public final String getNo()
	{
		return "ND" + this.getNodeID();
	}
	public final void setNo(String value)
	{
		String nodeID = value.replace("ND", "");
		this.setNodeID(Integer.parseInt(nodeID));
	}
	/** 
	 节点ID
	 
	*/
	public final int getNodeID()
	{
		return this.GetValIntByKey(NodeAttr.NodeID);
	}
	public final void setNodeID(int value)
	{
		this.SetValByKey(NodeAttr.NodeID, value);
	}
	/** 
	 控件状态
	*/
	public final FrmTransferCustomSta getFrmTransferCustomSta()
	{
		return FrmTransferCustomSta.forValue((this.GetValIntByKey(FrmTransferCustomAttr.FrmTransferCustomSta)));
	}
	public final void setFrmTransferCustomSta(FrmTransferCustomSta value)
	{
		this.SetValByKey(FrmTransferCustomAttr.FrmTransferCustomSta, value.getValue());
	}
	/** 
	 Y
	*/
	public final float getFrmTransferCustom_Y()
	{
		return this.GetValFloatByKey(FrmTransferCustomAttr.FrmTransferCustom_Y);
	}
	public final void setFrmTransferCustom_Y(float value)
	{
		this.SetValByKey(FrmTransferCustomAttr.FrmTransferCustom_Y, value);
	}
	/** 
	 X
	*/
	public final float getFrmTransferCustom_X()
	{
		return this.GetValFloatByKey(FrmTransferCustomAttr.FrmTransferCustom_X);
	}
	public final void setFrmTransferCustom_X(float value)
	{
		this.SetValByKey(FrmTransferCustomAttr.FrmTransferCustom_X, value);
	}
	/** 
	 W
	*/
	public final float getFrmTransferCustom_W()
	{
		return this.GetValFloatByKey(FrmTransferCustomAttr.FrmTransferCustom_W);
	}
	public final void setFrmTransferCustom_W(float value)
	{
		this.SetValByKey(FrmTransferCustomAttr.FrmTransferCustom_W, value);
	}
	public final String getFrmTransferCustom_Wstr()
	{
		if (this.getFrmTransferCustom_W() == 0)
		{
			return "100%";
		}
		return this.getFrmTransferCustom_W() + "px";
	}
	/** 
	 H
	*/
	public final float getFrmTransferCustom_H()
	{
		return this.GetValFloatByKey(FrmTransferCustomAttr.FrmTransferCustom_H);
	}
	public final void setFrmTransferCustom_H(float value)
	{
		this.SetValByKey(FrmTransferCustomAttr.FrmTransferCustom_H, value);
	}
	public final String getFrmTransferCustom_Hstr()
	{
		if (this.getFrmTransferCustom_H() == 0)
		{
			return "100%";
		}
		return this.getFrmTransferCustom_H() + "px";
	}
	/** 
	 节点名称.
	*/
	public final String getName()
	{
		return this.GetValStringByKey("Name");
	}
	/** 
	 显示标签
	*/
	public final String getFrmTransferCustomLab()
	{
		return this.GetValStrByKey(FrmTransferCustomAttr.FrmTransferCustomLab);
	}

	/** 
	 控制
	 
	*/
	@Override
	public UAC getHisUAC()
	{
		UAC uac = new UAC();
		uac.OpenForSysAdmin();
		uac.IsDelete = false;
		uac.IsInsert = false;
		return uac;
	}
	/** 
	 重写主键
	 
	*/
	@Override
	public String getPK()
	{
		return "NodeID";
	}
	/** 
	 流转自定义组件
	 
	*/
	public FrmTransferCustom()
	{
	}
	/** 
	 流转自定义组件
	 
	 @param no
	*/
	public FrmTransferCustom(String mapData)
	{
		if (mapData.contains("ND") == false)
		{
			this.setFrmTransferCustomSta(FrmTransferCustomSta.Disable);
			return;
		}

		String mapdata = mapData.replace("ND", "");
		if (DataType.IsNumStr(mapdata) == false)
		{
			this.setFrmTransferCustomSta(FrmTransferCustomSta.Disable);
			return;
		}

		try
		{
			this.setNodeID(Integer.parseInt(mapdata));
		}
		catch (java.lang.Exception e)
		{
			return;
		}
		this.Retrieve();
	}
	/** 
	 流转自定义组件
	 
	 @param no
	*/
	public FrmTransferCustom(int nodeID)
	{
		this.setNodeID(nodeID);
		this.Retrieve();
	}
	/** 
	 EnMap
	 
	*/
	@Override
	public Map getEnMap()
	{
		if (this.get_enMap() != null)
		{
			return this.get_enMap();
		}

		Map map = new Map("WF_Node", "流转自定义组件");

		map.AddTBIntPK(NodeAttr.NodeID, 0, "节点ID", true, true);
		map.AddTBString(NodeAttr.Name, null, "节点名称", true, true, 0, 100, 10);
		map.AddTBString(FrmTransferCustomAttr.FrmTransferCustomLab, "流转自定义", "显示标签", true, false, 0, 200, 10, true);


		//#region 此处变更了 NodeSheet类中的，map 描述该部分也要变更.

		map.AddDDLSysEnum(FrmTransferCustomAttr.FrmTransferCustomSta, getFrmTransferCustomSta().Disable.getValue(), "组件状态", true, true, FrmTransferCustomAttr.FrmTransferCustomSta, "@0=禁用@1=只读@2=可设置人员");

		map.AddTBFloat(FrmTransferCustomAttr.FrmTransferCustom_X, 5, "位置X", false, false);
		map.AddTBFloat(FrmTransferCustomAttr.FrmTransferCustom_Y, 5, "位置Y", false, false);

		map.AddTBFloat(FrmTransferCustomAttr.FrmTransferCustom_H, 300, "高度", true, false);
		map.AddTBFloat(FrmTransferCustomAttr.FrmTransferCustom_W, 400, "宽度", true, false);

		//#endregion 此处变更了 NodeSheet类中的，map 描述该部分也要变更.

		this.set_enMap(map);
		return this.get_enMap();
	}
}