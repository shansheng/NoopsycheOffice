<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>
<%

	WinOpenEUIModel wEui=new WinOpenEUIModel(request, response);
	wEui.Page_Load();
	
	
	MyFlowModel myFlow = new MyFlowModel(request, response);
	myFlow.initFlow();
	if (!myFlow.getIsContinue()) {
		return;
	}
	
	double height=1200;
	double width=1000;
	double FromH=Double.parseDouble(myFlow.getFromH()==null?"1":myFlow.getFromH());
	double FromW=Double.parseDouble(myFlow.getFromW()==null?"1":myFlow.getFromW());
	if(FromH<=1200){
		height=1200;
	}else{
		height=FromH;
	}
	if(FromW<=1000){
		width=1000;
	}else{
		width=FromW;
	}
	
%>
<link rel="stylesheet" type="text/css" href="<%=basePath%>DataUser/Style/MyFlow.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>DataUser/Style/Table0.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>WF/Style/FormThemes/WinOpenEUI.css" />
<script type="text/javascript" src="<%=basePath%>DataUser/PrintTools/LodopFuncs.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/MyFlow.js"></script>
<script type="text/javascript" src="<%=basePath%>DataUser/Scripts/<%=myFlow.FrmID %>_Self.js"></script>
<script type="text/javascript">
function newTo(url) {
    //window.location.href = url;
    window.name = "dialogPage"; window.open(url, "dialogPage")
}

