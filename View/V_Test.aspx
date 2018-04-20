<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Test.aspx.cs" Inherits="View_V_Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
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
    </style>
</head>
<body>
<div id="wrapper">
    <div id="header"></div>
    <div id="nav1">nav1</div>
    <div id="nav2">nav2</div>
    <div id="content"></div>
    <div id="footer">footerfooterfooterfooterfooterfooterfooterfooterfooter</div>
</div>
</body>
</html>
