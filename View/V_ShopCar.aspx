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
    </style>
</head>
<body>
<div id="wrapper">
    <div id="header">
        <%--<div id="MenuButton"></div>--%>
        <p><img id="imgscroll" src="../Image/PageTop.jpg" /></p>
    </div>
    <div id="nav">
        <table>
           <tr style="visibility: hidden;">
      	    <td style="width:280px"></td>
      	    <td style="width:150px"></td>
      	    <td style="width:100px"></td>
      	    <td style="width:140px"></td>
      	    <td style="width:140px"></td>
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
        付款方式
    </div>
    <div id="footer">
        我是FOOTER
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
            $("#nav").append(result);
            //$("TableP").
        }
    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
    <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
