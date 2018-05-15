<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_SignUp.aspx.cs" Inherits="View_V_SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/localization/messages_zh_TW.js" charset="UTF-8" ></script>
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
        	.error {
		/* 當格式錯誤時，則新增此類別 */
		border-color: red !important
	}
    </style>

</head>
<body>
    <form id="commentForm" method="post">
        <div id="wrapper">
                <div id="header" class="CenterObj">註冊帳號</div>
                <div id="nav" class="CenterObj">
                    <div class="DataList" ><input name="Account" id="Account" placeholder="請輸入帳號" required />
                        <br />
                        <label for="Account" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList"><input name="Password" id="Password" type="password" placeholder="請輸入密碼" required/>
                        <br />
                        <label for="Password" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList" ><input name="PasswordAgain" id="PasswordAgain" type="password" placeholder="請再次輸入密碼" required/>
                        <br />
                        <label for="PasswordAgain" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList" ><input name="Name" id="Name" placeholder="請輸入姓名" required/>
                        <br />
                        <label for="Name" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList" ><input id="NickName" name="NickName" placeholder="請輸入暱稱" required/>
                        <br />
                        <label for="NickName" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList" ><input id="Phone" name="Phone" placeholder="請輸入手機" required/>
                        <br />
                        <label for="Phone" class="error" style="color:red;"></label>
                    </div>
                    <div class="DataList" ><input id="Mail" name="Mail" placeholder="請輸入信箱" required/>
                        <br />
                        <label for="Mail" class="error" style="color:red;"></label>
                    </div>

                    <div class="DataList"><button type="submit" value="Submit">送出</button></div>
                </div>
                <div id="content"></div>
                <div id="footer"></div>
        </div>
        </form>
<script>
    $(document).ready(function () {

        $("#commentForm").validate({
            errorPlacement: function (error, element) {
                return true;
            },
            rules: {
                Account: { required: true, minlength: 1 },
                Password: { required: true, minlength: 1 },
                PasswordAgain: { required: true, minlength: 1, equalTo: "#Password"},
                Name: { required: true, minlength: 1 },
                NickName: { required: true, minlength: 1 },
                Phone: { number: true, minlength: 10, maxlength: 10 },
                Mail: { email: true, required: true },
            },
            messages: {
                name: {
                    maxlength: "姓名不能大於10個字."
                },
                Phone: { number: "只能輸入數字", minlength: "請輸入正確手機格式", maxlength: "請輸入正確手機格式" },
                PasswordAgain: { equalTo:"密碼不相同"}
            },
            submitHandler: function (form) {
                //可以在這裡改成用$.ajax()送出。
                SignUp();
                return false; //回傳false會阻止原本的form submit。
            }    
        });
        })


    function SignUp()
    {
        $.ajax({
            type: "GET",
            url: "../Model/M_SignUp.aspx",
            data: {
                Account: $("#Account").val(),
                Password: $("#Password").val(),
                Name: $("#Name").val(),
                NickName: $("#NickName").val(),
                Phone: $("#Phone").val(),
                Mail: $("#Mail").val(),
            },
            success: function (result)
            {
                switch (result)
                {
                    case "1":
                        alert("帳號創立成功");
                        createCookie('Account', $("#Account").val(), 1);
                        location.href = "V_index.aspx";
                        break;
                    default:
                        alert(result);
                        break;
                }
            },
            error: function (err)
            {
                alert(err);
            }
        });
    }

</script>
        <script type="text/javascript" src="../Js/Common.js"></script>
</body>
</html>
