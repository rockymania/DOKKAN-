<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_Login.aspx.cs" Inherits="View_V_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>登入</title>
    <style>
        #header {
            width:980px;
        }
        #nav {
            width:70%;
            height:100% auto;
            float:left;
        }
        #content {
            width:30%;
            float:right;

        }
        #footer{
            width:980px;
             clear:both;
        }

        .InputObj {
            margin:0 auto;
            width:auto;
        }
        .CenterPos{
            text-align:center;
        }
        .ColorCenter{
            color:red;
        }
    </style>

</head>
<body>
    <div id="wrapper">
        <div id="header">我在頂部</div>
        <div id="nav">
            <%--<div id="Left_Background"></div>--%>
            <img src="../Image/Login/Dokkan_0.jpg" />
        </div>
        <div id="content">
           <img src="../Image/Login/Dokkan.jpg" style="width:294px;"  class="CenterPos"/>
            <div style="width:auto; font-family:fantasy;font-size:20px; text-align:center">登入 </div>
            <br />

            <div class="CenterPos ColorCenter">帳號</div>
            <div class="CenterPos" style="margin:40px;">
                  <input id="Account" type="text" placeholder="請輸入帳號" style="border-bottom-style:solid;border-top-style:none;border-left-style:none;border-right-style:none;"/>
            </div>
            <div class="CenterPos ColorCenter">密碼</div>
            <div class="CenterPos" style="margin:40px;">
                <input id="Password" type="password" placeholder="請輸入密碼" style="border-bottom-style:solid;border-top-style:none;border-left-style:none;border-right-style:none;" />
            </div>

            <br />
            <div class="CenterPos">
                <button onclick="Login()">登入</button>
            </div>

            <div align="center" style="margin:50px 0px 0px 0px">沒有帳號嗎?
                <a href="V_SignUp.aspx">註冊</a>
            </div>
            
        </div>
        <div id="footer"></div>
    </div>


<script>
        function Login() {
            var aAccount = $("#Account").val();
            var aPassword = $("#Password").val();

            $.ajax(
                {
                    type: "Get",
                    dataType: "text",
                    url: "../Model/M_Login.aspx",
                    data: "&Account=" + aAccount + "&Password=" + aPassword,
                    success: function (result)
                    {
                        alert(result);
                    },
                    error: function (err)
                    {
                        alert(err);
                    }


                }
            )

        }
</script>

</body>
</html>