function ReturnVal(ctrl, url, winName) {
    if (ctrl && ctrl.value != "") {
        if (url.indexOf('?') > 0)
            url = url + '&CtrlVal=' + ctrl.value;
        else
            url = url + '?CtrlVal=' + ctrl.value;
    }
    if (typeof self.parent.TabFormExists != 'undefined') {
        var bExists = self.parent.TabFormExists();
        if (bExists) {
            self.parent.ChangTabFormTitleRemove();
        }
    }
    if (window.ActiveXObject) {
        var v = window.showModalDialog(url, winName, 'scrollbars=yes;resizable=yes;center=yes;minimize:yes;maximize:yes;dialogHeight: 650px; dialogWidth: 850px; dialogTop: 100px; dialogLeft: 150px;');
        if (v == null || v == '' || v == 'NaN') {
            return;
        }
        ctrl.value = v;
    }
    else {
    
        	var v = window.showModalDialog(url, '', 'scrollbars=yes;resizable=yes;center=yes;resizable:no;minimize:yes;maximize:yes;dialogHeight: 650px; dialogWidth: 550px; dialogTop: 50px; dialogLeft: 650px;');
        	 if (v == null || v == '' || v == 'NaN') {
                 return;
             }
        	
        	ctrl.value = v;
        	 
    }
    
    if (typeof self.parent.TabFormExists != 'undefined') {
        var bExists = self.parent.TabFormExists();
        if (bExists) {
            self.parent.ChangTabFormTitle();
        }
    }
     
    return;
}
	//按钮点击后置灰
	function setGray()
	{
		try{
			var btnDis=document.getElementById('Btn_Send');
			btnDis.disabled = true;
			//setTimeout("btnDis.disabled=false",3000);
		}catch(e){}
	}
	function Send(){
		setGray();
		$.ajax({
			cache: true,
			type: "POST",
			url:"<%=basePath%>WF/MyFlow/SendWork.do",
			data:$('#mainFrom').serialize(),
		    success: function(data) {
		    	parseJson(data);
		    }
		});
	}
	
	function Save(){
		$.ajax({
				cache: true,
				type: "POST",
				url:"<%=basePath%>WF/MyFlow/SaveWork.do",
				data : $('#mainFrom').serialize(),
				success : function(data) {
					 /* $('#Btn_Save').popover({
						 content:'保存成功'
					 });
					 setTimeout("codefans()",3000); */
					 parseJson(data);
			}
		});
	}
	function codefans()
	{
		$('#Btn_Save').popover('close');
	}

	function parseJson(data) {
		var obj = eval("(" + data + ")");
		if (obj.type == 'data') {
			var rows = obj.rows;
			for ( var key in rows) {
				var comp = $("#" + key + "");
				if (comp == null) {
					continue;
				}
				if (key.indexOf("TB_") != -1) {
					var input_text = $("input[id=" + key + "]");
					if (input_text == null) {
						comp.text(rows[key]);
					} else {
						comp.attr("value", rows[key]);
					}
				} else if (key.indexOf("DDL_") != -1) {
					comp.attr("value", rows[key]);
				} else if (key.indexOf("CB_") != -1) {
					if (rows[key] == '0') {
						comp.attr("checked", false);
					} else {
						comp.attr("checked", true);
					}
				}
			}
		} else if (obj.type == 'alert') {
			alert(obj.action);
		} else if (obj.type == 'url') {
			window.location.href = obj.action;
		} else if (obj.type == 'script') {
			eval(obj.action);
		} else if (obj.type == 'flowMsg') {
			document.getElementById("Message").innerHTML = obj.action;
		}
	}
	//然浏览器最大化.
	function ResizeWindow() {
		if (window.screen) { //判断浏览器是否支持window.screen判断浏览器是否支持screen     
			var myw = screen.availWidth; //定义一个myw，接受到当前全屏的宽     
			var myh = screen.availHeight; //定义一个myw，接受到当前全屏的高     
			window.moveTo(0, 0); //把window放在左上脚     
			window.resizeTo(myw, myh); //把当前窗体的长宽跳转为myw和myh     
		}
	}
	window.onload = ResizeWindow();

	function Change() {
		var btn = document.getElementById('Btn_Save');
		if (btn != null) {
			if (btn.value.valueOf('*') == -1)
				btn.value = btn.value + '*';
		}
	}
	
	function ReqDDL(ddlID) {
	    var v = document.getElementById('DDL_' + ddlID).options.length;
	    if (v == null) {
	        alert('没有找到ID=' + ddlID + '的下拉框控件.');
	    }
	    return v;
	}
	
	$(function () {
        $("#Btn_Save").click(function () {
        	//$("#Btn_Save").append($("#dv"));
        	var left = $("#Btn_Save").position().left;
			var top = $("#Btn_Save").position().top+35;
			$("#dv").css({ position:'absolute',  top:top,left:left});   
        	//$("#dv").css();
            $("#dv").slideToggle(200);
            setTimeout(function () {
                $("#dv").hide(200);
            }, 2000);
        });
    });
	
	
	
	$(function () {
        $('#loading-mask').fadeOut();

        //处理轨迹标签，added by liuxc,2016-2-25
        var gw = $(".tabs-title:contains('轨迹')");
        if(gw.length > 0){
            gw.parent().parent().click(function(){
                //if($("#trackIframe").attr("src") == "Loading.htm"){
                    $("#trackIframe").attr("src", "./WorkOpt/OneWork/Track.jsp?WorkID=<%=wEui.getWorkID() %>&FK_Flow=<%=wEui.getFK_Flow() %>&FID=<%=wEui.getFID() %>&FK_Node=<%=wEui.getFK_Node() %>&s=" + Math.random());
               // }
            });
        }

        //暂时处理公文不能加载问题，added by liuxc,2016-2-21
        var isword = <%=wEui.getIsWordTab() %>;
        var iswordfront = <%=wEui.getIsOfficeTabFront() %>;

        if(isword){
            if(iswordfront){
                chageURL();
            }
            else{
                gw = $(".tabs-title:contains('<%=wEui.getOfficeTabName() %>')");
                if(gw.length > 0){
                    gw.parent().parent().click(function(){
                       // if($("#officeIfream").attr("src") == "Loading.htm"){
                            chageURL();
                        //}
                    });
                }
            }
        }
    });

    function chageURL() {
        var url = "../WF/WorkOpt/WebOffice.jsp?FK_Node=<%=wEui.getFK_Node() %>&FID=<%=wEui.getFID() %>&WorkID=<%=wEui.getWorkID() %>&FK_Flow=<%=wEui.getFK_Flow() %>&DoType=<%=wEui.getDoType() %>";
        $("#officeIfream").attr("src", url);
    }   
