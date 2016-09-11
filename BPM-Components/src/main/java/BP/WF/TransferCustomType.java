package BP.WF;

import java.util.*;
import BP.DA.*;
import BP.WF.*;
import BP.Port.*;
import BP.Sys.*;
import BP.En.*;
import BP.WF.Template.*;

/** 
 流程运行类型
*/
public enum TransferCustomType
{
	/** 
	 按照流程定义的模式执行(自动模式)
	*/
	ByCCBPMDefine,
	/** 
	 按照工作人员的设置执行(人工干涉模式)
	*/
	ByWorkerSet;

	public int getValue()
	{
		return this.ordinal();
	}

	public static TransferCustomType forValue(int value)
	{
		return values()[value];
	}
}