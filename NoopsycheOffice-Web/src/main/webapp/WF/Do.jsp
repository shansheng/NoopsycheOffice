<%@page import="BP.WF.Template.CCList"%>
<%@page import="BP.WF.Template.CCSta"%>
<%@page import="BP.WF.Glo"%>
<%@page import="BP.WF.Flow"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.WF.WorkFlow"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.DA.Log"%>
<%@page import="BP.Port.Emp"%>
<%@page import="BP.WF.Entity.GenerWorkerListAttr"%>
<%@page import="BP.WF.Entity.GenerWorkerList"%>
<%@page import="BP.WF.Node"%>
<%@page import="BP.WF.Port.WFEmps"%>
<%@page import="BP.WF.Port.WFEmp"%>
<%@page import="BP.WF.XML.EventListDtlList"%>
<%@page import="BP.Sys.Frm.FrmEvents"%>
<%@page import="BP.Sys.GEDtl"%>
<%@page import="BP.Sys.GEDtls"%>
<%@page import="BP.WF.Data.Bill"%>
<%@page import="BP.Tools.StringHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="cn.jflow.system.ui.core.*"%>
<%@page import="cn.jflow.system.ui.uc.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	
	String fk_flow = request.getParameter("FK_Flow");
	String refNo = request.getParameter("RefNo");
	String ensName = request.getParameter("EnsName");
	String fk_emp = request.getParameter("FK_Emp");
	long workId = request.getParameter("WorkID")==null?0:Long.parseLong(request.getParameter("WorkID"));
	String actionType = request.getParameter("ActionType");
	String nodeId = request.getParameter("NodeID");
	String myPK = request.getParameter("MyPK");
	String refOidStr = request.getParameter("RefOID");
    if (refOidStr == null)
    	refOidStr = request.getParameter("OID");
    if (refOidStr == null)
   		refOidStr =  "0";
     
    int refOid = Integer.parseInt(refOidStr);
     
	int fk_node = 0;
	
	if (actionType == null)
	{
		actionType = request.getParameter("DoType");
	}

	if (StringHelper.isNullOrEmpty(actionType) && request.getParameter("SID") != null)
	{
		actionType = "Track";
	}
	
	if(StringHelper.isNullOrEmpty(nodeId)){
		String node = request.getParameter("FK_Node");
		if(!StringHelper.isNullOrEmpty(node)){
			fk_node = Integer.parseInt(node);
		}
	}else{
		fk_node = Integer.parseInt(nodeId);
	}
	
	PageBase base = new PageBase(request, response);
	try{
		//String url = request.getQueryString();
		//if (url.contains("DTT=") == false)
		//{
			//this.Response.Redirect(url + "&DTT=" + DateTime.Now.ToString("mmDDhhmmss"), true);
			//return;
		//}
		String str = "";
		if (actionType.equals("PutOne")) //把任务放入任务池.
		{
			 Dev2Interface.Node_TaskPoolPutOne(workId);
			 base.WinClose("ss");
		}
		else if (actionType.equals("DoAppTask")) // 申请任务.
		{
				BP.WF.Dev2Interface.Node_TaskPoolTakebackOne(workId);
				base.WinClose("ss");
				return;
		} else if (actionType.equals("DoOpenCC"))
		{
				String fid = request.getParameter("FID"); 
				String Sta = request.getParameter("Sta");
				if (Sta.equals("0"))
				{
					CCList cc1 = new CCList();
					cc1.setMyPK(myPK);
					cc1.Retrieve();
					cc1.setHisSta(CCSta.Read);
					cc1.Update();
				}
				response.sendRedirect("./WorkOpt/OneWork/Track.jsp?FK_Flow=" + fk_flow + "&FK_Node=" + fk_node + "&WorkID=" + workId + "&FID=" + fid);
				return;
		}
		else if (actionType.equals("DelCC")) //删除抄送.
		{
				CCList cc = new CCList();
				cc.setMyPK(myPK);
				cc.Retrieve();
				cc.setHisSta(CCSta.Del);
				cc.Update();
				base.WinClose();
		}
		else if (actionType.equals("DelSubFlow")) //删除进程。
		{
				try
				{
					BP.WF.Dev2Interface.Flow_DeleteSubThread(fk_flow, workId, "手工删除");
					base.WinClose();
				}
				catch (RuntimeException ex)
				{
					base.WinCloseWithMsg(ex.getMessage());
				}
		}
		else if (actionType.equals("DownBill"))
		{
				Bill b = new Bill(myPK);
				b.DoOpen();
		}
		else if (actionType.equals("DelDtl"))
		{
				GEDtls dtls = new GEDtls(ensName);
				GEDtl dtl = (GEDtl)dtls.getGetNewEntity();
				dtl.setOID(Integer.parseInt(refNo));
				if (dtl.RetrieveFromDBSources() == 0)
				{
					base.WinClose();
					return;
				}
				FrmEvents fes = new FrmEvents(ensName); //获得事件.
	
				// 处理删除前事件.
				try
				{
					fes.DoEventNode(EventListDtlList.DtlItemDelBefore, dtl);
				}
				catch (RuntimeException ex)
				{
					base.WinCloseWithMsg(ex.getMessage());
					return;
				}
				dtl.Delete();
	
				// 处理删除后事件.
				try
				{
					fes.DoEventNode(EventListDtlList.DtlItemDelAfter, dtl);
				}
				catch (RuntimeException ex)
				{
					base.WinCloseWithMsg(ex.getMessage());
					return;
				}
				base.WinClose();
		}
		else if (actionType.equals("EmpDoUp"))
		{
				WFEmp ep = new WFEmp(refNo);
				ep.DoUp();
	
				WFEmps emps111 = new WFEmps();
			  //  emps111.RemoveCash();
				emps111.RetrieveAll();
				base.WinClose();
		}
		else if (actionType.equals("EmpDoDown"))
		{
				WFEmp ep1 = new WFEmp(refNo);
				ep1.DoDown();
	
				WFEmps emps11441 = new WFEmps();
			  //  emps11441.RemoveCash();
				emps11441.RetrieveAll();
				base.WinClose();
	
		}
		else if (actionType.equals("Track")) //通过一个串来打开一个工作.
		{
				String mySid = request.getParameter("SID");
				String[] mystrs = mySid.split("_");
	
				long myWorkID = Integer.parseInt(mystrs[1]);
				String fkEmp = mystrs[0];
				int fkNode = Integer.parseInt(mystrs[2]);
				Node mynd = new Node();
				mynd.setNodeID(fkNode);
				mynd.RetrieveFromDBSources();
	
				String fkFlow = mynd.getFK_Flow();
				String myurl = "./WorkOpt/OneWork/Track.jsp?FK_Node=" + mynd.getNodeID() + "&WorkID=" + myWorkID + "&fk_flow=" + fkFlow;
				WebUser.SignInOfGener(new Emp(fkEmp), true);
				
				out.println("<script> window.location.href='" + myurl + "'</script> *^_^*  <br><br>正在进入系统请稍后，如果长时间没有反应，请<a href='" + myurl + "'>点这里进入。</a>");
				return;
		}
		else if (actionType.equals("OF")) //通过一个串来打开一个工作.
		{
				String sid = request.getParameter("SID");
				String[] strs = sid.split("_");
				GenerWorkerList wl = new GenerWorkerList();
				int i = wl.Retrieve(GenerWorkerListAttr.FK_Emp, strs[0], GenerWorkerListAttr.WorkID, strs[1], GenerWorkerListAttr.FK_Node, strs[2]);
				if (i == 0)
				{
					out.println("<h2>提示</h2>此工作已经被别人处理或者此流程已删除。");
					return;
				}
	
				BP.Port.Emp empOF = new BP.Port.Emp(wl.getFK_Emp());
				WebUser.SignInOfGener(empOF, true);
				String u = "MyFlow.jsp?fk_flow=" + wl.getFK_Flow() + "&WorkID=" + wl.getWorkID()+"&FK_Node="+wl.getFK_Node()+"&FID="+wl.getFID();
				out.println("<script> window.location.href='" + u + "'</script> *^_^*  <br><br>正在进入系统请稍后，如果长时间没有反应，请<a href='" + u + "'>点这里进入。</a>");
				return;
		} 
		else if (actionType.equals("ExitAuth"))
		{
				Emp emp = new Emp(fk_emp);
				//首先退出，再进行登录
				WebUser.Exit();
				WebUser.SignInOfGener(emp,WebUser.getSysLang());
				base.WinClose();
				return;
		}
		else if (actionType.equals("LogAs"))
		{
				BP.WF.Port.WFEmp wfemp = new WFEmp(fk_emp);
				if (wfemp.getAuthorIsOK() == false)
				{
					base.WinCloseWithMsg("授权失败");
					return;
				}
				Emp emp1 = new Emp(fk_emp);
				
				WebUser.SignInOfGener(emp1, WebUser.getSysLang(), WebUser.getNo(), true, false);
				base.WinClose();
				return;
		} 
		else if (actionType.equals("TakeBack")) // 取消授权。
		{
				WFEmp myau = new WFEmp(WebUser.getNo());
				Log.DefaultLogWriteLineInfo("取消授权:" + WebUser.getNo() + "取消了对(" + myau.getAuthor() + ")的授权。");
				myau.setAuthor("");
				myau.setAuthorWay(0);
				myau.Update();
				base.WinClose();
				return;
		}
		else if (actionType.equals("AutoTo")) // 执行授权。
		{
				WFEmp au = new WFEmp();
				au.setNo(WebUser.getNo());
				au.RetrieveFromDBSources();
				au.setAuthorDate(DataType.getCurrentData());
				au.setAuthor(fk_emp);
				au.setAuthorWay(1);
				au.Save();
				Log.DefaultLogWriteLineInfo("执行授权:" + WebUser.getNo() + "执行了对(" + au.getAuthor() + ")的授权。");
				base.WinClose();
				return;
		}
		else if (actionType.equals("UnSend")) // 执行撤消发送。
		{
				try
				{
				   	String str1= BP.WF.Dev2Interface.Flow_DoUnSend(fk_flow, workId);
				   	session.setAttribute("info", str1);
				   	response.sendRedirect("MyFlowInfo.jsp?FK_Flow=" + fk_flow + "&WorkID=" + workId);
					return;
				}
				catch (RuntimeException ex)
				{
					session.setAttribute("info", "@执行撤消失败。@失败信息" + ex.getMessage());
					//this.Alert(ex.getMessage());
					base.WinCloseWithMsg(ex.getMessage());
					response.sendRedirect("MyFlowInfo.jsp?fk_flow=" + fk_flow + "&WorkID=" + workId + "&FK_Type=warning");
					return;
				}
			// response.sendRedirect("MyFlow.aspx?WorkID=" + this.WorkID + "&fk_flow=" + this.fk_flow, true);
		}
		else if (actionType.equals("SetBillState"))
		{
		}
		else if (actionType.equals("WorkRpt"))
		{
				BP.WF.Data.Bill bk1 = new BP.WF.Data.Bill(request.getParameter("OID"));
				Node nd = new Node(bk1.getFK_Node());
				response.sendRedirect("WFRpt.jsp?WorkID=" + bk1.getWorkID() + "&FID=" + bk1.getFID() + "&fk_flow=" + nd.getFK_Flow() + "&NodeId=" + bk1.getFK_Node());
				//this.WinOpen();
				//base.WinClose();
		}
		else if (actionType.equals("PrintBill"))
		{
				//Bill bk2 = new Bill(this.Request.QueryString["OID"]);
				//Node nd2 = new Node(bk2.FK_Node);
				//response.sendRedirect("NodeRefFunc.aspx?NodeId=" + bk2.FK_Node + "&FlowNo=" + nd2.fk_flow + "&NodeRefFuncOID=" + bk2.FK_NodeRefFunc + "&WorkFlowID=" + bk2.WorkID);
				////base.WinClose();
			//删除流程中第一个节点的数据，包括待办工作
		}
		else if (actionType.equals("DeleteFlow"))
		{
				//调用DoDeleteWorkFlowByReal方法
				WorkFlow wf = new WorkFlow(new Flow(fk_flow), workId);
				wf.DoDeleteWorkFlowByReal(true);
				Glo.ToMsg("流程删除成功",response);
		}
		else if (actionType.equals("Focus"))
		{
			 BP.WF.Dev2Interface.Flow_Focus(workId);	
			 base.WinClose("ss");
			return;
		}
		else
		{
				throw new RuntimeException("actionType error" + actionType);
		}
	}
	catch (RuntimeException ex)
	{
		base.ToErrorPage("执行其间如下异常：<BR>" + ex.getMessage());
	}
	
%>