<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_RockyView.aspx.cs" Inherits="View_V_RockyView" %>

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
    </div>
    <div id="content"></div>
    <div id="footer"></div>
    </div>

    <script>

        $(document).ready(function () {
            Init();   
        });

        function Init(id) {
            QueryProduct();
        }

        function QueryProduct(id) {
            $.ajax(
                {
                    //type: "GET",
                    //dataType: "text",
                    //data: "&Kind=" + id,
                    //url: "../Model/M_GetProduct.aspx",
                    //success: function (result) {
                    //    CreateProduct(result);
                    //},
                    //error: function () {
                    //    alert("error");
                    //}
                });
        }
    </script>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>
