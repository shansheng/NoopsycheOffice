package BP.WF.Template;

import BP.WF.*;

/** 
 流程发起导航方式
*/
public enum StartGuideWay
{
	/** 
	 无
	*/
	None(0),
	/** 
	 SQL单条模式
	*/
	BySQLOne(1),
	/** 
	 按系统的URL-(子父流程)多条模式
	*/
	BySystemUrlMulti(2),
	/** 
	 按系统的URL-(实体记录)单条模式
	*/
	BySystemUrlOneEntity(3),
	/** 
	 按系统的URL-(实体记录)多条模式
	*/
	BySystemUrlMultiEntity(4),
	/** 
	 历史数据
	*/
	ByHistoryUrl(5),
	/** 
	 按自定义的Url
	*/
	BySelfUrl(10),
	/** 
	 按照用户选择的表单.
	*/
	ByFrms(11);

	private int intValue;
	private static java.util.HashMap<Integer, StartGuideWay> mappings;
	private static java.util.HashMap<Integer, StartGuideWay> getMappings()
	{
		if (mappings == null)
		{
			synchronized (StartGuideWay.class)
			{
				if (mappings == null)
				{
					mappings = new java.util.HashMap<Integer, StartGuideWay>();
				}
			}
		}
		return mappings;
	}

	private StartGuideWay(int value)
	{
		intValue = value;
		getMappings().put(value, this);
	}

	public int getValue()
	{
		return intValue;
	}

	public static StartGuideWay forValue(int value)
	{
		StartGuideWay sgw = getMappings().get(value);
		return sgw != null ? sgw : StartGuideWay.ByFrms;
	}
}