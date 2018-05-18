<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_SaleData.aspx.cs" Inherits="Backstage_View_V_SaleData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <title></title>
</head>
<body>
    <div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="銷售資料" style="padding:5px;"><%--Center中間區塊 --%>
           <table id="ProductTable" class="easyui-datagrid" title="單項商品銷售" style="width:100%;height:95%;"
               data-options="rownumbers:true,singleSelect:true,method:'get',toolbar:'#tb',footer:'#ft'"></table>

            <div id="tb" style="padding:2px 15px;">
                請輸入商品ID:<input class="easyui-textbox" type="text" id="ProductID" name="ProductID" data-options="required:true" />
                Date From:<input class="easyui-datebox" id="DateFrom" style="width:110px" />
                To:<input class="easyui-datebox" id="DateTo" style="width:110px" />
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
		</div>
	</div>
    <script type="text/javascript" src="../Js/Button.js"></script>

    <script>
        function Init()
        {
            SetDate();

        }

        function SetDate()
        {
            $("#DateFrom").datebox({
                formatter: function (date) {
                    var y = date.getFullYear();
                    var m = date.getMonth() + 1;
                    var d = date.getDate();
                    return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
                },
                parser: function (s) {
                    var t = Date.parse(s);
                    if (!isNaN(t)) { return new Date(t); }
                    else { return new Date(); }
                }
            }
            );

            var aDate = new Date();
            var aDay = aDate.getDate() - 1;
            var m = aDate.getMonth() + 1;

            aDate.setDate(aDate.getDate() - aDay);

            $("#DateFrom").datebox("setValue", aDate);


            $("#DateTo").datebox({
                formatter: function (date) {
                    var y = date.getFullYear();
                    var m = date.getMonth() + 1;
                    var d = date.getDate();
                    return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
                },
                parser: function (s) {
                    var t = Date.parse(s);
                    if (!isNaN(t)) { return new Date(t); }
                    else { return new Date(); }
                }
            }
            );

            var aDate = new Date();

            $("#DateTo").datebox("setValue", aDate.getDate());

        }

        $(document).ready(function ()
        {
            Init();
            QueryOnline();
        });

        function QueryOnline()
        {
            var aDateFrom = $("#DateFrom").datebox("getValue");
            var aDateTo = $("#DateTo").datebox("getValue");
            var aProductID = $("#ProductID").val();

            var aUrl = "../Model/M_SaleData.aspx?DateFrom=" + aDateFrom + "&DateTo=" + aDateTo + "&ProductID=" + aProductID;

            $("#ProductTable").datagrid({
                url: aUrl,
                //width: "auto", //自動寬度
                columns: [[
                    { field: 'Date', title: '日期' ,width:150},
                    { field: 'SaleCount', title: '消費數量', width: 150},
                ]],
                showFooter: true,
                detailFormatter: function (index, row)
                {
                    return '<div style="padding:2px"><table class="ddv"></table></div>';
                },



            })
        }



    </script>
</body>
</html>
