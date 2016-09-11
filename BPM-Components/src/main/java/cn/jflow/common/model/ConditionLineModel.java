package cn.jflow.common.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BP.DA.DBAccess;
import BP.DA.DataTable;

public class ConditionLineModel extends BaseModel {

	public ConditionLineModel(HttpServletRequest request,
			HttpServletResponse response) {
		super(request, response);
	}

	public final String getCondType() {
		return getParameter("CondType");
	}

	public final String getFK_Flow() {
		return getParameter("FK_Flow");
	}

	public final String getFK_MainNode() {
		return getParameter("FK_MainNode");
	}

	/*
	 * public String getFK_Node() { return getParameter("FK_Node"); }
	 */

	public String getFK_Attr() {
		return getParameter("FK_Attr");
	}

	public String getDirType() {
		return getParameter("DirType");
	}

	public final String getToNodeId() {
		return getParameter("ToNodeId");
	}

	public final DataTable Page_Load() {

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT wd.Node,");
		sql.append("       wn2.Name AS NodeName,");
		sql.append("       wd.ToNode,");
		sql.append("       wn.Name AS ToNodeName,");
		sql.append("       wd.DirType");
		sql.append("  FROM   WF_Direction wd");
		sql.append("       INNER JOIN WF_Node wn");
		sql.append("            ON  wn.NodeID = wd.ToNode");
		sql.append("       INNER JOIN WF_Node wn2");
		sql.append("            ON  wn2.NodeID = wd.Node");
		sql.append("  WHERE  wd.Node = " + getFK_Node());
		
		return  DBAccess.RunSQLReturnTable(sql.toString());
	}

}
