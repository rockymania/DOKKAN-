<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_LoginDataPic.aspx.cs" Inherits="Backstage_View_V_LoginDataPic" %>

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
    <title>登入資料-圖表版</title>
</head>
<body>
       <div id="cc" class="easyui-layout" style="width:90%;height:720px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="登入資料" style="padding:5px;"><%--Center中間區塊 --%>

            <div id="tb" style="padding:2px 5px;">
                <input id="Login" name="Login" data-options="panelHeight:'auto'" style="width:360px;"/>
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
                <div id="SecondCondition">
                <input id="LoginCondition" name="LoginCondition" style="width:180px;" data-options="panelHeight:'auto'"/>
                    請輸入帳號:<input class="easyui-textbox" type="text" id="Account" name="Account"/>
                    Date From:<input class="easyui-datebox" id="DateFrom" style="width:110px" />
                    Date To:<input class="easyui-datebox" id="DateTo" style="width:110px" />
                </div>
            </div>

<%--            <table id="AccountTable" class="easyui-datagrid" title="帳號分析" style="width:100%;height:95%;"
               data-options="rownumbers:true,singleSelect:true,method:'get',toolbar:'#tb',footer:'#ft'"></table>--%>

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
            var LoginCondition = $("#LoginCondition").val();
            
            $('#chart1').empty();
            $('#chart2').empty();
            $('#chart1data').empty();
            $('#chart2data').empty();
            var aDateFrom = $("#DateFrom").datebox("getValue");
            var aDateTo = $("#DateTo").datebox("getValue");
            var aAccount = $("#Account").val();

            $.ajax(
                {
                    dataType: "text",
                    type: "GET",
                    url: "../Model/M_GetLoginData.aspx",
                    data: {
                        "LoginValue": LoginValue,
                        "DateFrom": aDateFrom,
                        "DateTo": aDateTo,
                        "Account": aAccount,
                        "LoginCondition": LoginCondition,

                    },
                    success: function (result) {
                        if (LoginValue == 2)
                            QueryBar(result);
                        else if (LoginValue == 1) {
                            QuertCharBar(result);
                            //QueryCharBarCompare(result);
                        } else if (LoginValue == 3) {
                            if (result == "101") {
                                alert("請輸入帳號");
                                return;
                            }
                            //QueryLoginData(result, LoginCondition);
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

        function QueryLoginData(result,kind) {
            var obj = $.parseJSON(result);//變成陣列

            var Totaldata = {
                Account: [],
                IP: [],
                LoginTime: []
            };
            for (i = 0; i < obj.length; i++) {
                Totaldata.Account.push(obj[i].Account);
                Totaldata.IP.push(obj[i].IP);
                Totaldata.LoginTime.push(obj[i].LoginTime);
            }

            var chart = {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            };

            var title = {
                text: '帳號登錄流水紀錄'
            };
            var tooltip = {
                pointFormat: '{series.name}'
            };

            var xAxis = {
                categories: Totaldata.IP
            };

            var yAxis = {
                title: {
                    text: '時間'
                }
            };

            var plotOptions = {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            };

            var series = [{
                name: Totaldata.Account[0],
                data: [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
                //data: Totaldata.LoginTime,
            }
            ];

            //LoginConditionx

            var json = {};
            json.xAxis = xAxis;
            json.yAxis = yAxis;
            json.chart = chart;
            json.title = title;
            json.tooltip = tooltip;
            json.series = series;
            json.plotOptions = plotOptions;
            $('#chart1').highcharts(json); 

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

            var chart = {
                type: 'column'
            };
            var title = {
                text: '每月創立帳號驗證對比'
            };
            var xAxis = {
                categories: Totaldata.ID,
            };
            var yAxis = {
                min: 0,
                title: {
                    text:'註冊人數'
                }
            };

            var plotOptions = {
                column: {
                    dataLabels: {
                        enabled: true
                    },
                    //enableMouseTracking: false
                }
            };

            var series = [{
                name: '註冊人數',
                data: Totaldata.TotalSignUp,
                colorByPoint: true,
            }];     

            Highcharts.setOptions({
                colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655',
                    '#FFF263', '#6AF9C4']
            });

            var json = {};
            json.chart = chart;
            json.title = title;

            json.xAxis = xAxis;
            json.yAxis = yAxis;
            json.series = series;
            json.plotOptions = plotOptions;

            $('#chart1').highcharts(json);

            var series2 = [{
                name: '註冊人數',
                data: Totaldata.TotalSignUp,
                colorByPoint: true,
            }, {
                    name: '驗證人數',
                    data: Totaldata.AuthNum,
                    colorByPoint: true,
            }];     
            var json2 = {};
            json2.chart = chart;
            json2.title = title;

            json2.xAxis = xAxis;
            json2.yAxis = yAxis;
            json2.series = series2;
            json2.plotOptions = plotOptions;
            $('#chart2').highcharts(json2);
        }

        function QueryBar(result) {
            var obj = $.parseJSON(result);//變成陣列

            ///PART1.



            ///PART2.
            var labels = [];
            var s1 = [];    //Y軸資料
            for (i = 0; i < obj.length; i++) {
                labels.push(obj[i].AuthKind);
                s1.push(obj[i].TotalCount);
            }

            $("#chart1data").html("目前總註冊人數為" + (obj[0].TotalCount + obj[1].TotalCount) + "</br>" +
                                  "已經驗證人數為 <b>" + obj[1].TotalCount + "</b></br>" +
                                  "尚未驗證人數為 <b>" + obj[0].TotalCount) + "</b>";

            var chart = {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            };

            var title = {
                text: '伺服器註冊人數驗證人數比對'
            }; 

            var tooltip = {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            };

            var plotOptions = {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true
                    },
                    showInLegend: true
                }
            };

            var series = [{
                type: 'pie',
                name: '註冊人數',
                data: [
                    ['尚未驗證人數', obj[0].TotalCount],
                    {
                        name: '驗證人數',
                        y: obj[1].TotalCount,
                        sliced: true,
                        selected: true
                    },
                ]
            }];

            var json = {};
            json.chart = chart;
            json.title = title;
            json.tooltip = tooltip;
            json.series = series;
            json.plotOptions = plotOptions;
            $('#chart1').highcharts(json);  
        }

        function Init() {
            //主搜尋
            $("#Login").combobox({
                valueField: 'value',
                textField: 'text',
                data: [
                    { value: 1, text: '每月創立帳號分析' },
                    { value: 2, text: '全部帳號驗證分析', selected: true },
                    //{ value: 3, text: '帳號登錄流水紀錄'},
                ],
                onChange: function (value) {
                    //SecondCondition
                    if (value == 3) {
                        $("#SecondCondition").css('display', 'block');
                    } else
                        $("#SecondCondition").css('display', 'none');
                }
            });
            //副搜尋一號:
            $("#LoginCondition").combobox({
                valueField: 'value',
                textField: 'text',
                data: [
                    { value: 101, text: '透過時間以及帳號', selected: true },
                    { value: 102, text: '僅透過時間' },
                    { value: 103, text: '僅透過帳號' },
                ],
                onChange: function (value) {
                }
            });
        }

       
        function SetDate() {
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

        $(document).ready(function () {
            Init();
            SetDate();//預設一開始的時間
        });
    </script>

    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
