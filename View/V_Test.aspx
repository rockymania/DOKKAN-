<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Test.aspx.cs" Inherits="View_V_Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="../plugins/jqplot/jquery.jqplot.js"></script>
    <script type="text/javascript" src="../plugins/jqplot/jqplot.enhancedLegendRenderer.js"></script>
   
    <script type="text/javascript" src="../plugins/jqplot/jqplot.canvasTextRenderer.js"></script>
    <script type="text/javascript" src="../plugins/jqplot/jqplot.canvasAxisLabelRenderer.js"></script>

    <script type="text/javascript" src="../plugins/jqplot/jqplot.pieRenderer.js"></script>
    <script type="text/javascript" src="../plugins/jqplot/jqplot.donutRenderer.js"></script>
    <%--<script type="text/javascript" src="jquery-ui/js/jquery-ui.min.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="../plugins/jqplot/jquery.jqplot.css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" />
    <title>Example</title>
    <style>
        #wrapper{
            width:980px;
            margin: 0 auto;
        }
        #nav1{
            width:40%;
            float:left;
        }
        #nav2{
            width:60%;
            float:right;
        }
       #map {
        height: 400px;
        width: 100%;
       }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="header">
        <p id="AA"></p>
    </div>
    <div id="chart1" style="width:300px;"></div>  
    <div id="content">
        <button onclick="javascript:GetTotalBusData()">塞公車資料</button>
        <select id="BusSelect" style="width:auto" onchange="ShowBtn()">
        </select>
        <select id="BusSelect2" style="width:auto" onchange="GetStopStationMap()">
        </select>
        <p id="BtnList" style="display:none">
            <button onclick="javascript:GetTotalBusData()">公車相關資訊</button>
            <button onclick="javascript:GetBusStopTimeData()">公車到站資料查詢</button>
        </p>
        <div id="test"></div>
    </div>
    <div id="footer">
        <h3 id ="mapdemo">My Google Maps Demo</h3>
        <div id="map"></div>
    </div>
