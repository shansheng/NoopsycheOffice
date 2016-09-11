package BP.WF.Template;

import BP.DA.DBAccess;
import BP.DA.DataTable;
import BP.En.Attr;
import BP.En.EnType;
import BP.En.Entity;
import BP.En.Map;
import BP.En.UAC;
import BP.Port.DeptAttr;
import BP.Tools.StringHelper;

/** 
 抄送
*/
public class CC extends Entity{
	///#region 属性
	/** 
	  抄送 
	 @param rpt
	 @return 
	*/
	public final DataTable GenerCCers(Entity rpt){
		String sql = "";
		if (this.getCCIsSQLs() == true){
			sql = "\t\n UNION    \t\n   ";
			Object tempVar = this.getCCSQL();
			sql += (String)((tempVar instanceof String) ? tempVar : null);
			sql = sql.replace("@WebUser.getNo()", BP.Web.WebUser.getNo());
			sql = sql.replace("@WebUser.getName()", BP.Web.WebUser.getName());
			sql = sql.replace("@WebUser.FK_Dept", BP.Web.WebUser.getFK_Dept());
			if (sql.contains("@")){
				for (Attr attr : rpt.getEnMap().getAttrs()){
					if (sql.contains("@") == false){
						break;
					}
					sql = sql.replace("@" + attr.getKey(), rpt.GetValStrByKey(attr.getKey()));
				}
			}
		}
		if (this.getCCIsEmps() == true){
			sql += "\t\n UNION \t\n      SELECT No,Name FROM Port_Emp WHERE No IN (SELECT FK_Emp FROM WF_CCEmp WHERE FK_Node=" + this.getNodeID() + ")";
		}

		if (this.getCCIsDepts() == true){
			sql += "\t\n UNION \t\n      SELECT No,Name FROM Port_Emp WHERE No IN (SELECT FK_Emp FROM Port_EmpDept WHERE FK_Dept IN ( SELECT FK_Dept FROM WF_CCDept WHERE FK_Node=" + this.getNodeID() + "))";
		}

		if (this.getCCIsStations() == true){
			sql += "\t\n UNION \t\n      SELECT No,Name FROM Port_Emp WHERE No IN (SELECT FK_Emp FROM " + BP.WF.Glo.getEmpStation() + " WHERE FK_Station IN ( SELECT FK_Station FROM WF_CCStation WHERE FK_Node=" + this.getNodeID() + "))";
		}

		if (sql.length() > 20){
			sql = sql.substring("\t\n UNION  \t\n  ".length());
		}

		DataTable dt = DBAccess.RunSQLReturnTable(sql);
		if (dt.Rows.size() == 0){
			BP.DA.Log.DebugWriteWarning("@流程节点设计错误，未找到抄送人员，NodeID=[" + this.getNodeID() + "]。 SQL:" + sql);
			return dt;
		}
		return dt;
	}
	
	/** 
	节点ID
	*/
	public final int getNodeID(){
		return this.GetValIntByKey(NodeAttr.NodeID);
	}
	public final void setNodeID(int value){
		this.SetValByKey(NodeAttr.NodeID, value);
	}
	
	/** 
	 UI界面上的访问控制
	*/
	@Override
	public UAC getHisUAC(){
		UAC uac = new UAC();
		if (!BP.Web.WebUser.getNo().equals("admin")){
			uac.IsView = false;
			return uac;
		}
		uac.IsDelete = false;
		uac.IsInsert = false;
		uac.IsUpdate = true;
		return uac;
	}
	
	/** 
	 抄送标题
	*/
	
	// dongliang 标题模板
	public final String getCCTitle(){
		String s = this.GetValStringByKey(CCAttr.CCTitle);
		if (StringHelper.isNullOrEmpty(s)){
			s = "来自@Rec的抄送信息.";
		}
		return s;
	}
	
	public final void setCCTitle(String value){
		this.SetValByKey(CCAttr.CCTitle, value);
	}
	
	/** 
	 抄送内容  
	*/
	// dongliang 内容模板
	public final String getCCDoc(){
		String s = this.GetValStringByKey(CCAttr.CCDoc);
		if (StringHelper.isNullOrEmpty(s)){
			s = "来自@Rec的抄送信息.";
		}
		return s;
	}
	
