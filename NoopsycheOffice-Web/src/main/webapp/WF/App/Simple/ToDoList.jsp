<%@page import="BP.WF.Glo"%>
<%@page import="BP.DA.DataRow"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.WF.Dev2Interface"%>
<%@page import="BP.DA.DataTable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办</title>
</head>
<body>
<h2>待办 (<%=Dev2Interface.getTodolist_EmpWorks() %>) </h2>
<%
   
   // 输出结果
   %> <table border="1" widht="90%" >
   <tr>
   <th>是否读取?</th>
   <th>标题</th>
   <th>流程</th>
   <th>发起时间</th>
   <th>发起人</th>
   <th>停留节点</th>
   <th>(发送/抄送)人</th>
   <th>流程备注</th>

   <th>类型</th>
   </tr>
      <%
      //获取待办。
      DataTable dt = Dev2Interface.DB_GenerEmpWorksOfDataTable();
      String basePath = Glo.getCCFlowAppPath();
	  if(null != dt || dt.Rows.isEmpty()){
		  try{
	    // 生成timke 方式浏览器打开旧的界面，方式界面缓存.      
	      String t = DataType.getCurrentDataTimeCNOfShort();
	      int size = dt.Rows.size();
	      for(int i = 0; i< size; i++){
	     	 DataRow dr = dt.Rows.get(i);
	     	 if(null == dr || dr.size() == 0){
	     		 continue;
	     	 }
	         //流程引擎的参数。
	         Object paras = dr.getValue("AtPara");
	         if (paras == null || paras.equals("")){
	        	 paras = "0";
	         }
	             
        	 String FK_Flow = dr.getValue("FK_Flow") == null ? "" : dr.getValue("FK_Flow").toString();
	    	 String FK_Node = dr.getValue("FK_Node") == null ? "" : dr.getValue("FK_Node").toString();
	    	 String WorkID = dr.getValue("WorkID") == null ? "0" : dr.getValue("WorkID").toString();
	    	 String FID = dr.getValue("FID") == null ? "0" : dr.getValue("FID").toString();
	    	 String Title = dr.getValue("Title") == null ? "" : dr.getValue("Title").toString();
	    	 String RDT = dr.getValue("RDT") == null ? "" : dr.getValue("RDT").toString();
	    	 String StarterName = dr.getValue("StarterName") == null ? "" : dr.getValue("StarterName").toString();
	    	 String Sender = dr.getValue("Sender") == null ? "" : dr.getValue("Sender").toString();
	    	 String FlowNote = dr.getValue("FlowNote") == null ? "" : dr.getValue("FlowNote").toString();
	    	 String NodeName = dr.getValue("NodeName") == null ? "" : dr.getValue("NodeName").toString();
	    	 String FlowName = dr.getValue("FlowName") == null ? "" : dr.getValue("FlowName").toString();
	    	 
	      	//这个工作是否读取了？根据状态开发人员可以个性化的显示工作读取未读取效果.
	        int isRead = Integer.parseInt(dr.getValue("IsRead").toString());
	        %>
	        <tr>
	       <% if (isRead == 0)
	          {
	          %>
	          <td><b>未读</b></td>
	          <td><b> <a target="_blank" href='<%=basePath %>WF/MyFlow.jsp?FK_Flow=<%=FK_Flow %>&FK_Node=<%=FK_Node %>&WorkID=<%=WorkID %>&FID=<%=FID %>&IsRead=<%=isRead%>&Paras=<%=paras.toString() %>&T=<%=t %>' ><%=Title%> </a>  </b></td>
	        <% }
	          else
	          { %>
	          <td>已读</td>
	          <td><a target="_blank" href='<%=basePath %>WF/MyFlow.jsp?FK_Flow=<%=FK_Flow %>&FK_Node=<%=FK_Node %>&WorkID=<%=WorkID %>&FID=<%=FID %>&IsRead=<%=isRead%>&Paras=<%=paras.toString() %>&T=<%=t %>' ><%=Title%> </a>  </td>
	        <%} %>
	
	        <td><%=FlowName%></td>
	        <td><%=RDT%></td>
	        <td><%=StarterName%></td>
	        <td><%=NodeName%></td>
	
		   <td><%=Sender%></td>
		
		   <td><%=FlowNote%></td>
	
	
	        <% if (paras.toString().contains("IsCC")) { %>
	
	        <td>抄送</td>
	
	        <% } else { %>
	        
	        <td>发送</td>
	        
	        <%} %>
	
	
	        </tr>
	   <% 
	   
	         } 
	      }catch(Exception ex){
	    	  ex.printStackTrace();
	        }
   
	  }%> 
   </table>
</body>
</html>