</script>
</head>
<body class="easyui-layout body" topmargin="0" leftmargin="0" onkeypress="NoSubmit(event);" >
	 <div id="mainPanel" region="center" border="false" class="mainPanel">
	 	<%if(wEui.getIsTab()) {%>
	 		<div id="tabPanle" class="easyui-tabs" fit="true">
				<%if(wEui.getIsWordTab() && wEui.getIsOfficeTabFront()){ %>
					<div title="<%=wEui.getOfficeTabName() %>" data-options="tools:'#p-tools'">
		                <iframe scrolling="auto" frameborder="0" id="officeIfream"></iframe>
		            </div>
	            <%}%>
				<div title="表单" id="freeForm">
                <% } %>
	                <div id="dv" class="shade">
				         <div style="font-weight: bold; font-size:14px; ">
				                                    操作成功!
				         </div>
				    </div>
					<div style='height:<%=myFlow.getFromH()%>px;width:1000px;margin:0 auto;'>
					    <!-- 按钮工具栏 -->
						<div id='toolBar' class="topBar" align="left" >
								<jsp:include page="./SDKComponents/Toolbar.jsp">
									<jsp:param value="<%=myFlow.workId%>" name="WorkID" />
									<jsp:param value="<%=myFlow.fk_flow%>" name="FK_Flow" />
									<jsp:param value="<%=myFlow.fk_node%>" name="FK_Node" />
									<jsp:param value="<%=myFlow.fid%>" name="FID" />
									<jsp:param value="<%=myFlow.getHisFormType()%>" name="FormType" />
								</jsp:include>
							</div>
						<div class="Message" id="Message" style="word-break:break-all;padding-left:30px;width:900px;"></div>
						<form id="mainFrom" method="post">
							<input type="hidden" name="WorkID" value="<%=myFlow.workId%>" /> <input
								type="hidden" name="FK_Flow" value="<%=myFlow.fk_flow%>" /> <input
								type="hidden" name="FK_Node" value="<%=myFlow.fk_node%>" /> <input
								type="hidden" name="FID" value="<%=myFlow.fid%>" />
								<div id="divCCForm1" style=" position: relative !important; width: <%=width%>px; height: <%=height%>px;background-color: white;margin: 0 auto;">
								<%
								if(myFlow.getHisFormType()){
									%>
									<%=myFlow.selfFromPub %>
									<%
									
								}else{
									%>
									<jsp:include page="./SDKComponents/En.jsp">
										<jsp:param value="<%=myFlow.workId%>" name="WorkID" />
										<jsp:param value="<%=myFlow.fk_flow%>" name="FK_Flow" />
										<jsp:param value="<%=myFlow.fk_node%>" name="FK_Node" />
										<jsp:param value="<%=myFlow.fid%>" name="FID" />
										<jsp:param value="<%=myFlow.getHisFormType()%>" name="FormType"/>
									</jsp:include>
									<%
								}
								%>
							</div>
						</form>
					</div>
                <% if (wEui.getIsTab()){ %>
            	</div>
	
		       <%if(wEui.getIsWordTab() && !wEui.getIsOfficeTabFront()){ %>
			       <div title="<%=wEui.getOfficeTabName() %>" data-options="tools:'#p-tools'">
		               <iframe scrolling="auto" frameborder="0" id="officeIfream" ></iframe>
		           </div>
		        <%}if (wEui.getDoType()!= "View"){%>
		            <div title="轨迹">
		                <iframe scrolling="auto" frameborder="0" id="trackIframe" style="width: 100%;height: 100%;" ></iframe>
		            </div>
	            <%}%>
		      </div>
	        <% } %>
	    </div>
	    <% if (wEui.getIsTab()) { %>
	    <div id="p-tools">
	        <a href="javascript:void(0)" class="icon-mini-refresh" onclick="chageURL()"></a>
	    </div>
	    <% } %>
	
</body>
</html>