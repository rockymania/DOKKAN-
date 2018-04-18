<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="View_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/flexslider.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>首頁</title>
    <style>
        
        .flexslider .slides li img{
            height:240px;
        }
        .flexslider .slides{
            height:200px;
        }
        .flexslider{
            width:auto;
        }
    </style>
</head>
<body>
<div id="wrapper">
    
    <div id="header">
        <div class="flexslider">
          <ul class="slides">
            <li>
               <a href="V_Test.aspx" > <img src="../Image/Top1.jpg" /></a>
            </li>
            <li>
               <a href="V_Test2.aspx" ><img src="../Image/Top2.jpg" /></a>
            </li>
            <li>
             <a href="V_Test.aspx" >  <img src="../Image/Top3.jpg" /></a>
            </li>
            <li>
              <a href="V_Test2.aspx" > <img src="../Image/Top4.jpg" /></a>
            </li>
          </ul>
        </div>
        <div id="MenuButton"></div>
    </div>
    <div id="nav"></div>
    <div id="content"></div>
    <div id="footer"></div>
</div>

    <script>
        // Can also be used with $(document).ready()
        $(document).ready(function () {
            InitFlexSlider();
        });

        function InitFlexSlider() {
            $('.flexslider').flexslider({
                animation: "slides"
            });
        }
    </script>
    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>

