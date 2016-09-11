<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WF/head/head2.jsp"%>
<link href="<%=Glo.getCCFlowAppPath() %>DataUser/Style/Table0.css" rel="stylesheet" type="text/css" />

</head>
<body>
		<form class="am-form" id="form" method="post" action="">
			<table border=1px align=center width='100%'>
				<Caption ><div class='' >模块</div></Caption>
				<%
					int num = Integer.parseInt(request.getParameter("num"));
					String title = request.getParameter("title");
				%>
				<tr><td>模块标题</td>
					<td>
						<input type="text" id="title" class="am-input-sm"
							value="<%=title%>" style="width:100%">
					</td>
					<td>*必填，不可重复，注意按标题顺序来填写内容!</td>
				</tr>

				<%
					for (int i = 0; i < num; i++) {
				%>
				<tr><td>模块内容</td>
					<td>
						<select data-am-selected="{btnSize: 'sm'}" id="selectType<%=i %>" style="width:100%">
							<option value="text">纯文本</option>
							<option value="htmla">超链接</option>
							<option value="table">table</option>
							<option value="form">表单</option>
						</select>
					</td>
				</tr>
				<tr><td>文本内容</td>
					<td colspan="2">
						<textarea id="textarea<%=i %>" rows="5" style="width:100%" placeholder="请使用逗号来分隔要显示的内容"></textarea>
					</td>
				</tr>
				
				<tr><td>请输入列</td>
					<td>
						<input type="text" id="col<%=i%>" class="am-input-sm" style="width:100%">
					</td>
					<td class="am-hide-sm-only am-u-md-6">*共12列，输入所占几列</td>
				</tr>
				<%
					}
				%>
			<tr><td>
				<A href="javascript:void(0)" onclick="GenTemplete()" id="ri"
					target="right"><button type="button"
						class="am-btn am-btn-success" style="background: #4D77A7;color: #FFF;padding: 2px 3px 2px 3px;margin: 3px 2px 3px 2px;">生成模块</button></A>
				</td>
			</tr>
			</table>
		</form>
		<script type="text/javascript">
		function GenTemplete() {
			var title=$("#title").val();
			var num=<%=num%>;
			var str='';
			for(var i=0;i<num;i++)
			{
				str+='&textarea'+i+'='+$("#textarea"+i).val();
				str+='&selectType'+i+'='+$("#selectType"+i).get(0).selectedIndex;
				str+='&col'+i+'='+$("#col"+i).val();
			}
			$("#form").attr("action","<%=basePath%>WF/Jflow.jsp?num=" 
					+ <%=num%> + "&title="+ title+"&"+str);
			$("#form").submit();
		}
</script>
</body>
</html>