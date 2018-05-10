<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_SignUp.aspx.cs" Inherits="View_V_SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>註冊帳號</title>
    <style>
        .CenterObj {
            text-align:center;
        }
        #header {
            margin:30px ;
        }
        .DataList {
            margin:25px;
        }
    </style>

</head>
<body>
<div id="wrapper">
        <div id="header" class="CenterObj">註冊帳號</div>
        <div id="nav" class="CenterObj">
            <div class="DataList" id="Account"><input placeholder="請輸入帳號"</div>
            <div class="DataList" id="Password"><input placeholder="請輸入密碼"</div>
            <div class="DataList" id="PasswordAgain"><input placeholder="請再次輸入密碼"</div>
            <div class="DataList" id="Name"><input placeholder="請輸入姓名"</div>
            <div class="DataList" id="NickName"><input placeholder="請輸入暱稱"</div>
            <div class="DataList" id="Phone"><input placeholder="請輸入手機"</div>
            <div class="DataList" id="Mail"><input placeholder="請輸入信箱"</div>
            <div class="DataList"><button type="button" onclick="SignUp()">送出</button></div>
        </div>
        <div id="content"></div>
        <div id="footer"></div>
</div>
<script>
    function SignUp()
    {
        
    }

    function CheckData()
    {
        if()
    }
</script>

</body>
</html>
