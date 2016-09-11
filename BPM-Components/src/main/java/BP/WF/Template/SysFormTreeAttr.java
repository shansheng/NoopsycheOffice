package BP.WF.Template;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.Port.*;
import BP.Sys.*;
import BP.WF.*;

/** 
 属性
*/
public class SysFormTreeAttr extends EntityTreeAttr
{
	/** 
	 数据源
	*/
	public static final String DBSrc = "DBSrc";
	/** 
	 是否是目录
	*/
	public static final String IsDir = "IsDir";
	/** 
	 是否包含子表单
	*/
	public static final String FK_FormSort = "FK_FormSort";
}