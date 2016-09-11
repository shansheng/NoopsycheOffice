<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="BP.Web.WebUser"%>
<%@page import="BP.Web.GuestUser"%>
<%@page import="BP.DA.DataType"%>
<%@page import="BP.WF.Node"%>
<%@page import="cn.jflow.common.model.WebOfficeModel" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";
	
	String fk_node = request.getParameter("FK_Node")==null?"-1":request.getParameter("FK_Node");
	int FK_Node=Integer.valueOf(fk_node);
	
	String fid = request.getParameter("FID")==null?"0":request.getParameter("FK_Node");
	int FID=Integer.valueOf(fid);
	
	String workId = request.getParameter("WorkID")==null?"0":request.getParameter("WorkID");
	long WorkID=Long.valueOf(workId);
	 
	String FK_Flow = request.getParameter("FK_Flow")==null?"":request.getParameter("FK_Flow");
	
	boolean IsTrueTH = false;
	boolean ReadOnly = false;
	boolean IsCheckInfo = false;
	boolean IsSavePDF = false;
	boolean IsMarks = false;
	boolean IsLoadTempLate = false;
	
	String HeBing = "";
	String IsTrueTHTemplate = "";
	String OfficeTemplate = null;
	String UserName = "Guest".equals(WebUser.getNo())?GuestUser.getName():WebUser.getName();
	
	Node node = new Node(FK_Node);
	String NodeInfo = node.getName() + ":" + WebUser.getName() + "  日期:" + DataType.dateToStr(new Date(), "yyyy-MM-dd HH:mm:ss");
	
	WebOfficeModel model = new WebOfficeModel(basePath, FK_Node, FID, WorkID,  FK_Flow, IsTrueTH, IsTrueTHTemplate,
			 UserName, HeBing, ReadOnly, IsCheckInfo, NodeInfo, IsSavePDF, IsMarks, OfficeTemplate, IsLoadTempLate, request,  response);
	model.init();
%>
<!DOCTYPE HTML>
<html>
<head>
<base target="_self">
<title>公文正文</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<style type="text/css">
.btn {
	border: 0;
	background: #4D77A7;
	color: #FFF;
	font-size: 12px;
	padding: 6px 10px;
	margin: 5px;
}
</style>
<link rel="stylesheet" type="text/css" href="<%=basePath %>WF/Scripts/easyUI/themes/icon.css"  />
<link rel="stylesheet" type="text/css" href="<%=basePath %>WF/Scripts/easyUI/themes/default/easyui.css"  />
<link rel="stylesheet" type="text/css" href="<%=basePath %>WF/Scripts/jBox/Skins/Blue/jbox.css"/>

<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>WF/Scripts/jBox/jquery.jBox-2.3.min.js" ></script>
<script type="text/javascript" src="<%=basePath%>WF/Comm/JScript.js"></script>

