<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ Register Src="TruakUC.ascx" TagName="TruakUC" TagPrefix="uc1"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link href="../../Comm/Style/Tabs.css" rel="stylesheet" type="text/css" />
	<link href="../../Comm/Style/Table0.css" rel="stylesheet"
		type="text/css" />
	<link href="../../Comm/Style/Table.css" rel="stylesheet"
		type="text/css" />
	<script language="javascript" type="text/javascript">
        function WinOpen(url, winName) {
            var newWindow = window.open(url, winName, 'height=800,width=1030,top=' + (window.screen.availHeight - 800) / 2 + ',left=' + (window.screen.availWidth - 1030) / 2 + ',scrollbars=yes,resizable=yes,toolbar=false,location=false,center=yes,center: yes;');
            newWindow.focus();
            return;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1"
	runat="server">
	<uc1:TruakUC ID="TruakUC1" runat="server" />
</asp:Content>

