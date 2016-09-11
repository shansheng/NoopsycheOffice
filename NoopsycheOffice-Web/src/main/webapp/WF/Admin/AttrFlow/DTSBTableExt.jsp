<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import= "java.util.ArrayList"%>
<%@page import= "java.util.List"%>
<%@ include file="/WF/head/head1.jsp"%>
<%
	DTSBTableExtModel dtsb = new DTSBTableExtModel(request,response);
	dtsb.init();
%>
<html>
<head>
<style type="text/css">
        table
        {
            margin: 90px;
        }
        div
        {
            align: center;
        }
        
.CaptionMsg
{
    vertical-align: middle;
    text-align: left;
    height: 32px;
    background-position: left center;
    line-height: 34px;
    font-size: 12px;
    text-align: center;
    vertical-align: middle;
    height: 30px;
    font-family: 黑体;
    font-weight: bolder;
    color: #FFFFFF;
    background: url('/DataUser/Style/Img/TitleMsg.png');
    width: 138px;
    margin-left: -10px;
    padding-left: 0px;
    background-repeat: no-repeat;
    background-attachment: fixed;
}


.CaptionMsg  a:hover
{
    color: white;
}



.CaptionMsgLong
{
    vertical-align: middle;
    text-align: left;
    height: 32px;
    background-position: left center;
    line-height: 34px;
    font-size: 12px;
    text-align: center;
    vertical-align: middle;
    height: 30px;
    font-family: 黑体;
    font-weight: bolder;
    color: #FFFFFF;
    background: url('/DataUser/Style/Img/TitleMsgLong.png');
    width: 238px;
    margin-left: -10px;
    padding-left: 0px;
    background-repeat: no-repeat;
    background-attachment: fixed;
    text-align:center;
}
    </style>
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            font-family: '宋体' !important;
        }
        table
        {
            margin: 0 auto;
            width: 100%;
        }
        #ContentPlaceHolder1_Pub1_Btn_Save
        {
            margin: 0 29%;
        }
        #ContentPlaceHolder1_Pub1_Btn_Close
        {
        }
    </style>
    <script type="text/javascript">
        function btnClose_Click() {
            window.close();
        }
        function btn_Save_Click(){
        	var param = window.location.search;
        	$.ajax({
    			url:'<%=basePath%>WF/DTSBTable/BtnSaveClick.do'+param,
    			type:'post', //数据发送方式
    			dataType:'json', //接受数据格式
    			data:$("#form").serialize(),
    			async: false ,
    			error: function(data){
    				alert(data.msg);
    			},
    			success: function(data){
    				alert(data.msg);
    			}
    		});
        }
    </script>
</head>
<body>
<form id="form" action="">
	<%=dtsb.Pub1.toString()%>
</form>
</body>
</html>