	public final void setCCDoc(String value){
		this.SetValByKey(CCAttr.CCDoc, value);
	}
	
	/** 
	 抄送对象
	*/
	public final String getCCSQL(){
		String sql = this.GetValStringByKey(CCAttr.CCSQL);
		sql = sql.replace("~", "'");
		sql = sql.replace("‘", "'");
		sql = sql.replace("’", "'");
		sql = sql.replace("''", "'");
		return sql;
	}

	public final void setCCSQL(String value){
		this.SetValByKey(CCAttr.CCSQL, value);
	}
	
	
	/** 
	 是否启用按照岗位抄送
	*/
	public final boolean getCCIsStations()
	{
		return this.GetValBooleanByKey(CCAttr.CCIsStations);
	}
	public final void setCCIsStations(boolean value)
	{
		this.SetValByKey(CCAttr.CCIsStations, value);
	}
	
	/** 
	 是否启用按照部门抄送
	*/
	public final boolean getCCIsDepts(){
		return this.GetValBooleanByKey(CCAttr.CCIsDepts);
	}
	
	public final void setCCIsDepts(boolean value){
		this.SetValByKey(CCAttr.CCIsDepts, value);
	}
	
	/** 
	 是否启用按照人员抄送
	*/
	public final boolean getCCIsEmps(){
		return this.GetValBooleanByKey(CCAttr.CCIsEmps);
	}
	public final void setCCIsEmps(boolean value){
		this.SetValByKey(CCAttr.CCIsEmps, value);
	}
	/** 
	 是否启用按照SQL抄送
	*/
	public final boolean getCCIsSQLs(){
		return this.GetValBooleanByKey(CCAttr.CCIsSQLs);
	}
	public final void setCCIsSQLs(boolean value){
		this.SetValByKey(CCAttr.CCIsSQLs, value);
	}
		///#endregion

		///#region 构造函数
	/** 
	 CC
	*/
	public CC(){}
	/** 
	 重写基类方法
	*/
	@Override
	public Map getEnMap(){
		if (this.get_enMap() != null){
			return this.get_enMap();
		}
		Map map = new Map("WF_Node", "抄送规则");
		map.Java_SetEnType(EnType.Admin);

		map.AddTBIntPK(NodeAttr.NodeID, 0, "节点ID", true, true);
		map.AddTBString(NodeAttr.Name, null, "节点名称", true, true, 0, 100, 10, false);

		map.AddBoolean(CCAttr.CCIsStations, false, "按照岗位抄送", true, true, true);
		map.AddBoolean(CCAttr.CCIsDepts, false, "按照部门抄送", true, true, true);
		map.AddBoolean(CCAttr.CCIsEmps, false, "按照人员抄送", true, true, true);
		map.AddBoolean(CCAttr.CCIsSQLs, false, "按照SQL抄送", true, true, true);

		map.AddDDLSysEnum(CCAttr.CCCtrlWay, 0, "控制方式",true, true,"CtrlWay");

		map.AddTBString(CCAttr.CCSQL, null, "SQL表达式", true, false, 0, 500, 10, true);
		map.AddTBString(CCAttr.CCTitle, null, "抄送标题", true, false, 0, 500, 10,true);
		map.AddTBStringDoc(CCAttr.CCDoc, null, "抄送内容(标题与内容支持变量)", true, false,true);

		map.AddSearchAttr(CCAttr.CCCtrlWay);

		// 相关功能。
		map.getAttrsOfOneVSM().Add(new BP.WF.Template.CCStations(), new BP.WF.Port.Stations(), NodeStationAttr.FK_Node, NodeStationAttr.FK_Station, DeptAttr.Name, DeptAttr.No, "抄送岗位");

		map.getAttrsOfOneVSM().Add(new BP.WF.Template.CCDepts(), new BP.WF.Port.Depts(), NodeDeptAttr.FK_Node, NodeDeptAttr.FK_Dept, DeptAttr.Name, DeptAttr.No, "抄送部门");

		map.getAttrsOfOneVSM().Add(new BP.WF.Template.CCEmps(), new BP.WF.Port.Emps(), NodeEmpAttr.FK_Node, NodeEmpAttr.FK_Emp, DeptAttr.Name, DeptAttr.No, "抄送人员");

		this.set_enMap(map);
		return this.get_enMap();
	}
		///#endregion
}