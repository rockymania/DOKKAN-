<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_ProductPage.aspx.cs" Inherits="View_V_ProductPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/flexslider.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title></title>

    <style>
        #header {
            width:980px;
        }
        #nav {
            width:49%;
            float:left;
        }

        #content {
            width:49%;
            float:right;
        }

        #footer {
            width:980px;
            clear:both;
        }
        #Title {
            font-weight:bold;
            font-size:30px;
            color:lightpink;
            margin:50px 50px;
        }

        #content li {
            margin-left:50px;
        }

        #Price {
            color:red;
            font-weight:bold;
            font-size:40px;
            margin-left:300px;
        }

        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { 
        -webkit-appearance: none; 
        margin: 0; 
        
        }
        #ValueBox {
            padding:0px 0px 0px 350px;
        }
        #BuyCar {
            padding:50px 0px 0px 350px;
        }

    </style>

</head>

<body>
    <div id="wrapper">
    
        <div id="header">
            <div id="MenuButton"></div>
        </div>
        <div id="nav">
            <div class="flexslider">
                <ul class="slides" id="BannerMain">
                </ul>
            </div>
        </div>
        <div id="content">
            <div id="content2"></div>
            <p id="ValueBox">
                <button type="button" onclick ="CutCount()">-</button>
                <input id="Number" type="number" style="width:30px;text-align:center" value="1" />
                <button type="button" onclick="AddCount()">+</button>
            </p>
            <p id="BuyCar">
                <button type="button" onclick="AddBuyCar()">加入購物車</button>
            </p>
        </div>
        <div id="footer">我在底部</div>
    </div>

    <script>
        function Init(id) {
            QueryBanner(id);
            QueryDetail(id);
            createCookie("ProductID", id, 1);
        }

        function QueryBanner(id) {
            $.ajax(
                {
                    type: "GET",
                    data: "&Kind=" + id,
                    url: "../Model/M_GetProductPic.aspx",
                    success: function (result) {
                        CreateBanner(result);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function CreateBanner(result) {
            $("#BannerMain").append(result);

            InitFlexSlider();
        }

        $(document).ready(function () {

            var url = location.href;
            //取得問號之後的值
            var temp = url.split("?");
            //取得kind=之後的值(只有一個參數的時候) hxxp://Test.net/Test.aspx?kind=1  
            var kinds = url.split("?kind=");
            //初始化
            if (kinds.length > 1)
                Init(kinds[1]);
        });

        function InitFlexSlider() {
            $('.flexslider').flexslider({
                animation: "slides"
            });
        }

        function QueryDetail(id)
        {
            $.ajax({
                type: "GET",
                data: "&Kind=" + id,
                url: "../Model/M_GetProductDetail.aspx",
                success: function(result)
                {
                    AddContent(result);
                },
                error: function (err)
                {
                    alert(err);
                }
            });
        }

        function AddContent(Content)
        {
            $("#content2").append(Content);
        }

        function AddCount()
        {
            var vCount = $("#Number").val();
            vCount++;
            $("#Number").val(vCount);
        }

        function CutCount()
        {
            var vCount = $("#Number").val();
            vCount--;
            if (vCount < 0)
                vCount = 0;
            $("#Number").val(vCount);
        }

        function AddBuyCar()
        {
            var aCookieData = "";

            var aProductID = readCookie("ProductID");

            var aProductCount = $("#Number").val();

            var test = readCookie("Ricky");

            //新的資料
            if (checkHaveCookieData("Ricky") == false || readCookie("Ricky") == "null")
            {
                aCookieData = aProductID + "|" + aProductCount;
            }
            else
            {
                if (checkHaveDetailData("Ricky", aProductID) == true)
                {
                    aCookieData = getNewProductCountData("Ricky", aProductID, aProductCount)
                }
                else
                {
                    //取得目前的cookie資料
                    aCookieData = readCookie("Ricky") + "," + aProductID + "|" + aProductCount;

                }
            }

            createCookie("Ricky", aCookieData, 1);
        }

    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
    <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
