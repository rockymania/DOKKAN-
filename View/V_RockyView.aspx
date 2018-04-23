﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_RockyView.aspx.cs" Inherits="View_V_RockyView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>商品區A</title>
    <style>
        td>p{
            text-align:center;
        }
        td>p>a>img{
            height:250px;
            width:250px;
            top:5px;
        }
        #nav{
            width:980px;
            padding-top:50px;
            margin:auto;
            
        }
        #productTable{
            width:980px;
            background-color:aqua;
            display:inline-block;
        }
        .TableItem{
            float:left;
            padding:0px 0px 0px 15px; 
            margin: auto;
        }/*上 右 下 左*/
         .ProductPage{
             background-image:url("../Image/Product/background.jpg");
         }
    </style>
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
        $(document).ready(function () {
            Init();
        });

        function Init() {
            QueryProduct();
        }

        function QueryProduct() {
            $.ajax(
                {
                    type: "GET",
                    dataType: "text",
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
            //document.all["nav"].insertAdjacentHTML("BeforeEnd", result);
        }

    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>
