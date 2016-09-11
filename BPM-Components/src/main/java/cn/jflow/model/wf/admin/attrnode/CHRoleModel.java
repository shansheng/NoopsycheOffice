package cn.jflow.model.wf.admin.attrnode;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import BP.Sys.SysEnumAttr;
import BP.Sys.SysEnums;
import BP.Tools.StringHelper;
import BP.WF.Node;

@Controller
@RequestMapping("/WF/Admin/AttrNode")
public class CHRoleModel {
	private HttpServletRequest _request = null;
	private HttpServletResponse _response = null;

	public String getUTF8ToString(String param) {
		try {
			return java.net.URLDecoder.decode(_request.getParameter(param),
					"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

	// region 属性.
	/**
	 * 节点ID
	 */
	public int getFK_Node() {
		return Integer.parseInt(this._request.getParameter("FK_Node"));
	}

	// endregion 属性.

	@RequestMapping(value = "/CHRoleModel", method = RequestMethod.GET)
	public void executeHelper(HttpServletRequest request,
			HttpServletResponse response) {
		_request = request;
		_response = response;
		String method = "";
		// 返回值
		String s_responsetext = "";
		if (StringHelper.isNullOrEmpty(request.getParameter("method"))) {
			return;
		}

		method = request.getParameter("method").toString();

		if (method.equals("getMyData")) {
			s_responsetext = pageLoad();
		} else if (method.equals("insertSameNodeMet")) {
			// s_responsetext = insertSameNodeMet();
		} else if (method.equals("insertSonNodeMet")) {
			// s_responsetextnsetext = insertSonNodeMet();
		} else if (method.equals("editNodeMet")) {
			// s_responsetext = editNodeMet();
		} else if (method.equals("delNodeMet")) {
			// s_responsetext = delNodeMet();
		}
		if (StringHelper.isNullOrEmpty(s_responsetext)) {
			// s_responsetext = "";
		}
		// 组装ajax字符串格式,返回调用客户端
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		try {
			response.getOutputStream().write(
					s_responsetext.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public String pageLoad() {
		Node nd = new Node(this.getFK_Node());
		nd.CheckPhysicsTable();

		StringBuilder sBuilder = new StringBuilder();
		sBuilder.append("{\"tb_tspanday\":\"");

		sBuilder.append(nd.getTSpanDay() + "\",");
		sBuilder.append("\"tb_tspanhour\":\"");
		sBuilder.append(nd.getTSpanHour() + "\",");
		sBuilder.append("\"tb_warninghour\":\"");
		sBuilder.append(nd.getWarningHour() + "\",");
		sBuilder.append("\"tb_warningday\":\"");
		sBuilder.append(nd.getWarningDay() + "\",");
		sBuilder.append("\"tb_tcent\":\"");
		sBuilder.append(nd.getTCent() + "\",");

		sBuilder.append("\"hischway\":\"");
		sBuilder.append(nd.getHisCHWay().getValue() + "\",");
		sBuilder.append("\"cb_iseval\":\"");
		sBuilder.append(nd.getIsEval() + "\",");
		
		
		SysEnums ses = new SysEnums();
		ses.RetrieveByAttr(SysEnumAttr.EnumKey, "CHAlertRole");

		sBuilder.append("\"ddl_talertrole\":"
				+ BP.Tools.Entitis2Json.ConvertEntities2ListJson(ses) + ",");
		sBuilder.append("\"ttrolesed\":\"");
		sBuilder.append(nd.getTAlertRole().getValue() + "\",");
		
		ses = new SysEnums();
		ses.RetrieveByAttr(SysEnumAttr.EnumKey, "CHAlertWay");

		sBuilder.append("\"ddl_talertway\":"
				+ BP.Tools.Entitis2Json.ConvertEntities2ListJson(ses) + ",");
		sBuilder.append("\"ttwaysed\":\"");
		sBuilder.append(nd.getTAlertWay().getValue() + "\",");
		
		ses = new SysEnums();
		ses.RetrieveByAttr(SysEnumAttr.EnumKey, "CHAlertRole");

		sBuilder.append("\"ddl_walertrole\":"
				+ BP.Tools.Entitis2Json.ConvertEntities2ListJson(ses) + ",");
		sBuilder.append("\"wrolesed\":\"");
		sBuilder.append(nd.getWAlertRole().getValue() + "\",");

		ses = new SysEnums();
		ses.RetrieveByAttr(SysEnumAttr.EnumKey, "CHAlertWay");

		sBuilder.append("\"ddl_walertway\":"
				+ BP.Tools.Entitis2Json.ConvertEntities2ListJson(ses));
		sBuilder.append(",\"wwaysed\":\"");
		sBuilder.append(nd.getWAlertWay().getValue() + "\"");
		
		sBuilder.append("}");

		return sBuilder.toString();
	}
}
