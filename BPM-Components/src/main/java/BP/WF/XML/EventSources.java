package BP.WF.XML;

import java.util.List;

import BP.En.Entities;
import BP.Sys.SystemConfig;
import BP.XML.XmlEn;
import BP.XML.XmlEns;

/** 
 事件源s
*/
public class EventSources extends XmlEns
{
		///#region 构造
	/** 
	 事件源s
	*/
	public EventSources()
	{
	}
		///#endregion

		///#region 重写基类属性或方法。
	/** 
	 得到它的 Entity 
	*/
	@Override
	public XmlEn getGetNewEntity()
	{
		return new EventSource();
	}
	@Override
	public String getFile()
	{
		return SystemConfig.getPathOfXML() + "EventList.xml";
	}
	/** 
	 物理表名
	*/
	@Override
	public String getTableName()
	{
		return "Source";
	}
	@Override
	public Entities getRefEns()
	{
		return null;
	}
	public List<EventSource> ToJavaList()
	{
		return (List<EventSource>)(Object)this;
	}
}