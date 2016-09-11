package cn.jflow.common.model;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import BP.Port.Emp;
import BP.Sys.SystemConfig;
import BP.WF.DoWhatList;
import BP.Web.UserWorkDev;
import BP.Web.WebUser;

public class PortModel extends BaseModel {

	public PortModel(HttpServletRequest request, HttpServletResponse response) {
		super(request, response);
	}

	public final String getDoWhat() {
		return getParameter("DoWhat");
	}

	public final String getUserNo() {
		return getParameter("UserNo");
	}

	public final String getSID() {
		return getParameter("SID");
	}

	public final void loadPage() {
		if (StringUtils.isNotBlank(this.getUserNo()) && StringUtils.isNotBlank(this.getSID())) {
			try {
				String uNo = "";
				if (this.getUserNo().equals("admin")) {
					uNo = "zhoupeng";
				} else {
					uNo = this.getUserNo();
				}

//				if (BP.WF.Dev2Interface.Port_CheckUserLogin(uNo, this.getSID()) == false) {
//					this.get_response().getWriter().print("非法的访问，请与管理员联系。sid=" + this.getSID());
//					return;
//				} else {
					Emp emL = new Emp(this.getUserNo());
					WebUser.setToken(get_request().getSession().getId());
					WebUser.SignInOfGenerLang(emL, SystemConfig.getSysLanguage());
//				}
			} catch (RuntimeException ex) {
				throw new RuntimeException("@有可能您没有配置好ccflow的安全验证机制:" + ex.getMessage());
			}
//		} else {
//			if (!WebUser.getNo().equals("admin")) {
//				throw new RuntimeException("非法的登录用户.");
//			}
		}

		Emp em = new Emp(this.getUserNo());
		WebUser.setToken(get_request().getSession().getId());
		WebUser.SignInOfGenerLang(em, SystemConfig.getSysLanguage());

		String paras = "";
		Enumeration en = this.getRequest().getParameterNames();
		while(en.hasMoreElements()){
			
			String str = (String)en.nextElement();
			String val = this.getRequest().getParameter(str);
			if (val.indexOf('@') != -1) {
				throw new RuntimeException("您没有能参数: [ " + str + " ," + val + " ] 给值 ，URL 将不能被执行。");
			}
			
			if (!(str.equals(DoWhatList.DoNode) || str.equals(DoWhatList.Emps)
					|| str.equals(DoWhatList.EmpWorks)
					|| str.equals(DoWhatList.FlowSearch)
					|| str.equals(DoWhatList.Login)
					|| str.equals(DoWhatList.MyFlow)
					|| str.equals(DoWhatList.MyWork)
					|| str.equals(DoWhatList.Start)
					|| str.equals(DoWhatList.Start5)
					|| str.equals(DoWhatList.JiSu)
					|| str.equals(DoWhatList.StartSmall)
					|| str.equals(DoWhatList.FlowFX)
					|| str.equals(DoWhatList.DealWork)
					|| str.equals(DoWhatList.DealWorkInSmall)
					// || str.equals(DoWhatList.CallMyFlow)
					|| str.equals("FK_Flow") || str.equals("WorkID")
					|| str.equals("FK_Node") || str.equals("SID"))) {
				paras += "&" + str + "=" + val;
			}
		}

//		if (this.IsPostBack == false) {
		if (this.IsCanLogin() == false) {
			ToMsgPage("<fieldset><legend>安全验证错误</legend> 系统无法执行您的请求，可能是您的登录时间太长，请重新登录。<br>如果您要取消安全验证请修改web.config 中IsDebug 中的值设置成1。</fieldset>");
			return;
		}

		BP.Port.Emp emp = new BP.Port.Emp(this.getUserNo());
		WebUser.SignInOfGener(emp); // 开始执行登录。

		if (this.getParameter("IsMobile") != null) {
			WebUser.setUserWorkDev(UserWorkDev.Mobile);
		}

		String nodeID = String.valueOf(Integer.parseInt(this.getFK_Flow()+ "01"));
		String doWhat = this.getDoWhat();
		if (doWhat.equals(DoWhatList.OneWork)) // 工作处理器调用.
		{
			if (this.getFK_Flow() == null || this.getWorkID() == 0) {
				throw new RuntimeException("@参数 FK_Flow 或者 WorkID 为 Null 。");
			}
			sendRedirect("WFRpt.jsp?FK_Flow=" + this.getFK_Flow() + "&WorkID="
					+ this.getWorkID() + "&o2=1" + paras);
		} else if (doWhat.equals(DoWhatList.JiSu)) // 极速模式的方式发起工作
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("App/Simple/Default.jsp");
			} else {
				sendRedirect("App/Simple/Default.jsp?FK_Flow="
						+ this.getFK_Flow() + paras + "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals(DoWhatList.Start5)) // 发起工作
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("App/Classic/Default.jsp");
			} else {
				sendRedirect("App/Classic/Default.jsp?FK_Flow="
						+ this.getFK_Flow() + paras + "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals(DoWhatList.StartLigerUI)) {
			if (this.getFK_Flow() == null) {
				sendRedirect("App/EasyUI/Default.jsp");
			} else {
				sendRedirect("App/EasyUI/Default.jsp?FK_Flow="
						+ this.getFK_Flow() + paras + "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals("Amaze")) {
			if (this.getFK_Flow() == null) {
				sendRedirect("App/Amaz/Default.jsp");
			} else {
				sendRedirect("App/Amaz/Default.jsp?FK_Flow="
						+ this.getFK_Flow() + paras + "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals(DoWhatList.Start)) // 发起工作
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("Start.jsp");
			} else {
				sendRedirect("MyFlow.jsp?FK_Flow=" + this.getFK_Flow() + paras
						+ "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals(DoWhatList.StartSmall)) // 发起工作　小窗口
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("Start.jsp?FK_Flow=" + this.getFK_Flow() + paras);
			} else {
				sendRedirect("MyFlow.jsp?FK_Flow=" + this.getFK_Flow() + paras);
			}
		} else if (doWhat.equals(DoWhatList.StartSmallSingle)) // 发起工作单独小窗口
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("Start.jsp?FK_Flow=" + this.getFK_Flow() + paras
						+ "&IsSingle=1&FK_Node=" + nodeID);
			} else {
				sendRedirect("MyFlowSmallSingle.jsp?FK_Flow="
						+ this.getFK_Flow() + paras + "&FK_Node=" + nodeID);
			}
		} else if (doWhat.equals(DoWhatList.Runing)) // 在途中工作
		{
			sendRedirect("Runing.jsp?FK_Flow=" + this.getFK_Flow());
		} else if (doWhat.equals(DoWhatList.Tools)) // 工具栏目。
		{
			sendRedirect("Tools.jsp");
		} else if (doWhat.equals(DoWhatList.ToolsSmall)) // 小工具栏目.
		{
			sendRedirect("Tools.jsp?RefNo=" + this.getParameter("RefNo"));
		} else if (doWhat.equals(DoWhatList.EmpWorks)) // 我的工作小窗口.
		{
			if (this.getFK_Flow() == null || this.getFK_Flow().equals("")) {
				sendRedirect("EmpWorks.jsp");
			} else {
				sendRedirect("EmpWorks.jsp?FK_Flow=" + this.getFK_Flow());
			}
		} else if (doWhat.equals(DoWhatList.Login)) {
			if (this.getFK_Flow() == null) {
				sendRedirect("EmpWorks.jsp");
			} else {
				sendRedirect("EmpWorks.jsp?FK_Flow=" + this.getFK_Flow());
			}
		} else if (doWhat.equals(DoWhatList.Emps)) // 通讯录。
		{
			sendRedirect("Emps.jsp");
		} else if (doWhat.equals(DoWhatList.FlowSearch)) // 流程查询。
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("FlowSearch.jsp");
			} else {
				sendRedirect("Rpt/Search.jsp?Endse=s&FK_Flow=001&EnsName=ND"
						+ Integer.parseInt(this.getFK_Flow()) + "Rpt" + paras);
			}
		} else if (doWhat.equals(DoWhatList.FlowSearchSmall)) // 流程查询。
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("FlowSearch.jsp");
			} else {
				sendRedirect("Comm/Search.jsp?EnsName=ND"
						+ Integer.parseInt(this.getFK_Flow()) + "Rpt" + paras);
			}
		} else if (doWhat.equals(DoWhatList.FlowSearchSmallSingle)) // 流程查询。
		{
			if (this.getFK_Flow() == null) {
				sendRedirect("FlowSearchSmallSingle.jsp");
			} else {
				sendRedirect("Comm/Search.jsp?EnsName=ND"
						+ Integer.parseInt(this.getFK_Flow()) + "Rpt" + paras);
			}
		} else if (doWhat.equals(DoWhatList.FlowFX)) // 流程查询。
		{
			if (this.getFK_Flow() == null) {
				throw new RuntimeException("@没有参数流程编号。");
			}

			sendRedirect("Comm/Group.jsp?EnsName=ND"
					+ Integer.parseInt(this.getFK_Flow()) + "Rpt" + paras);
		} else if (doWhat.equals(DoWhatList.DealWork)) {
			if (this.getFK_Flow() == null || this.getWorkID() == 0) {
				throw new RuntimeException("@参数 FK_Flow 或者 WorkID 为Null 。");
			}
			sendRedirect("MyFlow.jsp?FK_Flow=" + this.getFK_Flow() + "&WorkID="
					+ this.getWorkID() + "&o2=1" + paras);
		} else if (doWhat.equals(DoWhatList.DealWorkInSmall)) {
			if (this.getFK_Flow() == null || this.getWorkID() == 0) {
				throw new RuntimeException("@参数 FK_Flow 或者 WorkID 为Null 。");
			}
			sendRedirect("MyFlow.jsp?FK_Flow=" + this.getFK_Flow() + "&WorkID="
					+ this.getWorkID() + "&o2=1" + paras);
		} else {
			ToErrorPage("没有约定的标记:DoWhat=" + this.getDoWhat());
		}
//		}
	}

	/** 
	 验证登录用户是否合法
	 
	 @return 
	*/
	public final boolean IsCanLogin() {
		Object isAuth = SystemConfig.getAppSettings().get("IsAuth");
		if (isAuth == null) {
			return true;
		}
		if (isAuth.equals("1")) {
			if (!this.getSID().equals(this.GetKey())) {
				if (SystemConfig.getIsDebug()) {
					return true;
				} else {
					return false;
				}
			}
		}
		return true;
	}

	public final String GetKey() {
		return BP.DA.DBAccess.RunSQLReturnString("SELECT SID From Port_Emp WHERE no='" + this.getUserNo() + "'");
	}

	//	/**
	//	 * 发起工作
	//	 */
	//	private void sendWork(){
	//		if(!getFK_Flow().equals("")){
	//			String nodeID = String.valueOf(Integer.parseInt(this.getFK_Flow() + "01"));
	//			String url = "./MyFlow.jsp?FK_Flow=" + this.getFK_Flow() + "&FK_Node=" + nodeID + "&DoWhat=" + getDoWhat();
	//            try {
	//				PubClass.WinOpen(get_response(), url, 800, 600);
	//			} catch (IOException e) {
	//				e.printStackTrace();
	//			}
	//		}
	//	}

}
