﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_LoginData.aspx.cs" Inherits="Backstage_View_V_LoginData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>

    <script type="text/javascript" src="../../plugins/jqplot/jquery.jqplot.js"></script>
    <script type="text/javascript" src="../../plugins/jqplot/jqplot.pieRenderer.js"></script>
    <script type="text/javascript" src="../../plugins/jqplot/jqplot.donutRenderer.js"></script>
    <link rel="stylesheet" type="text/css" href="../../plugins/jqplot/jquery.jqplot.css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" />
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
            <div>
            <p id="chart1data""></p>
            <p id="chart1" style="width:300px;"></p> 
            </div>

            <%--<div id="ft" style="padding:2px 5px";></div>--%>
		</div>
	</div>

    <script>
        function QueryOnline() {
            var LoginValue = $("#Login").val();

            $.ajax(
                {
                    dataType: "text",
                    type: "GET",
                    url: "../Model/M_GetLoginData.aspx",
                    data: {
                        "LoginValue": LoginValue,
                    },
                    success: function (result) {
                        if (LoginValue == 2)
                            QueryBar(result);
                        else
                            ;
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function QueryBar(result) {
            var obj = $.parseJSON(result);//變成陣列

            var labels = [];
            var s1 = [];    //Y軸資料
            for (i = 0; i < obj.length; i++) {
                labels.push(obj[i].AuthKind);
                s1.push(obj[i].TotalCount);
            }

            $("#chart1data").html("目前總註冊人數為" + (obj[0].TotalCount + obj[1].TotalCount) + "</br>" +
                                  "已經驗證人數為 <b>" + obj[1].TotalCount + "</b></br>" +
                                  "尚未驗證人數為 <b>" + obj[0].TotalCount) + "</b>";

            var plot1 = $.jqplot('chart1', [[['未驗證', obj[0].TotalCount], ['驗證', obj[1].TotalCount]]], {
                //gridPadding: { top: 0, bottom: 38, left: 0, right: 0 },
                seriesDefaults: {
                    renderer: $.jqplot.PieRenderer,//選擇要產生的圖形定義
                    //trendline: { show: false },
                    rendererOptions: { /*padding: 8*/ showDataLabels: true }
                },
                legend: {//外圍顯示的文字
                    show: true,
                    location: 'w',//位置的定義為東、南、西、北…，nw, n, ne, e, se, s, sw, w
                }
            });
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