<script type="text/javascript">
var isShowAll = false;
var webOffice = null;
var strTimeKey;
var isOpen = false;
var isInfo = true;
var marksType = "doc,docx";
//初始化公文
function InitOffice() {
    webOffice = document.all.WebOffice1;

    if ($("#fileName").val() != "") {
        if (<%=model.isIsLoadTempLate()%>)
            OpenWeb("0");
        else
            OpenWeb("1");
    }
    EnableMenu();
}
//设置当前操作用户
function SetUsers() {
    try {
        webOffice.SetCurrUserName("<%=model.getUserName() %>");

        InitShowName();
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//显示指定用户的留痕
function ShowUserName() {
    /// 显当前用户留痕
    try {
        var user = $("#marks option:selected").val();

        if (user == "显示留痕" || user == undefined) {
            if (isShowAll) {
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
                isShowAll = false;
            }
        } else if (user == "隐藏留痕") {
            if (!isShowAll) {
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
                isShowAll = true;
            }else {
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
            }
        }else {
            if (!isShowAll) {
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
                isShowAll = true;
            }else {
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
                webOffice.GetDocumentObject().Application.ActiveWindow.ToggleShowAllReviewers();
            }
            webOffice.GetDocumentObject().Application.ActiveWindow.View.Reviewers(user).Visible = true;
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//加载所留痕用户
function InitShowName() {
    try {
        var count = webOffice.GetRevCount();

        var showName = $("#marks");
        showName.empty();

        var list = "显示留痕,隐藏留痕,";

        //GetRevInfo(i,int) int=1 获取时间  int=3 获取内容  int=0 获取名字
        for (var i = 1; i <= count; i++) {
            var strOpt = webOffice.GetRevInfo(i, 0);

            if (list.indexOf(strOpt) < 0) {
                list += strOpt + ",";
            }
        }
        var data = list.split(',');
        for (var i = 0; i < data.length; i++) {

            if (data[i] != null && data[i] != "") {
                var option = $("<option>").text(data[i]).val(data[i]);
                showName.append(option);
            }
        }
    } catch (e) {}
}
//隐藏 公文按钮
function EnableMenu() {
    /// 设置按钮
    webOffice.HideMenuItem(0x01 + 0x02 + 0x04 + 0x10 + 0x20);
}
//设置留痕,显示所有的留痕用户,是否只读文档
function SetTrack(track) {
    if (<%=model.isReadOnly() %>) {
        webOffice.ProtectDoc(1, 2, "");
    }else {
        webOffice.ProtectDoc(0, 1, "");
    }
    webOffice.SetTrackRevisions(track);

    SetUsers();
    //var types = $("#fileType").val();
    var type = webOffice.IsOpened();
    //如果打开的是word
    if (type == 11) {
        ShowUserName();
    }
}
//打开本地文件
function OpenFile() {
    pageLoadding('正在打开...');
    try {
        if (readOnly()) {
            return false;
        }

        OpenDoc("open", "doc");
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    loaddingOut('打开完成');
    return false;
}
function OpenTempLate() {
    if (readOnly()) {
        return false;
    }
    LoadTemplate('word', '公文模板', "File", OpenWeb);

    return false;
}
//打印公文
function printOffice() {
    try {
        if (isOpen) {
            webOffice.PrintDoc(1);
        } else {
            $.jBox.alert('请打开公文!', '提示');
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    return false;
}

function pageLoadding(msg) {
    $.jBox.tip(msg, 'loading');
}

function loaddingOut(msg) {
    $.jBox.tip(msg, 'success');
}

function DownLoad() {
    try {
        if (isOpen) {
            webOffice.ProtectDoc(0, 1, "");
            webOffice.ShowDialog(84);
        } else {
            $.jBox.alert('请打开公文!', '提示');
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    webOffice.ProtectDoc(1, 2, "");
    return false;
}
//打开服务器文件
function OpenWeb(loadtype) {
    try {
        var type = $("#fileType").val();
        var fileName = $("#fileName").val();
        fileName=escape(encodeURIComponent(fileName)); 
        var url = location.href + "&action=LoadFile&LoadType=" + loadtype + "&fileName=" + fileName;
        console.log(url)
        OpenDoc(url, type);
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//打开文件
function OpenDoc(url, type) {
    var openType = webOffice.LoadOriginalFile(url, type);
    if (openType > 0) {

        var type = webOffice.IsOpened();
        //如果打开的是word
        if (type == 11) {

        	if (<%=model.isIsMarks() %>)
                SetTrack(1);
            else
                SetTrack(0);

            if (<%=model.isIsTrueTH() %> && "" != "<%=model.getIsTrueTHTemplate() %>") 
                TaoHong();
        }
        isOpen = true;
    } else {
        $.jBox.alert('打开文档失败', '异常');
    }
}
//加载模板
function LoadTemplate(type, title, loadType, callback) {
    try {
        $.jBox("iframe:<%=basePath%>/WF/WebOffice/TempLate.jsp?LoadType=" + type + "&Type=" + loadType, {
            title: title,
            width: 800,
            height: 350,
            buttons: { '确定': 'ok' },
            submit: function (v, h, f) {
                var row = h[0].firstChild.contentWindow.getSelected();
                if (row == null) {
                    $.jBox.info('请选一个模板');
                    return false;
                } else {
                    pageLoadding('打开中...');
                    if (type == "word") {
                        $("#fileName").val(row.name);
                        $("#fileType").val(row.type);
                    }
                    else if (type == "marks") {
                        $("#markName").val(row.realName);
                    }
                    else {
                        $("#sealName").val(row.name);
                        $("#sealIndex").val(row.index);
                        $("#sealType").val(row.type);
                    }
                    callback();
                    loaddingOut('打开完成...');
                    return true;
                }
            }
        });
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//加载红头文件模板
function overOffice() {
    if (readOnly()) {
        return false;
    }
    if (isOpen) {
        LoadTemplate('over', '套红模板', "File", TaoHong);
    } else {
        $.jBox.alert('请打开公文!', '提示');
    }
    return false;
}
//套红头文件
function TaoHong() {
    try {
        var mark = AddBooks();
        var name = $("#sealName").val();
        var type = $("#sealType").val();
        //var url = window.location.protocol + "//" + window.location.host + "/DataUser/OfficeOverTemplate/" + name;
        var url = "<%=basePath%>DataUser/OfficeOverTemplate/" + name;
        if (type == "png" || type == "jpg" || type == "bmp") {
            webOffice.SetFieldValue(mark, url, "::JPG::");
        } else {
            webOffice.SetFieldValue(mark, url, "::FILE::");
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//保存到服务器
function saveOffice() {
    if (readOnly()) {
        return false;
    }
    var type = webOffice.IsOpened();

    pageLoadding('正在保存...');
    try {
        if (isOpen) {
            //如果打开的是word
            if (type == 11) {
                if (<%=model.isIsCheckInfo() %>) {
                    if (isInfo) {
                        isInfo = false;
                        webOffice.GetDocumentObject().Application.ActiveDocument.Content.InsertAfter("\n<%=NodeInfo %>");
                    }
                }
            }

            webOffice.HttpInit();
            webOffice.HttpAddPostCurrFile("File", "");
            var src = location.href + "&action=SaveFile";

            webOffice.HttpPost(src);
        } else {
            $.jBox.alert('请打开公文!', '提示');
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    loaddingOut('保存完成...');
    //var types = $('#fileType').val();

    try {
        if (type == 11) {
            InitShowName();
        }
    } catch (e) {}
    return false;
}
//拒绝修订
function refuseOffice() {
    try {
        if (readOnly()) {
            return false;
        }
        var vCount = webOffice.GetRevCount();
        var strUserName;
        for (var i = 1; i <= vCount; i++) {
            strUserName = webOffice.GetRevInfo(i, 0);
            webOffice.AcceptRevision(strUserName, 1);
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    return false;
}
//接受修订
function acceptOffice() {
    try {
        if (readOnly()) {
            return false;
        }
        webOffice.SetTrackRevisions(4);
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    return false;
}
//文档只读提示
function readOnly() {
    if (<%=model.isReadOnly() %>) {
        $.jBox.alert('文档只读不能进行此操作!', '提示');
        return true;
    }
}
//加载所有的公文印章
function sealOffice() {
    if (readOnly()) {
        return false;
    }
    if (isOpen) {
        LoadTemplate('seal', '公文盖章', "File", seal);
    } else {
        $.jBox.alert('请打开公文!', '提示');
    }
    return false;
}
//盖章
function seal() {
    try {
        var name = $("#sealName").val();
        //var url = window.location.protocol + "//" + window.location.host + "/DataUser/OfficeSeal/" + name;
        var url ="<%=basePath%>DataUser/OfficeSeal/" + name;
        var mark = AddBooks();
        AddPicture(mark, url, 5);
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
//添加书签
function AddBooks() {
    var date = new Date().getFullYear() + "" + new Date().getMonth() + "" + new Date().getDay() + "" + new Date().getHours() + "" + new Date().getMinutes() + "" + new Date().getSeconds();
    var strMarkName = "mark_" + date;
    var obj = new Object(webOffice.GetDocumentObject());
    if (obj != null) {
        var pBookM;
        var pBookMarks;
        // VAB接口获取书签集合
        pBookMarks = obj.Bookmarks;
        try {
            pBookM = pBookMarks(strMarkName);
            return pBookM.Name;
        } catch (e) {
            webOffice.SetFieldValue(strMarkName, "", "::ADDMARK::");
        }
    }
    return strMarkName;
}
//通过VBA 来插入图片
function AddPicture(strMarkName, strBmpPath, vType) {
    //定义一个对象，用来存储ActiveDocument对象
    var obj = new Object(webOffice.GetDocumentObject());
    if (obj != null) {
        var pBookMarks;
        // VAB接口获取书签集合
        pBookMarks = obj.Bookmarks;
        var pBookM;
        // VAB接口获取书签strMarkName
        pBookM = pBookMarks(strMarkName);
        var pRange;
        // VAB接口获取书签strMarkName的Range对象
        pRange = pBookM.Range;
        var pRangeInlines;
        // VAB接口获取书签strMarkName的Range对象的InlineShapes对象
        pRangeInlines = pRange.InlineShapes;
        var pRangeInline;
        // VAB接口通过InlineShapes对象向文档中插入图片
        pRangeInline = pRangeInlines.AddPicture(strBmpPath, 128);
        //设置图片的样式，5为浮动在文字上面
        pRangeInline.ConvertToShape().WrapFormat.TYPE = vType;
        delete obj;
    }
}
///插入文件测试
function InsertFileWeb() {
    //var url = window.location.protocol + "//" + window.location.host + "/DataUser/OfficeFile/099/112.docx";
    var url = "<%=basePath%>DataUser/OfficeFile/099/112.docx";
    webOffice.LoadOriginalFile(url, "docx");
}
function InsertFlow() {
    if (readOnly()) {
        return false;
    }
    try {
        if (isOpen) {
            LoadTemplate('flow', '流程图', "Dic", FlowInsert);
        } else {
            $.jBox.alert('请打开公文!', '提示');
        }
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
    return false;
}
function FlowInsert() {
	var name = $("#sealName").val();
    //var type = $("#sealType").val();
   // var url = window.location.protocol + "//" + window.location.host + "/DataUser/FlowDesc/" + name + "/" + name.replace(".", "_") + ".png";
    var url = "<%=basePath%>DataUser/FlowDesc/" + name + "/" + name.replace(".", "_") + ".png";
    var mark = AddBooks();
    //webOffice.InSertFile(url, 8);
    AddPicture(mark, url, 5);
}
function closeDoc() {
    webOffice.SetCurrUserName("");
    webOffice.closeDoc(0);
}
///设置word页边距字体
function SettingWordFont() {
    try {
        var obj = webOffice.GetDocumentObject().Application;

        obj.ActiveDocument.PageSetup.TopMargin = obj.CentimetersToPoints(parseFloat("3.7")); //上页边距
        obj.ActiveDocument.PageSetup.BottomMargin = obj.CentimetersToPoints(parseFloat("3.5")); //下页边距
        obj.ActiveDocument.PageSetup.LeftMargin = obj.CentimetersToPoints(parseFloat("2.8")); //左页边距
        obj.ActiveDocument.PageSetup.RightMargin = obj.CentimetersToPoints(parseFloat("2.6")); //右页边距

        obj.Selection.Font.NameFarEast = "仿宋_GB2312";

        obj.Selection.Font.Name = "仿宋_GB2312";
        obj.Selection.Font.Size = parseFloat("16");
        obj.Selection.Font.Bold = 0;
        obj.Selection.Font.Italic = 0;
    } catch (e) {
        $.jBox.alert("异常\r\nError:" + e + "\r\nError Code:" + e.number + "\r\nError Des:" + e.description, '异常');
    }
}
</script>
</head>
<body style="padding: 0px; margin: 0px;" onunload="closeDoc()" class="easyui-layout">
	<form method="post"	action="" id="form1">
		<div data-options="region:'north',border:false,noheader:true" style="background-color: #E0ECFF;line-height: 30px; height: auto; padding: 2px">
        	 <div id="divMenu">
        	 	<%=model.divMenu %>
        	 </div>
        </div>
         
        <div style="display: none;">
	        <input name="fileName" type="text" id="fileName" value="<%=model.getFileName()%>"/>
	        <input name="fileType" type="text" id="fileType" value="<%=model.getFileType()%>"/>
	        <input name="sealName" type="text" id="sealName" value="<%=model.getSealName()%>"/>
	        <input name="sealType" type="text" id="sealType" value="<%=model.getSealType()%>"/>
	        <input name="sealIndex" type="text" id="sealIndex" value="<%=model.getSealIndex()%>"/>
    	</div>
    	<div data-options="region:'center',border:false,noheader:true">
        	<script src="<%=basePath %>WF/Scripts/LoadWebOffice.js" type="text/javascript"></script>
    	</div>
    	<div data-options="region:'south'" title="附件" style="height: 150px;background-color: #E0ECFF;">
        	<%=model.ui.ListToString() %>
    	</div>
	</form>
</body>
</body>
<script type="text/javascript">
$(document).ready(function(){
	InitOffice();
});
</script>
</html>
