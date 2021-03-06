package BP.WF;

import java.util.Hashtable;

import BP.DA.DataRow;
import BP.DA.DataTable;
import BP.DA.DataType;
import BP.Tools.StringHelper;
import BP.WF.Data.GERpt;
import BP.WF.Template.CC;
import BP.WF.Template.CCList;
import BP.WF.Template.CCSta;
import BP.Web.WebUser;

/** 
 抄送
*/
public class CCWork
{
		///#region 属性.
	/** 
	 工作节点
	*/
	public WorkNode HisWorkNode = null;
	/** 
	 节点
	*/
	public final Node getHisNode()
	{
		return this.HisWorkNode.getHisNode();
	}
	/** 
	 报表
	*/
	public final GERpt getrptGe()
	{
		return this.HisWorkNode.rptGe;
	}
	/** 
	 工作ID
	*/
	public final long getWorkID()
	{
		return this.HisWorkNode.getWorkID();
	}
		///#endregion 属性.

	/** 
	 构造
	 
	 @param wn
	*/
	public CCWork(WorkNode wn)
	{
		this.HisWorkNode = wn;
		AutoCC();
		CCByEmps();

	}
	public final void AutoCC()
	{
		if (this.HisWorkNode.getHisNode().getHisCCRole() == CCRole.AutoCC || this.HisWorkNode.getHisNode().getHisCCRole() == CCRole.HandAndAuto)
		{
		}
		else
		{
			return;
		}

		/*如果是自动抄送*/
		CC cc = this.HisWorkNode.getHisNode().getHisCC();

		///#region 替换节点变量
		cc.setCCSQL(cc.getCCSQL().replace("@FK_Node", this.getHisNode().getNodeID() + ""));
		cc.setCCSQL(cc.getCCSQL().replace("@FK_Flow", this.getHisNode().getFK_Flow()));
		cc.setCCSQL(cc.getCCSQL().replace("@OID",this.HisWorkNode.getWorkID() + ""));
		///#endregion

		// 执行抄送.
		DataTable dt = cc.GenerCCers(this.HisWorkNode.rptGe);
		if (dt.Rows.size() == 0)
		{
			return;
		}

		String ccMsg = "@消息自动抄送给";
		String basePath = BP.WF.Glo.getHostURL();
		String mailTemp = BP.DA.DataType.ReadTextFile2Html(BP.Sys.SystemConfig.getPathOfDataUser() + "EmailTemplete/CC_" + WebUser.getSysLang() + ".txt");

		GenerWorkerLists gwls = null;
		if (this.HisWorkNode.town != null)
		{
			//取出抄送集合，如果待办里有此人就取消该人员的抄送.
			gwls = new GenerWorkerLists(this.getWorkID(), this.HisWorkNode.town.getHisNode().getNodeID());
		}
		for (DataRow dr : dt.Rows)
		{
			String toUserNo = dr.getValue(0).toString();

			//如果待办包含了它.
			if (gwls != null && gwls.Contains(GenerWorkerListAttr.FK_Emp, toUserNo) == true)
			{
				continue;
			}

			String toUserName = dr.getValue(1).toString();

			//生成标题与内容.
			Object tempVar = cc.getCCTitle();
			String ccTitle = (String)((tempVar instanceof String) ? tempVar : null);
			ccTitle = BP.WF.Glo.DealExp(ccTitle, this.getrptGe(), null);

			Object tempVar2 = cc.getCCDoc();
			String ccDoc = (String)((tempVar2 instanceof String) ? tempVar2 : null);
			ccDoc = BP.WF.Glo.DealExp(ccDoc, this.getrptGe(), null);

			ccDoc = ccDoc.replace("@Accepter", toUserNo);
			ccTitle = ccTitle.replace("@Accepter", toUserNo);

			//抄送信息.
			ccMsg += "(" + toUserNo + " - " + toUserName + ");";
			CCList list = new CCList();
			list.setMyPK(this.HisWorkNode.getWorkID() + "_" + this.HisWorkNode.getHisNode().getNodeID() + "_" + dr.getValue(0).toString());
			list.setFK_Flow(this.HisWorkNode.getHisNode().getFK_Flow());
			list.setFlowName(this.HisWorkNode.getHisNode().getFlowName());
			list.setFK_Node(this.HisWorkNode.getHisNode().getNodeID());
			list.setNodeName(this.HisWorkNode.getHisNode().getName());
			list.setTitle(ccTitle);
			list.setDoc(ccDoc);
			list.setCCTo(dr.getValue(0).toString());
			list.setCCToName(dr.getValue(1).toString());
			list.setRDT(DataType.getCurrentDataTime());
			list.setRec(WebUser.getNo());
			list.setWorkID(this.HisWorkNode.getWorkID());
			list.setFID(this.HisWorkNode.getHisWork().getFID());
			list.setInEmpWorks(this.getHisNode().getCCWriteTo() == CCWriteTo.CCList ? false : true); //added by liuxc,2015.7.6
			//写入待办和写入待办与抄送列表,状态不同
			if (this.getHisNode().getCCWriteTo() == CCWriteTo.All || this.getHisNode().getCCWriteTo() == CCWriteTo.Todolist)
			{
				//如果为写入待办则抄送列表中置为已读，原因：只为不提示有未读抄送。
				list.setHisSta(this.getHisNode().getCCWriteTo() == CCWriteTo.All ? CCSta.UnRead : CCSta.Read);
			}
			//结束节点只写入抄送列表
			if (this.getHisNode().getIsEndNode() == true)
			{
				list.setHisSta(CCSta.UnRead);
				list.setInEmpWorks(false);
			}
			try
			{
				list.Insert();
			}
			catch (java.lang.Exception e)
			{
				list.Update();
			}

			if (BP.WF.Glo.getIsEnableSysMessage() == true)
			{
				//     //写入消息提示.
				//     ccMsg += list.CCTo + "(" + dr[1].ToString() + ");";
				//     BP.WF.Port.WFEmp wfemp = new Port.WFEmp(list.CCTo);
				//     string sid = list.CCTo + "_" + list.WorkID + "_" + list.FK_Node + "_" + list.RDT;
				//     string url = basePath + "WF/Do.aspx?DoType=OF&SID=" + sid;
				//     string urlWap = basePath + "WF/Do.aspx?DoType=OF&SID=" + sid + "&IsWap=1";
				//     string mytemp = mailTemp as string;
				//     mytemp = string.Format(mytemp, wfemp.Name, WebUser.getName(), url, urlWap);
				//     string title = string.Format("工作抄送:{0}.工作:{1},发送人:{2},需您查阅",
				//this.HisNode.FlowName, this.HisNode.Name, WebUser.getName());
				//     BP.WF.Dev2Interface.Port_SendMsg(wfemp.getNo(), title, mytemp, null, BP.Sys.SMSMsgType.CC, list.FK_Flow, list.FK_Node, list.WorkID, list.FID);
			}
		}

		this.HisWorkNode.addMsg(SendReturnMsgFlag.CCMsg, ccMsg);

		//写入日志.
		this.HisWorkNode.AddToTrack(ActionType.CC, WebUser.getNo(), WebUser.getName(), this.getHisNode().getNodeID(), this.getHisNode().getName(), ccMsg, this.getHisNode());
	}
	/** 
	 按照约定的字段 SysCCEmps 系统人员.
	*/
	public final void CCByEmps()
	{
		if (this.getHisNode().getHisCCRole() != CCRole.BySysCCEmps)
		{
			return;
		}

		CC cc = this.getHisNode().getHisCC();

		//生成标题与内容.
		Object tempVar = cc.getCCTitle();
		String ccTitle = (String)((tempVar instanceof String) ? tempVar : null);
		ccTitle = BP.WF.Glo.DealExp(ccTitle, this.getrptGe(), null);

		Object tempVar2 = cc.getCCDoc();
		String ccDoc = (String)((tempVar2 instanceof String) ? tempVar2 : null);
		ccDoc = BP.WF.Glo.DealExp(ccDoc, this.getrptGe(), null);

		//取出抄送人列表
		String ccers = this.getrptGe().GetValStrByKey("SysCCEmps");
		if (!StringHelper.isNullOrEmpty(ccers))
		{
			String[] cclist = ccers.split("[|]", -1);
			Hashtable ht = new Hashtable();
			for (String item : cclist)
			{
				String[] tmp = item.split("[,]", -1);
				ht.put(tmp[0], tmp[1]);
			}
			String ccMsg = "@消息自动抄送给";
			String basePath = BP.WF.Glo.getHostURL();

			String mailTemp = BP.DA.DataType.ReadTextFile2Html(BP.Sys.SystemConfig.getPathOfDataUser() + "EmailTemplete/CC_" + WebUser.getSysLang() + ".txt");
			for (Object item : ht.keySet())
			{
				ccDoc = ccDoc.replace("@Accepter", ht.get(item).toString());
				ccTitle = ccTitle.replace("@Accepter", ht.get(item).toString());

				//抄送信息.
				ccMsg += "(" + ht.get(item).toString() + " - " + ht.get(item).toString() + ");";

				///#region 如果是写入抄送列表.
				CCList list = new CCList();
				list.setMyPK(this.getWorkID() + "_" + this.getHisNode().getNodeID() + "_" + item.toString());
				list.setFK_Flow(this.getHisNode().getFK_Flow());
				list.setFlowName(this.getHisNode().getFlowName());
				list.setFK_Node(this.getHisNode().getNodeID());
				list.setNodeName(this.getHisNode().getName());
				list.setTitle(ccTitle);
				list.setDoc(ccDoc);
				list.setCCTo(item.toString());
				list.setCCToName(ht.get(item).toString());
				list.setRDT(DataType.getCurrentDataTime());
				list.setRec(WebUser.getNo());
				list.setWorkID(this.getWorkID());
				list.setFID(this.HisWorkNode.getHisWork().getFID());
				list.setInEmpWorks(this.getHisNode().getCCWriteTo() == CCWriteTo.CCList ? false : true); //added by liuxc,2015.7.6
				//写入待办和写入待办与抄送列表,状态不同
				if (this.getHisNode().getCCWriteTo() == CCWriteTo.All || this.getHisNode().getCCWriteTo() == CCWriteTo.Todolist)
				{
					//如果为写入待办则抄送列表中置为已读，原因：只为不提示有未读抄送。
					list.setHisSta(this.getHisNode().getCCWriteTo() == CCWriteTo.All ? CCSta.UnRead : CCSta.Read);
				}
				//如果为结束节点，只写入抄送列表
				if (this.getHisNode().getIsEndNode() == true)
				{
					list.setHisSta(CCSta.UnRead);
					list.setInEmpWorks(false);
				}

				//执行保存或更新
				try
				{
					list.Insert();
				}
				catch (java.lang.Exception e)
				{
					list.CheckPhysicsTable();
					list.Update();
				}
				///#endregion 如果要写入抄送

				if (BP.WF.Glo.getIsEnableSysMessage() == true)
				{
					ccMsg += list.getCCTo() + "(" + ht.get(item).toString() + ");";
					BP.WF.Port.WFEmp wfemp = new BP.WF.Port.WFEmp(list.getCCTo());

					String sid = list.getCCTo() + "_" + list.getWorkID() + "_" + list.getFK_Node() + "_" + list.getRDT();
					String url = basePath + "WF/Do.jsp?DoType=OF&SID=" + sid;
					url = url.replace("//", "/");
					url = url.replace("//", "/");

					String urlWap = basePath + "WF/Do.jsp?DoType=OF&SID=" + sid + "&IsWap=1";
					urlWap = urlWap.replace("//", "/");
					urlWap = urlWap.replace("//", "/");

					Object tempVar3 = mailTemp;
					String mytemp = (String)((tempVar3 instanceof String) ? tempVar3 : null);
					mytemp = String.format(mytemp, wfemp.getName(), WebUser.getName(), url, urlWap);

					String title = String.format("工作抄送:%1$s.工作:%2$s,发送人:%3$s,需您查阅", this.getHisNode().getFlowName(), this.getHisNode().getName(), WebUser.getName());

					BP.WF.Dev2Interface.Port_SendMsg(wfemp.getNo(), title, mytemp, null, BP.WF.SMSMsgType.CC, list.getFK_Flow(), list.getFK_Node(), list.getWorkID(), list.getFID());
				}
			}

			//写入系统消息.
			this.HisWorkNode.addMsg(SendReturnMsgFlag.CCMsg, ccMsg);

			//写入日志.
			this.HisWorkNode.AddToTrack(ActionType.CC, WebUser.getNo(), WebUser.getName(), this.getHisNode().getNodeID(), this.getHisNode().getName(), ccMsg, this.getHisNode());

		}
	}
}