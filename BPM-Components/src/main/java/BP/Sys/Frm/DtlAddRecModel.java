package BP.Sys.Frm;

/**
 * 从表显示方式
 */
public enum DtlAddRecModel
{
	/** 
	 自动初始化空白行
	 
	*/
	ByBlank,
	/** 
	 用按钮增加行
	 
	*/
	ByButton;

	public int getValue()
	{
		return this.ordinal();
	}

	public static DtlAddRecModel forValue(int value)
	{
		return values()[value];
	}
}