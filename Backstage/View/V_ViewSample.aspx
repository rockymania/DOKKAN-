<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_ViewSample.aspx.cs" Inherits="Backstage_View_V_ViewSample" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="中間的標題" style="padding:5px;"><%--Center中間區塊 --%>
           

            <table id="table_data" class="easyui-datagrid" style="width:100%;height:90%"
			        method="get" title="會員資料" iconCls="icon-save"
			        rownumbers="true" toolbar="#tb" footer="#ft" singleSelect="true" >
            </table>

            <div id="tb" style="padding:2px 5px;">
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
            <%--<div id="ft" style="padding:2px 5px";></div>--%>
		</div>
	</div>
    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
