//package cn.jflow.common.model;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.net.URLEncoder;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import BP.DA.DBAccess;
//import BP.DA.DataRow;
//import BP.DA.DataSet;
//import BP.DA.DataTable;
//import BP.En.Attr;
//import BP.En.Attrs;
//import BP.Sys.OSModel;
//import BP.Sys.PubClass;
//import BP.Sys.SystemConfig;
//import BP.Tools.DataTableConvertJson;
//import BP.Tools.StringHelper;
//import BP.WF.DeliveryWay;
//import BP.WF.Dev2Interface;
//import BP.WF.Node;
//import BP.WF.Nodes;
//import BP.WF.SendReturnObjs;
//import BP.WF.TurnToDeal;
//import BP.WF.Work;
//import BP.WF.WorkNode;
//import BP.WF.Data.GERpt;
//import BP.WF.Entity.GenerWorkFlow;
//import BP.WF.Entity.GenerWorkFlowAttr;
//import BP.WF.Entity.GenerWorkerList;
//import BP.WF.Entity.GenerWorkerListAttr;
//import BP.WF.Entity.GenerWorkerLists;
//import BP.WF.Template.Cond;
//import BP.WF.Template.CondAttr;
//import BP.WF.Template.CondModel;
//import BP.WF.Template.NodeAttr;
//import BP.WF.Template.NodeStations;
//import BP.WF.Template.Selector;
//import BP.WF.Template.SelectorModel;
//import BP.WF.Template.TransferCustom;
//import BP.WF.Template.TransferCustoms;
//import BP.WF.Template.TurnTo;
//import BP.WF.Template.TurnTos;
//import BP.Web.WebUser;
//import cn.jflow.system.ui.core.Button;
//import cn.jflow.system.ui.core.CheckBox;
//
//
//public class DTC extends BaseModel{
//	
//	public StringBuffer Pub1=null;
//	public StringBuilder Left = null;
//	private long WorkId;
//	HttpServletRequest request = null;
//	HttpServletResponse response = null;
//	public DTC(HttpServletRequest request, HttpServletResponse response) {
//		super(request, response);
//		Pub1=new StringBuffer();
//		Left=new StringBuilder();
//
//		
//	}
//	 protected void Page_Load()
//     {
//         String method = request.getParameter("method");
//         String re = "";
//       
//         String sql = "";
//
//         if (method!=null) return;
//
//         try
//         {
//        	  String flowno = request.getParameter("flowNo");
//        	  String wid = request.getParameter("workId");
//             if(("getflows").equals(method)){
//                
//                     sql =
//                         "SELECT f.NO,f.NAME,fs.NAME SORT FROM WF_Flow f INNER JOIN WF_FlowSort fs ON fs.No = f.FK_FlowSort ORDER BY fs.Idx";
//                     re = DataTableConvertJson.DataTable2Json(DBAccess.RunSQLReturnTable(sql));
//                    }
//              else if("startflow".equals(method)){
//            	 
//            	   if (StringHelper.isNullOrEmpty(flowno))
//                   {
//                       re = returnJson(false, "flowNo不能为空", false);
//                   }
//            	   else
//                   {
//                       String msg = StartFlow(flowno);
//                       if (StringHelper.isNullOrEmpty(flowno))
//                       {
//                           re = returnJson(false, "发起流程失败：" + msg, false);
//                       }
//                       else
//                       {
//                           re = returnJson(true, Long.toString(WorkId), false);
//                       }
//                   }
//             }
//              else if("settransfer".equals(method)){
//            	 flowno = request.getParameter("flowNo");
//               
//                 long workId = 0;
//                 if (flowno!=null)
//                 {
//                     re = returnJson(false, "flowNo不能为空", false);
//                 }
//                 else if (wid!=null )
//                 {
//                	 //|| Long.parseLong(wid)
//                	 try{
//                		 workId = Long.parseLong(wid);
//                	 }catch (Exception e)
//                	 {
//                		 
//                		 re = returnJson(false, "workId参数格式不正确", false);
//                	 }
//                 }
//                 else
//                 {
//                     GenerWorkFlow gwf = new GenerWorkFlow();
//                     if (gwf.Retrieve(GenerWorkFlowAttr.WorkID, workId) == 0)
//                     {
//                         re = returnJson(false, "workId参数不正确，未找互此WorkId的发起流程", false);
//                     }
//                     else if (gwf.getFK_Flow() != flowno)
//                     {
//                         re = returnJson(false, "workId参数不正确，此WorkId的流程与所选流程不匹配", false);
//                     }
//                     else
//                     {
//                         TransferCustoms tcs = new TransferCustoms(workId);
//                         GenerWorkerLists gwls = new GenerWorkerLists(workId);
//                         Nodes nodes = new Nodes();
//                         nodes.Retrieve(NodeAttr.FK_Flow, flowno, "Step");
//                         TransferCustom tc = null;
//                         re = "{\"workid\":" + workId + ", \"nodes\":[";
//                         String s ="";
//                         DataSet ds = null;
//                         DataTable dtEmp = null;
//                         DataTable dtDept = null;
//                         DataRow rd = null;
//                         String deptName = null;
//                         String sWorkers = null;
//
//                         for(Node node : nodes.ToJavaList())
//                         {
//                             if (node.getIsStartNode() == true)
//                             {
//                                 re += "{\"id\": " + node.getNodeID() + ", \"name\": \"" + node.getName() +
//                                       "\", \"empNos\":\"" +
//                                       gwf.getStarter() + "\", \"empNames\":\"" + gwf.getStarterName() +
//                                       "\",\"isPass\": true,\"plan\":\"\",\"rdt\":\"" + gwf.getRDT() +
//                                       "\"},";
//                                 continue;
//                             }
//
//                             GenerWorkerList gwl =(GenerWorkerList)gwls.GetEntityByKey(GenerWorkerListAttr.FK_Node
//                            		 ,node.getNodeID());
//
//                             if (gwl == null)
//                             {
//                                 /* 还没有到达的节点. */
//                                 tc =(TransferCustom)tcs.GetEntityByKey(GenerWorkerListAttr.FK_Node
//                                     , node.getNodeID());
//                              if (tc == null)
//                                     tc = new TransferCustom();
//                                 re += "{\"id\": " + node.getNodeID() + ", \"name\": \"" + node.getName() +
//                                       "\", \"empNos\":\"" +
//                                       tc.getWorker() + "\", \"empNames\":\"" + tc.getWorkerName() +
//                                       "\",\"isPass\": false,\"plan\":\"" +
//                                       tc.getPlanDT() + "\",\"rdt\":\"\"},";
//                                 continue;
//                             }
//
//                             //已经走完节点
//                             re += "{\"id\": " + node.getNodeID() + ", \"name\": \"" + node.getName() + "\", \"empNos\":\"" +
//                                   gwl.getFK_Emp() + "\", \"empNames\":\"" + gwl.getFK_EmpText() +
//                                   "\",\"isPass\": true,\"plan\":\"" + gwl.getSDT() + "\",\"rdt\":\"" +
//                                   gwl.getRDT() + "\"},";
//                         }
//
//                         re = re.trim() + "]}";
//                         re = returnJson(true, re, true);
//                     }
//                 }
//                 }
//                 
//                 else if("findems".equals(method)){
//                	 String nid = request.getParameter("nodeId");
//                     wid = request.getParameter("workId");
//
//                     if (StringHelper.isNullOrEmpty(nid))
//                     {
//                         re = "[]";// ReturnJson(false, "nodeid不能为空", false);
//                     }
//                     else if (StringHelper.isNullOrEmpty(wid))
//                     {
//                    	 Long.parseLong(wid);
//                         re = "[]";// ReturnJson(false, "workId参数格式不正确", false);
//                     } else{
//                         GenerWorkFlow gwf = new GenerWorkFlow();
//                         Node node = null;
//                         if (gwf.Retrieve(GenerWorkFlowAttr.WorkID, getWorkID()) == 0)
//                         {
//                             re = "[]";// ReturnJson(false, "workId参数不正确，未找互此WorkId的发起流程", false);
//                         }
//                         else
//                         {
//                             node = new Node(Integer.parseInt(nid));
//                             re = "[";
//                             DataSet ds = null;
//                             DataTable dtEmp = null;
//                             DataTable dtDept = null;
//                             DataRow rd = null;
//                             String deptName = null;
//
//                             ds = BP.WF.Dev2Interface.WorkOpt_AccepterDB(node.getNodeID(), getWorkID(),getFID());
////                             dtEmp = ds.Tables["Port_Emp"];
//                             for (DataTable t :ds.Tables)
//                     		{
//                     			if("Port_Emp".equals(t.TableName))
//                     			{
//                     				//
//                     				t.getValue(1, "no");
//                     			}
//                     					
//                     		}
////               //              dtEmp = ds.Tables["Port_Emp"];
//                             for (DataTable t :ds.Tables)
//                      		{
//                      			if("Port_Dept".equals(t.TableName))
//                      			{
//                      				
//                      				t.getValue(1, "no");
//                      			}
//                      					
//                      		}
//                             
//
//                             for(DataRow r : dtEmp.Rows)
//                             {
//                                 if (dtEmp.Columns.contains("DeptName"))
//                                 {
//                                     deptName = r.getValue("DeptName").toString();
//                                 }
//                                 else
//                                 {
//                                     rd = dtDept.select(String.format("No='{0}'", r.getValue("FK_Dept"))).get(0);
//                                     deptName = rd.getValue("Name").toString();
//                                 }
//
//                                 re += "{\"no\": \"" + r.getValue("No") + "\", \"name\": \"" + r.getValue("Name") +
//                                     "\", \"dept\":\"" + deptName + "\"},";
//                             }
//                         }
//
//                         re = re.trim().s(',') + "]";
//                     }
//                 }else if("savecfg".equals(method)){
//                	 WorkId = Long.parseLong(request.getParameter("workid"));
//                     String[] data = URLEncoder.encode(request.getParameter("data")).split(new[] { '|');
//                    		
//                     String[] ns = null;
//                     int nodeid = 0;
//                     TransferCustom tfc = null;
//                     int i = 0;
//                     if (WorkId == 0)
//                     {
//                         re = returnJson(false, "workid参数不正确", false);
//                     }
//                     else
//                     {
//                         //删除之前保存的
//                         TransferCustoms tfcs = new TransferCustoms(getWorkID());
//                         tfcs.Delete();
//
//                         for(String d : data)
//                         {
//                             ns = d.split(flowno, '_');
//                             if (ns.length != 4 ||ns[1].length() == 0)
//                            	 Integer.parseInt(ns[0],nodeid);
//                                 continue;
//
//                             tfc = new TransferCustom();
//                             tfc.setMyPK(nodeid + "_" + WorkId);
//                             tfc.setWorkID(WorkId);
//                             tfc.setFK_Node(nodeid);
//                             tfc.setWorker(ns[1]);
//                             tfc.setWorkerName(ns[2]);
//                             tfc.setPlanDT(ns[3]);
//                             tfc.setTodolistModel(0);
//                             tfc.setIdx(++i);
//                             tfc.Save();
//                         }
//
//                         re = returnJson(true, "保存成功！", false);
//                     }
//                 }
//             } catch (Exception ex)
//         {
//                 re = returnJson(false, ex.getMessage(), false);
//             }
// 
////         response.Charset = "UTF-8";
////         response.ContentEncoding = System.Text.Encoding.UTF8;
////         response.ContentType = "text/html";
////         response.Expires = 0;
////         response.Write(re);
////         response.End();
//     }
//	/// <summary>
//     /// 发起一个流程，此流程的开始节点要配置至少一个可发起人员
//     /// </summary>
//     /// <param name="flowNo">流程编号</param>
//     /// <returns></returns>
//     public String StartFlow(String flowNo)
//     {
//         String msg = "";
//         SendReturnObjs sres = null;
//
//         //1.获取流程发起人列表
//         String sql = Dev2Interface.GetFlowStarters(flowNo);
//         DataTable dtFlowStarters = BP.DA.DBAccess.RunSQLReturnTable(sql);
//
//         if (dtFlowStarters == null || dtFlowStarters.Rows.size() == 0)
//         {
//             msg = String.format("流程{0}开始节点未设置处理人。", flowNo);
//             BP.Sys.Glo.WriteLineError(msg);
//             return msg;
//         }
//
//         String flowStarter = dtFlowStarters.Rows.get("No").toString();
//
//         //记录当前登录人账号，在处理完当前节点工作后，再切换回当前登录人
//         String currEmp = BP.Web.WebUser.getNo();
//
//         if (currEmp != flowStarter)
//         {
//             BP.Web.WebUser.Exit();
//             Dev2Interface.Port_Login(flowStarter);
//         }
//
//         long workID = 0;
//         try
//         {
//             //2.发起流程
//             workID = Dev2Interface.Node_CreateStartNodeWork(flowNo, null, null, flowStarter);
//
//             //3.发送get
//             sres = Dev2Interface.Node_SendWork(flowNo, workID, null, null, 0, null, WebUser.getNo(), WebUser.getName(), WebUser.getFK_Dept(), WebUser.getFK_DeptName(), null);
//
//             if (currEmp != flowStarter)
//             {
//                 BP.Web.WebUser.Exit();
//
//                 if (!StringHelper.isNullOrEmpty(currEmp))
//                     Dev2Interface.Port_Login(currEmp);
//             }
//
//             WorkId = sres.getVarWorkID();
//             return null;
//         }
//         catch (Exception ex)
//         {
//             msg = String.format("自动发起流程编号为{0}的工作[WorkID={1}]失败，错误原因：{2}", flowNo, workID, ex.getMessage());
//             BP.Sys.Glo.WriteLineError(msg);
//             return msg;
//         }
//     }
//
//     /// <summary>
//     /// 生成返给前台页面的JSON字符串信息
//     /// </summary>
//     /// <param name="success">是否操作成功</param>
//     /// <param name="msg">消息</param>
//     /// <param name="haveMsgJsoned">msg是否已经JSON化</param>
//     /// <returns></returns>
//     private String returnJson(Boolean success, String msg, Boolean haveMsgJsoned)
//     {
//         String kh = haveMsgJsoned ? "" : "\"";
//         return "{\"success\":" + success.toString().toLowerCase() + ",\"msg\":" + kh + (haveMsgJsoned ? msg : msg.replace("\"", "'")) +
//                kh + "}";
//     }
//   
// }
//	
//
//
//
