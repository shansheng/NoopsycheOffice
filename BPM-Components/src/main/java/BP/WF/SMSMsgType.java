package BP.WF;

import java.util.*;
import BP.DA.*;
import BP.En.*;
import BP.Web.*;
import BP.Sys.*;
import BP.WF.Port.*;

/** 
 消息类型
*/
public class SMSMsgType
{
	/** 
	 自定义消息
	*/
	public static final String Self = "Self";
	/** 
	 抄送消息
	*/
	public static final String CC = "CC";
	/** 
	 待办消息
	*/
	public static final String ToDo = "ToDo";
	/** 
	 其他
	*/
	public static final String Etc = "Etc";
	/** 
	 退回消息
	*/
	public static final String ReturnWork = "ReturnWork";
	/** 
	 移交消息
	*/
	public static final String Shift = "Shift";
	/** 
	 加签消息
	*/
	public static final String AskFor = "AskFor";
	/** 
	 挂起消息
	*/
	public static final String HungUp = "HangUp";
	/** 
	 催办消息
	*/
	public static final String DoPress = "DoPress";
	/** 
	 错误信息
	*/
	public static final String Err = "Err";
}