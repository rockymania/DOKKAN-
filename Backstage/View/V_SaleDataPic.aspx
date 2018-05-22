<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_SaleDataPic.aspx.cs" Inherits="Backstage_View_V_SaleDataPic" %>

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
    <%--圖表用的--%>
    <script src="https://code.highcharts.com/highcharts.src.js"></script>

    <title>單品銷售(圖表)</title>
</head>
<body>
       <div id="cc" class="easyui-layout" style="width:90%;height:720px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="銷售資料" style="padding:5px;"><%--Center中間區塊 --%>

            <div id="tb" style="padding:2px 5px;">
                請輸入商品ID:<input class="easyui-textbox" type="text" id="ProductID" name="ProductID" data-options="required:true" />
                Date From:<input class="easyui-datebox" id="DateFrom" style="width:110px" />
                To:<input class="easyui-datebox" id="DateTo" style="width:110px" />
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
            <div id="container" class="highcharts-container" style="height:410px; margin: 0 2em; clear:both; min-width: 600px">     
		</div>
	</div>

    <script>
        var chart;

        function Init()
        {
            SetDate();
            PicTableInit();
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
            GetReportData();
        }

        function GetReportData() {

            var aDateFrom = $("#DateFrom").datebox("getValue");
            var aDateTo = $("#DateTo").datebox("getValue");
            var aProductID = $("#ProductID").val();

            var aUrl = "../Model/M_GetSaleDataPic.aspx?DateFrom=" + aDateFrom + "&DateTo=" + aDateTo + "&ProductID=" + aProductID;

            $.ajax({
                url: aUrl,
                type: 'GET',
                //成功之後，會收到Server端返回的資料，也就是自訂的型別ReportData
                //有兩個屬性可以用
                success: function (result) {
                    //先解JSON
                    var aJsonData = JSON.parse(result);

                    var seriesOpts = {
                        name: '銷售數量',
                        data: aJsonData.SaleCount,
                        fillOpacity: 0.5
                    };

                    //chart.xAxis[0].setCategories(aJsonData.Date);
                    //chart.addSeries(seriesOpts);
                    var xAxis = {
                        categories: aJsonData.Date
                    };

                    var series = [
                        {
                            name: '銷售數量',
                            data: aJsonData.SaleCount
                        },
                    ];
                    var tooltip = {
                        valueSuffix: ''
                    }
                    var title = {
                        text: '單品銷售狀況'
                    };
   
                    var legend = {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle',
                        borderWidth: 0
                    };

                    var json = {};

                    json.title = title;
                    //json.subtitle = subtitle;
                    json.xAxis = xAxis;
                    //json.yAxis = yAxis;
                    json.tooltip = tooltip;
                    json.legend = legend;
                    json.series = series;

                    $('#container').highcharts(json);
                },
                cache: false
            });
        }

        function PicTableInit()
        {
            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'container',
                    defaultSeriesType: 'areaspline',
                    events: {
                        //圖表載入後執行GetReportData這個Function
                        load: GetReportData
                    }
                },
                title: {
                    text: '單品銷售'
                },
                //自訂X軸座標，也可以從Server塞資料進來
                xAxis: {
                    categories: ["一月", "二月", "三月", "四月", "五月"
                        , "六月", "七月", "八月", "九月", "十月"
                        , "十一月", "十二月",]
                },
                yAxis: {
                    title: {
                        text: '數量'
                    },
                },
                tooltip: {
                    formatter: function () {
                        //這地方有什麼資料可用可以開FireBug來看
                        //也可以從後端傳進來
                        //return '類別1:' + this.points[0].y + '<br/>類別2:' + this.points[1].y;

                    },
                    shared: true,
                    crosshairs: true
                },
                //兩份資料，一開始都是空的
            });
        }
    </script>

    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
