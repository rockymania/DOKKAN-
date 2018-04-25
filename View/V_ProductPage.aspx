<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_ProductPage.aspx.cs" Inherits="View_V_ProductPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/flexslider.css" media="all" />
    <link rel="stylesheet" type="text/css" href="/css/layout.css" />
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
                <input id="Number" type="number" style="width:30px;text-align:center" value="0" />
                <button type="button" onclick="AddCount()">+</button>
            </p>
        </div>
        <div id="footer">我在底部</div>
    </div>

    <script>
        function Init() {
            QueryBanner();
            QueryDetail();
        }

        function QueryBanner() {
            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
                    url: "../Model/M_GetBanner.aspx",
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
            
            Init();
        });

        function InitFlexSlider() {
            $('.flexslider').flexslider({
                animation: "slides"
            });
        }

        function QueryDetail()
        {
            $.ajax({
                type: "GET",
                //dataType: "txt",
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
    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>
