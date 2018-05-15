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

            <div class="CenterPos" style="margin:50px 0px 0px 0px">沒有帳號嗎?
                <a href="V_SignUp.aspx">註冊</a>或
                <fb:login-button id="Button_FB" scope="public_profile,email" onlogin="checkLoginState();">
            </fb:login-button>
            </div>

            <div id="status">
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
                        switch (result)
                        {
                            case "1":
                                alert("登入成功");
                                createCookie('Account', $("#Account").val(), 1);
                                location.href = "V_index.aspx";
                                break;
                            case "2":
                                alert("密碼錯誤");
                                break;
                            case "3":
                                alert("無此帳號");
                                break;
                        }
                        
                    },
                    error: function (err)
                    {
                        alert(err);
                    }


                }
            )
    }
    window.fbAsyncInit = function () {
        FB.init({
            appId: '143835243111044',
            xfbml: true,
            version: 'v3.0'
        });
        
    };

    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    
    function statusChangeCallback(response) {
        
        if (response.status === 'connected') {
            LoginFBAPI(response.accessToken);
            
        } else if (response.status === 'not_authorized') {

            alert("請同意授權");
        } else {

            alert("請同意授權");
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {

        $("#Button_FB").hide();

        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function LoginFBAPI(iToken) {
        
        FB.api('/me', 'get', {
            access_token: iToken,
            fields: 'id, name, gender, age_range, birthday, cover, devices, email, first_name, last_name'
        }, function (response) {

            $.ajax({
                type: "GET",
                url: "../Model/M_FBSignUp.aspx",
                data: {
                    Mail: response.email,
                    Name: response.name,
                    FBID: response.id
                },
                success: function (result) {
                    switch (result)
                    {
                        case "1":
                            alert("登入成功");
                            location.href = "V_index.aspx";
                            break;
                        default:
                            alert(result);
                            break;
                    }
                },
                error: function (err) {
                    alert(err);
                }

            });
        });

    }
</script>
     <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>


