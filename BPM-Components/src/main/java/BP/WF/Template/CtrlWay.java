package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.WF.*;
import BP.Port.*;

/** 
 抄送控制方式
*/
public enum CtrlWay
{
	/** 
	 按照岗位
	*/
	ByStation,
	/** 
	 按部门
	*/
	ByDept,
	/** 
	 按人员
	*/
	ByEmp,
	/** 
	 按SQL
	*/
	BySQL;

	public int getValue()
	{
		return this.ordinal();
	}

	public static CtrlWay forValue(int value)
	{
		return values()[value];
	}
}