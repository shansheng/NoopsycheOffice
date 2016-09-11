package BP.Sys;

import BP.En.EntityNoNameAttr;

/**
 * 用户自定义表
 */
public enum SrcType
{
	/** 
	 本地表或者视图
	 
	*/
	TableOrView,
	/** 
	 通过一个SQL确定的一个外部数据源
	 
	*/
	SQL,
	/** 
	 通过WebServices获得的一个数据源
	 
	*/
	WebServices;

	public int getValue()
	{
		return this.ordinal();
	}

	public static SrcType forValue(int value)
	{
		return values()[value];
	}
}