<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_ShopCar.aspx.cs" Inherits="View_V_ShopCar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>購物車</title>
    <style>
        .td1{
            border-right:1px solid;
            border-left:1px solid;    
            text-align:left;
        }

        .td2{
            border-right:1px solid;
            border-left:1px solid;
            text-align:center;
        }

        .td3{
            border-right:1px solid;
            border-left:1px solid;   
            text-align:right;
        }
        .tabletr{
            background-color:pink;
            height:16px;
        }
        #imgscroll{
            height:100px;
            width:960px;
        }
        table{
            width:800px;
        }
        #ButtonList > button{
            margin:0px 150px 0px 100px;
        }
        .TitleInfo {
            text-align:center;
            background-color:yellow;
            height:20px;
        }
        .GetInfo {
            text-align:center;
            background-color:yellow;
            height:20px;
        }
        #CardInfo {
            
        }
        dd {
            margin:10px 10px;
            width:980px;
        }
        dd > ul > li {
            width:200px;
            display:inline;
            padding:20px 20px;
        }

        dd > ul {
            width:970px;
        }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="header">
        <div id="MenuButton"></div>
        <p><img id="imgscroll" src="../Image/PageTop.jpg" /></p>
    </div>
    <div id="nav">
        <table border="1" id="navTable">
           <tr>
      	    <td style="width:280px">商品名稱</td>
      	    <td style="width:150px">規格</td>
      	    <td style="width:100px">數量</td>
      	    <td style="width:140px">單價</td>
      	    <td style="width:140px">小計</td>
            <td style="width:140px"></td>
           </tr>
             <%--<tr class="tabletr">
                <td class ="td1">商品名稱</td>
                <td class ="td1">規格</td>
                <td class ="td2">數量</td>
                <td class ="td3">單價</td>
                <td class ="td3">小計</td>
                <td><button onclick="">取消</button></td>
            </tr>--%>
        </table>
    </div>
    <div id="content">
       <p style="border-bottom:groove;border-top:groove; padding:10px 0px 10px 0px">配送方式:
           <input type="radio" name="Goto" checked="true"/>宅配到府
           <input type="radio" name="Goto"/>超商取貨
       </p>

    </div>
    <div id="footer">
        <dl id="CardInfo" style="width:980px;">
            <dt class="TitleInfo">購買人</dt>
            <dd>
                <ul>
                    <li>姓名
                        <input type="text"  id="BuyName" size="12"/>
                    </li>
                    <li>手機
                        <input type="tel" id="BuyNumber" size="12" />
                    </li>
                    <li>信用卡卡號
                        <input type="text" id="CardNumber" size="12" />
                    </li>
                    <p></p>
                    <li>有效期限
                        <select id="Ef_CardMonth">
                            <option value="0">----</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                        </select>月

                        <select id="Ef_CardYear">
                            <option value="0">----</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025">2025</option>
                        </select>年
                    </li>

                    <li>卡片後三碼
                        <input type="password" maxlength="3" style="width:30px" />
                    </li>
                    <p></p>
                    <li>地址
                        <select id="AddressCity" onchange="GetCountryData(0)">
                            <option value="0">請選擇縣市</option>
                            <option value="1">基隆市</option>
                            <option value="2">台北市</option>
                            <option value="3">新北市</option>
                        </select>

                        <select id="AddressArea">
                            <option value="0">請選擇區</option>
                        </select>

                        <input id="Address" type="text"; style="width:200px;"/>
                    </li>

                </ul>
            </dd>

            <dt class="GetInfo">收貨人</dt>
                <dd>
                    <ul>
                        <li>姓名
                            <input type="text" id="GetName" size:"12" style="width:105px;" />
                        </li>
                        <li>手機
                            <input type="tel" id="GetPhone" size:"12" style="width:105px;"/>
                        </li>
                        <p></p>
                        <li>收貨地址
                            <select id="GetAddressCity" onchange="GetCountryData(1)">
                                <option value="0">請選擇縣市</option>
                                <option value="1">基隆市</option>
                                <option value="2">台北市</option>
                                <option value="3">新北市</option>
                            </select>

                            <select id="GetAddressArea">
                                <option value="0">請選擇區</option>
                            </select>
                            <input  id="GetAddress" type="text";style="width:200px;"/>
                        </li>
                    </ul>
                </dd>
        </dl>

        <button type="button" onclick="Button_Send()" style="margin:50px 400px;">確定送出</button>
    </div>
