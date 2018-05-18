<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_LoginData.aspx.cs" Inherits="Backstage_View_V_LoginData" %>

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

    <script type="text/javascript" src="../../plugins/jqplot/jqplot.barRenderer.js"></script>
    <script type="text/javascript" src="../../plugins/jqplot/jqplot.categoryAxisRenderer.js"></script>

    <script type="text/javascript" src="../../plugins/jqplot/jqplot.pointLabels.js"></script>
    <link rel="stylesheet" type="text/css" href="../../plugins/jqplot/jquery.jqplot.css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" />
    <title>登入資料</title>
</head>
<body>
       <div id="cc" class="easyui-layout" style="width:90%;height:720px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="登入資料" style="padding:5px;"><%--Center中間區塊 --%>

            <div id="tb" style="padding:2px 5px;">
                <input id="Login" name="Login" data-options="panelHeight:'auto'" style="width:360px;"/>
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
            <div>
                <p id="chart1data""></p>
                <p id="chart1"></p>
                <p id="chart2data""></p>
                <p id="chart2"></p>
            </div>

            <%--<div id="ft" style="padding:2px 5px";></div>--%>
		</div>
	</div>

    <script>
        function QueryOnline() {
            var LoginValue = $("#Login").val();
            $('#chart1').empty();
            $('#chart2').empty();
            $('#chart1data').empty();
            $('#chart2data').empty();
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
                        else if (LoginValue == 1) {
                            QuertCharBar(result);
                            QueryCharBarCompare(result);
                        }

                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function QueryCharBarCompare(result) {
            var obj = $.parseJSON(result);//變成陣列
            var s1 = new Array();
            var s2 = new Array();
            var ticks = new Array();

            for (i = 0; i < obj.length; i++) {
                ticks.push(obj[i].ID);
                s1.push(obj[i].TotalSignUp);
                s2.push(obj[i].AuthNum);
            }

            $('#chart2').jqplot('chart2', [s1, s2], {
                animate: !$.jqplot.use_excanvas,
                title: '每月創立帳號驗證對比',
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,
                    renderer: $.jqplot.BarRenderer,
                    pointLabels: { show: true },
                },
                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer,
                        ticks: ticks
                    }
                }
            });

            $('#chart2').bind('jqplotDataHighlight',
                function (ev, seriesIndex, pointIndex, data) {
                    if (seriesIndex == 0)
                        $('#chart2data').html('總註冊人數: ' + data[1]);
                    else
                        $('#chart2data').html('已驗證註冊人數: ' + data[1]);
                }
            );
            $('#chart2').bind('jqplotDataClick',
                function (ev, seriesIndex, pointIndex, data) {
                    $('#chart2data').html('series: ' + seriesIndex + ', point: ' + pointIndex + ', data: ' + data + ', pageX: ' + ev.pageX + ', pageY: ' + ev.pageY);
                }
            );

            $('#chart2').bind('jqplotDataUnhighlight',
                function (ev) {
                    $('#chart2data').html();
                }
            );
        }


        function QuertCharBar(result) {
            var obj = $.parseJSON(result);//變成陣列
            var Totaldata = {
                ID: [],
                TotalSignUp: [],
                AuthNum: []
            };
            for (i = 0; i < obj.length; i++) {
                Totaldata.ID.push(obj[i].ID);
                Totaldata.TotalSignUp.push(obj[i].TotalSignUp);
                Totaldata.AuthNum.push(obj[i].AuthNum);
            }

            var LineItem = new Array();
            for (var i = 0; i <= Totaldata.ID.length; i++) {
                LineItem[i] = new Array();
                LineItem[i][0] = Totaldata.ID[i];
                LineItem[i][1] = Totaldata.TotalSignUp[i];
            }

            $('#chart1').jqplot([LineItem], {
                animate: !$.jqplot.use_excanvas,
                title: '每月創立帳號分析',
                // Provide a custom seriesColors array to override the default colors.
                seriesColors: ['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8', '#4cb4c7'],
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,
                    pointLabels: { show: true },
                    rendererOptions: {
                        // Set varyBarColor to tru to use the custom colors on the bars.
                        varyBarColor: true
                    }
                },
                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer
                    }
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
                    { value: 1, text: '每月創立帳號分析' },
                    { value: 2, text: '全部帳號驗證分析', selected: true },
                    //{ value: 3, text: '每月創立帳號驗證對比'},
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
