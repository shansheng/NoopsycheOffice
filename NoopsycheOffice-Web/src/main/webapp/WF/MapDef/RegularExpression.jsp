<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%@page import="cn.jflow.model.wf.mapdef.RegularExpressionModel"%>
<%
	RegularExpressionModel reg=new RegularExpressionModel(request,response);
	reg.load();
	String FK_MapData = request.getParameter("FK_MapData");
	String ExtType = request.getParameter("ExtType");
	String RefNo = request.getParameter("RefNo");
	String OperAttrKey = request.getParameter("OperAttrKey");
%>
<head>
    <script type="text/javascript" >
        function NoSubmit(ev) {
            if (window.event.srcElement.tagName == "TEXTAREA")
                return true;

            if (ev.keyCode == 13) {
                window.event.keyCode = 9;
                ev.keyCode = 9;
                return true;
            }
            return true;
        }
        
        function BindRegularExpressionEdit_Click(){
			//获取信息
			var map1="";
			var map2="";
			$("input[type=text]").each(function(){
			    map1 += ($(this).attr("id")+"@"+$(this).val()+";");
			});
			$("textArea").each(function(){
				map2 += ($(this).attr("id")+"@"+$(this).val()+";");
			});
			var mapx = map1+"-"+map2;
        	$.ajax({
        		url:'<%=basePath%>WF/RegularExpression/ActionBtn_Click.do',
        		type:'post', //数据发送方式
        		dataType:'json', //接受数据格式
        		data:{mapx:mapx,FK_MapData:'<%=FK_MapData%>',RefNo:'<%=RefNo%>',ExtType:'<%=ExtType%>'},
        		async: false ,
        		error: function(data){},
        		success: function(data){
        			var json = eval("("+data+")");
        			if(json.success){
        				//keys = json.msg;
        			}else{
        			}
        		}
        	});
        }
        
        function btn_SaveReTemplete_Click(){
        	var LBReTemplete = $("#LBReTemplete").val();
        	var value = $("#LBReTemplete").find("option:selected").text();
        	$.ajax({
        		url:'<%=basePath%>WF/RegularExpression/btn_SaveReTemplete_Click.do?LBReTemplete='+LBReTemplete,
        		type:'post', //数据发送方式
        		dataType:'json', //接受数据格式
        		data:{FK_MapData:'<%=FK_MapData%>',RefNo:'<%=RefNo%>'},
        		async: false ,
        		error: function(data){},
        		success: function(data){
        			var json = eval("("+data+")");
        			if(json.success){
        				//keys = json.msg;
        			}else{
        			}
        		}
        	});
        }
        
        function Excel_Click(){
        	var url = "<%=basePath%>WF/MapDef/RegularExpression.jsp?s=3&FK_MapData=" + '<%=FK_MapData%>' + "&RefNo=" + '<%=RefNo%>' + "&ExtType=" +
            '<%=ExtType%>' + "&OperAttrKey=" + '<%=OperAttrKey%>' + "&DoType=templete";
        	window.location.href = url;
        }
        function back(url){
        	url = "<%=basePath%>WF/MapDef/"+url;
        	window.location.href = url;
        }
</script>
</head>
<body>
<%=reg.Pub1.toString()%>
</body>
<SCRIPT>
	var src= $("img").attr("src");
	src = "../.."+src;
	$("img").attr("src",src);
</SCRIPT>
</html>