</div>
    <script>
        //功能按鈕出現
        function ShowBtn() {
            $("#BtnList").show();
        }

        function HideBtm() {
            $("#BtnList").hide();
        }

        //取得公車到達每一個站牌的相關資訊
        function GetBusStopTimeData() {
            var x = document.getElementById("BusSelect").value;

            var x = document.getElementById("BusSelect").value;

            var value2 = window.sessionStorage.getItem("BusStopData" + x + "StopData");
            if (value2 != null) {
                $("#mapdemo").html("SetBusStopTimeDataFrom Storage");
                var objCar = JSON.parse(value2);
                SetBusStopData(objCar);
                return;
            }

            if (x == 0) return;
            if (x < 1000) {
                var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/EstimatedTimeOfArrival/City/Keelung/" + x + "?$format=JSON";

            } else {
                var CarNum = x.substring(0, 3);//取得路線號碼
                var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/EstimatedTimeOfArrival/City/Keelung/" + CarNum + "?$format=JSON";
            }

            $.ajax({
                type: "GET",
                url: aUrl,
                success: function (result) {
                    SetBusStopData(result);
                    sessionStorage.setItem("BusStopData" + x +"StopData", JSON.stringify(result));
                    $("#mapdemo").html("SetBusStopTimeDataFrom Web");
                },
                error: function (err) {
                    alert(err);
                }
            });

        }

        function SetBusStopData(result) {
            var obj = new Array(result.length)
            for (var i = 0; i < result.length; i++)
                obj[i] = result[i];

            var table = "";
            var td = "";
            var total = "";
            for (var i = 0; i < result.length; i++) {
                var obj2 = new Object();

                obj2.StopName = obj[i].StopName.Zh_tw;//取得停車的站牌
                //如果string(StopStatus 為1~4或PlateNumb値為-1時) EstimateTime == 空白 反之，EstimateTime有値] 
                if (obj[i].StopStatus == null)
                    obj2.EstimateTime = obj[i].EstimateTime;
                else
                    obj2.EstimateTime = "目前無車";

                td += '<td>' + obj2.StopName + '</td >';
                td += '<td>' + obj2.EstimateTime + '</td >';

                table = '<table> <tr>' + td + '</tr> </table>';

                td = "";

                total += table;
            }
            $('#test').append(total);
        }

        function MakeMap(latpos,lngpos) {
            var uluru = { lat: parseFloat(latpos), lng: parseFloat(lngpos) };
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 20,
                center: uluru
            });
            var marker = new google.maps.Marker({
                position: uluru,
                map: map
            });
        }

        function initMap() {
                $("#mapdemo").html("Init");
        }

        function GetStopStationMap() {
            var x = document.getElementById("BusSelect2").value;
            var y = x.split("|");
            MakeMap(y[0], y[1]);
        }

        function GetTotalBusStopData() {
            var x = document.getElementById("BusSelect").value;
            var select = document.getElementById("BusSelect2");

            for (var i = select.options.length - 1; i >= 0; i--) {
                select.remove(i);
            }

            var value2 = window.sessionStorage.getItem("BusData"+x);
            if (value2 != null) {
                $("#mapdemo").html("SetBusStopsDaraFromStorage");
                var objCar = JSON.parse(value2);
                SetBusStationData(objCar);
                return;
            }

            if (x == 0) return;
            if (x < 1000) {
                var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/Keelung/" + x + "?$filter=Direction%20eq%20'0'&$format=JSON";

            } else {
                var CarNum = x.substring(0, 3);//取得路線號碼
                var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/StopOfRoute/City/Keelung/" + CarNum + "?$filter=Direction%20eq%20'0'%20and%20RouteID%20eq%20'" + x + "'&$format=JSON";
            }


            $.ajax({
                type: "GET",
                url: aUrl,
                success: function (result) {
                    SetBusStationData(result);
                    sessionStorage.setItem("BusData"+x, JSON.stringify(result));
                    $("#mapdemo").html("SetBusStopsDaraFrom Web");
                },
                error: function (err) {
                    alert(err);
                }
            });
        } 

        function SetBusStationData(result) {
            //只會有一筆
            var obj3 = new Object();

            obj3.label = '---------------------------------------';

            obj3.data = 0;

            var optionBox = document.createElement('option');

            optionBox.label = obj3.label;

            optionBox.value = obj3.data;

            document.getElementById("BusSelect2").add(optionBox)

            for (var i = 0; i < result[0].Stops.length; i++) {
                var obj2 = new Object();

                obj2.label = result[0].Stops[i].StopName.Zh_tw;

                obj2.data = result[0].Stops[i].StopPosition.PositionLat + "|" + result[0].Stops[i].StopPosition.PositionLon;

                var optionBox = document.createElement('option');

                optionBox.label = obj2.label;

                optionBox.value = obj2.data;

                document.getElementById("BusSelect2").add(optionBox)
            }
        }


        ////////////取得這公車的基本資料
        //////////function mySelectBusData2() {
        //////////    var x = document.getElementById("BusSelect").value;

        //////////    if (x == 0) return;
        //////////    if (x < 1000) {
        //////////        var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung/" + x + "?&$top=30&$format=JSON";
        //////////        alert(aUrl);
        //////////    } else {
        //////////        var CarNum = x.substring(0, 3);//取得路線號碼
        //////////        var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung/" + CarNum + "?$filter=RouteID%20eq%20'" + x + "'&$top=30&$format=JSON";
        //////////        alert(aUrl);
        //////////    }
        //////////}

        function GetTotalBusData() {
            var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/Route/City/Keelung?&$format=JSON";
            var select = document.getElementById("BusSelect");

            for (var i = select.options.length - 1; i >= 0; i--) {
                select.remove(i);
            }

            //先判斷有沒有全部車子的資料 沒有才會要去WEB取
            var value2 = window.sessionStorage.getItem("TotalBusData");
            if (value2 != null) {
                $("#mapdemo").html("SetBusDataFromStorage");
                var objCar = JSON.parse(sessionStorage.TotalBusData);
                SetBusData(objCar);
                return;
            }

            $.ajax({
                type: "GET",
                url: aUrl,
                success: function (result) {
                    SetBusData(result);
                    sessionStorage.setItem("TotalBusData", JSON.stringify(result));
                    $("#mapdemo").html("SetBusDataFromWeb");
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
        function SetBusData(result) {
            var obj = new Array(result.length)
            for (var i = 0; i < result.length; i++)
                obj[i] = result[i];

            var obj3 = new Object();

            obj3.label = '---------------------------------------';

            obj3.data = 0;

            var optionBox = document.createElement('option');

            optionBox.label = obj3.label;

            optionBox.value = obj3.data;

            document.getElementById("BusSelect").add(optionBox)

            for (var i = 0; i < result.length; i++) {
                var obj2 = new Object();

                obj2.label = obj[i].SubRoutes[0].SubRouteName.Zh_tw;

                obj2.data = obj[i].SubRoutes[0].SubRouteName.En;

                var optionBox = document.createElement('option');

                optionBox.label = obj2.label;

                optionBox.value = obj2.data;

                document.getElementById("BusSelect").add(optionBox)
            }
           
        }
        //取道的RouteID 前三碼是基隆公車路線號碼
        //RouteID是取得那一條線路用的



        //讀取cookie
        function Alert() {
            var ds = readCookie('Account');
            alert(ds);
            ds = readCookie('NickName');
            alert(ds);

        }
        //增加cookie
        function Insert() {
            var ds = "Ricky";
            createCookie('Account', ds, 1);
            ds = "細菌哥";
            createCookie('NickName', ds, 1);
        }
        //清除cookie
        function Clear() {
            eraseCookie("Ricky");
        }

        $(document).ready(function () {
            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
                    url: "../Model/M_Test.aspx",
                    success: function (result) {
                        $("#AA").append(result);
                        //QueryBar(result); 
                    },
                    error: function () {
                        alert('error');
                    }
                });
        });

        function QueryBar(result) {
            var obj = $.parseJSON(result);//變成陣列

            var labels=[];
            var s1 = [];    //Y軸資料
            for (i = 0; i < obj.length; i++) {
                labels.push(obj[i].AuthKind);
                s1.push(obj[i].TotalCount);
            }

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

    </script>
    <script 
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8l5sw6XrpWqqFNfqNqCSxB69YS1AQQVI&callback=initMap">
    </script>
    <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
