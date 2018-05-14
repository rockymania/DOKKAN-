<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Order.aspx.cs" Inherits="View_V_Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <style>
        h3{ 
            color:white;
            background-color:hotpink;
        }
        #TopTable{
            width:800px;
            /*background-color:hotpink;*/
            /*border-spacing:0px 10px;*/
            margin-top:50px;
        }
        #TopTable #TopTr td{
            font-size:12px;
            font-family:'Microsoft JhengHei';
            text-align:center;
        }
        .OrderTr
        {
            font-family: verdana;
            font-size: 11px;
            background-color: #feb0bd;
            text-align: center;
            line-height: 18px;
        }
        .SliderP
        {
            display:none;
        }
        .DetailTr
        {
             font-family: verdana;
            font-size: 11px;
            background-color:palevioletred; 
            text-align: center;
            line-height: 15px;
        }
    </style>
    <title>訂單查詢</title>
</head>
<body>
    <div id="wrapper">
        <div id="header">
            <div id="MenuButton"></div>
            <h3>訂單查詢</h3>
        </div>
        <div id="nav">
        </div>
        <div id="content">
        </div>
        <div id="footer"></div>
    </div>
    <script>
        function Test(id) {
            $("#"+id).slideToggle();
        }

        $(document).ready(function () {
            Init();
        })
        function Init() {
            GetOrder();
        }
        function GetOrder() {
            var aAccount = readCookie('Account');
            $.ajax(
                {
                    dataType: "text",
                    type: "GET",
                    url: "../Model/M_GetOrder.aspx",
                    data: {
                        "Account": aAccount,
                    },
                    success: function (result) {
                        $("#nav").append(result);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }
    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
    <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
