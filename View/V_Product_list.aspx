<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Product_list.aspx.cs" Inherits="View_V_Product_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <link rel="stylesheet" type="text/css" href="../css/ProductList.css" />
    <title>商品區A</title>
</head>
<body >
    <div id="wrapper" >
    <div id="header">
        <p><img src="../Image/PageTop.jpg" /></p>
        <div id="MenuButton"></div>
    </div>
    <div id="nav">
        <!-- 動態塞資料 -->
    </div>
    <div id="content"></div>
    <div id="footer"></div>
    </div>

    <script>

        //要先解析開啟的網頁傳輸進來的資料
        function show() {
            $("table").empty();
            //URL
            var url = location.href;
            //取得問號之後的值
            var temp = url.split("?");
            //取得kind=之後的值(只有一個參數的時候) hxxp://Test.net/Test.aspx?kind=1  
            var kinds = url.split("?kind=");
            //初始化
            if (kinds.length > 1)
                Init(kinds[1]);
           
            //if (kinds[1] == 1) {
            //    document.title = "AA";
            //} else
            //    document.title = "BB";
        }

        $(document).ready(function () {
            show();
        });

        function Init(id) {
            QueryProduct(id);
        }

        function QueryProduct(id) {
            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
                    data: "&Kind=" + id,
                    url: "../Model/M_GetProduct.aspx",
                    success: function (result) {
                        CreateProduct(result);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function CreateProduct(result) {
            $("#nav").append(result);
        }

    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>
