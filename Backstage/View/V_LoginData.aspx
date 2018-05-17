<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_LoginData.aspx.cs" Inherits="Backstage_View_V_LoginData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <title>登入資料</title>
</head>
<body>
       <div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="登入資料" style="padding:5px;"><%--Center中間區塊 --%>

            <div id="tb" style="padding:2px 5px;">
                <input id="Login" name="Login" data-options="panelHeight:'auto'"/>
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
            <%--<div id="ft" style="padding:2px 5px";></div>--%>
		</div>
	</div>

    <script>
        function QueryOnline() {
            var value = $("#Login").val();
        }

        function Init() {
            $("#Login").combobox({
                valueField: 'value',
                textField: 'text',
                data: [
                    { value: 1, text: '每日創立帳號分析' },
                    { value: 2, text: '帳號驗證分析', selected: true },
                ],
            });
        }

        $(document).ready(function () {
            Init();
        });
    </script>

    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
