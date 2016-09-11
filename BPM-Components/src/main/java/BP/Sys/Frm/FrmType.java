package BP.Sys.Frm;

/**
 * 表单类型
 */
public enum FrmType
{
	
	/**
	 * 自由表单
	 */
	FreeFrm(1),
	/**
	 * 傻瓜表单
	 */
	Column4Frm(0),
	/**
	 * silverlight
	 */
	SLFrm(2),
	/**
	 * URL 表单(自定义)
	 */
	Url(3),
	/**
	 * Word类型表单
	 */
	WordFrm(4),
	/**
	 * Excel类型表单
	 */
	ExcelFrm(5),
	/** 
	 公文表单
	*/
	WebOffice(7);
	
	private int intValue;
	private static java.util.HashMap<Integer, FrmType> mappings;
	
	private synchronized static java.util.HashMap<Integer, FrmType> getMappings()
	{
		if (mappings == null)
		{
			mappings = new java.util.HashMap<Integer, FrmType>();
		}
		return mappings;
	}
	
	private FrmType(int value)
	{
		intValue = value;
		FrmType.getMappings().put(value, this);
	}
	
	public int getValue()
	{
		return intValue;
	}
	
	public static FrmType forValue(int value)
	{
		return getMappings().get(value);
	}
}