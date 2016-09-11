package BP.WF;

public enum ShortMessageWriteTo
{
	/** 
	 写入Sys_SMS表
	*/
	ToSMSTable,
	
	/** 
	 写入WebServices.
	 WS地址: \DataUser\PortalInterface.asmx 的 WriteShortMessage
	*/
	ToWebservices,
	
	/** 
	 写入丁丁
	*/
	ToDingDing,
	
	/** 
	 写入微信.
	*/
	ToWeiXin,
	
	/** 
	 写入CCIM
	*/
	CCIM;

	public int getValue()
	{
		return this.ordinal();
	}
	
	public static ShortMessageWriteTo forValue(int value)
	{
		return values()[value];
	}
}