</div>

    <script>
        $(document).ready(function () {
            init();
            //取得點選購買紀錄
        });
        //要先解析開啟的網頁傳輸進來的資料
        function init() {
            var CookieShopCar = readCookie('Ricky');
            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
                    url: "../Model/M_GetShopCar.aspx",
                    data: "&CookieShopCar=" + CookieShopCar,
                    success: function (result) {
                        CreateShopCar(result);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function CreateShopCar(result) {
            $("#navTable").append(result);
            //$("TableP").
        }

        function ClearProduct(iID) {
            DelProductItem('Ricky', iID);

            location.reload();
        }

        function GetCountryData(index)
        {
            var aID;
            if (index == 0)
            {
                aID = $("#AddressCity").val();
            }
            else
            {
                aID = $("#GetAddressCity").val();
            }

            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
                    url: "../Model/M_GetCountry.aspx",
                    data: "&ID=" + aID,
                    success: function (result) {

                        var select;

                        if (index == 0)
                        {
                            select = document.getElementById("AddressArea");
                        }
                        else
                        {
                            select = document.getElementById("GetAddressArea");
                        }

                        for (var i = select.options.length - 1; i >= 0; i--) {
                            select.remove(i);
                        }

                        var jsonObj = JSON.parse(result);

                        var aNew_Option = new Option("請選擇區", "0")
                        select.options.add(aNew_Option);

                        for (var i = 0; i < jsonObj.CountryName.length; i++)
                        {
                            var new_option = new Option(jsonObj.CountryName[i], jsonObj.CountryName[i]);
                            select.options.add(new_option);

                        }
                    },
                    error: function () {
                        alert("error");
                    }
                }
            );   
        }

        function Button_Send()
        {
            if (CheckUserInfo() == false)
                return;

            var aJsonData = JSON.stringify(GetJsonData());

            $.ajax({
                type: "GET",
                dataType: "text",
                url: "../Model/M_BuyProduct.aspx",
                data: "&JsonData=" + aJsonData,

                success: function (result)
                {
                    alert(result);
                    eraseCookie("Ricky");
                    location.reload() 

                },
                error: function (err)
                {
                    alert(err);
                }
                

            });

        }
        //取得要回傳的資料結構
        function GetJsonData()
        {
            var aBuyName = $("#BuyName").val();
            var aBuyPhone = $("#BuyNumber").val();
            var aCardNumber = $("#CardNumber").val();
            var aCardMonth = $("#Ef_CardMonth").val();
            var aCardYear = $("#Ef_CardYear").val();
            var aPassword = $("#password").val();
            var aBuyAddressCity = $("#AddressCity").val();
            var aBuyAddressArea = $("#AddressArea").val();
            var aBuyAddress = $("#Address").val();
            var aGetName = $("#GetName").val();
            var aGetPhone = $("#GetPhone").val();
            var aGetAddressCity = $("#GetAddressCity").val();
            var aGetAddressArea = $("#GetAddressArea").val();
            var aGetAddress = $("#GetAddress").val();

            var aJsonData =
                {
                    BuyName: aBuyName,
                    BuyPhone: aBuyPhone,
                    CardNumber : aCardNumber,
                    CardMonth : aCardMonth,
                    CardYear : aCardYear,
                    Password : aPassword,
                    BuyAddressCity : aBuyAddressCity,
                    BuyAddressArea : aBuyAddressArea,
                    BuyAddress : aBuyAddress,
                    GetName : aGetName,
                    GetPhone : aGetPhone,
                    GetAddressCity : aGetAddressCity,
                    GetAddressArea : aGetAddressArea,
                    GetAddress : aGetAddress,
                };

            return aJsonData;
        }

        function CheckUserInfo()
        {
            if ($("#BuyName").val() == "") {
                alert("購買人姓名未填寫");
                return false;
            }
            if ($("#BuyNumber").val() == "") {
                alert("購買人電話未填寫");
                return false;
            }
            if ($("#CardNumber").val() == "") {
                alert("信用卡卡號未填寫");
                return false;
            }
            if ($("#Ef_CardMonth").val() == "0") {
                alert("信用卡有效月未填寫");
                return false;
            }
            if ($("#Ef_CardYear").val() == "0") {
                alert("信用卡有效年未填寫");
                return false;
            }
            if ($("#password").val() == "") {
                alert("信用卡驗證碼未填寫");
                return false;
            }
            if ($("#AddressCity").val() == "0") {
                alert("購買人縣市未填寫");
                return false;
            }
            if ($("#AddressArea").val() == "0") {
                alert("購買人區未填寫");
                return false;
            }
            if ($("#Address").val() == "") {
                alert("購買人地址未填寫");
                return false;
            }
            if ($("#GetName").val() == "") {
                alert("收貨人姓名未填寫");
                return false;
            }
            if ($("#GetPhone").val() == "") {
                alert("收貨人電話未填寫");
                return false;
            }
            if ($("#GetAddressCity").val() == "0") {
                alert("收貨人縣市未填寫");
                return false;
            }
            if ($("#GetAddressArea").val() == "0") {
                alert("收貨人區未填寫");
                return false;
            }
            if ($("#GetAddress").val() == "") {
                alert("收貨人地址未填寫");
                return false;
            }
            return true;
                
        }
    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
    <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
