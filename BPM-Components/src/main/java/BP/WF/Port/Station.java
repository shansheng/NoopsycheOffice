package BP.WF.Port;

import BP.DA.*;
import BP.En.*;
import BP.Port.StationAttr;
import BP.WF.*;

/** 
 岗位
*/
public class Station extends EntityNoName
{
		///#region 实现基本的方方法
	/** 
	 UI界面上的访问控制
	*/
	@Override
	public UAC getHisUAC()
	{
		UAC uac = new UAC();
		uac.OpenForSysAdmin();
		return uac;
	}
	public final String getName()
	{
		return this.GetValStrByKey("Name");
	}
	public final int getGrade()
	{
		return this.getNo().length() / 2;
	}

		///#endregion

		///#region 构造方法
	/** 
	 岗位
	*/
	public Station()
	{
	}
	/** 
	 岗位
	 
	 @param _No
	*/
	public Station(String _No)
	{
		super(_No);
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

		Map map = new Map("Port_Station", "岗位");
		map.Java_SetEnType(EnType.Admin);

		map.Java_SetDepositaryOfEntity(Depositary.Application);
		map.Java_SetCodeStruct("2");
		; // 最大级别是7.

		map.AddTBStringPK(StationAttr.No, null, "编号", true, false, 2, 2, 2);
		map.AddTBString(StationAttr.Name, null, "名称", true, false, 2, 50, 300);
		//map.AddDDLSysEnum(StationAttr.StaGrade, 0, "类型", true, true,
		//		StationAttr.StaGrade, "@1=高层岗@2=中层岗@3=执行岗");
		map.AddDDLEntities(StationAttr.StaGrade, null, "岗位类型", new BP.GPM.StationTypes(), true);
		map.AddSearchAttr(StationAttr.StaGrade);
		this.set_enMap(map);
		return this.get_enMap();
	}
		///#endregion
}	