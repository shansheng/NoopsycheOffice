<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WF/head/head1.jsp"%>

<script type="text/javascript">
        function SelectAll() {
            var arrObj = document.all;
            if (document.forms[0].checkedAll.checked) {
                for (var i = 0; i < arrObj.length; i++) {
                    if (typeof arrObj[i].type != "undefined" && arrObj[i].type == 'checkbox') {
                        arrObj[i].checked = true;
                    }
                }
            } else {
                for (var i = 0; i < arrObj.length; i++) {
                    if (typeof arrObj[i].type != "undefined" && arrObj[i].type == 'checkbox')
                        arrObj[i].checked = false;
                }
            }
        } 
</script>
    
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
    <div data-options="region:'center'">
        <uc1:Pub ID="Pub1" runat="server" />
    </div>
    </form>
</body>
</html>