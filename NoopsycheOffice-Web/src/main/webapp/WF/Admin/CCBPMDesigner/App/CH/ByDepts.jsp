<%@page import="org.apache.commons.beanutils.converters.BigDecimalConverter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>按流程分析</title>
</head>
<body>
<table style="width: 100%;">
        <tr>
            <th class="GroupTitle" rowspan="2">
                IDX
            </th>
            <th rowspan="2">
                流程名称
            </th>
            <th rowspan="2">
                发起总数
            </th>
            <th colspan="2">
                时效统计(单位:分钟)
            </th>
            <th colspan="5">
                状态分布
            </th>
            <th colspan="3">
                上月
            </th>
            <th colspan="3">
                本月
            </th>
            <th rowspan="2">
                详细
            </th>
        </tr>
        <tr>
            <th>
                节省
            </th>
            <th>
                逾期
            </th>
            <th>
                及时
            </th>
            <th>
                按期
            </th>
            <th>
                逾期
            </th>
            <th>
                超期
            </th>
            <th>
                按期办结率
            </th>


            <th>按期</th>
            <th>预期</th>
            <th>按期办结率</th>


            <th>按期</th>
            <th>预期</th>
            <th>按期办结率</th>

        </tr>



        </table>
</body>
</html>