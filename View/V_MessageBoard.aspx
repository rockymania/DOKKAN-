<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_MessageBoard.aspx.cs" Inherits="View_V_MessageBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/additional-methods.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/localization/messages_zh_TW.js" charset="UTF-8" ></script>
    <link rel="stylesheet" type="text/css" href="../css/layout.css" />
    <title>留言板</title>
    <style>
        .MessTitle{
            color:black;
            background-image:url("../Image/MessageBox/content_bg.jpg");
            width:100%;
            height:140px;
            top:0;
            background-size:100% auto;
        }
        .BiggestTitle {
            font-size: 32px;
            margin-bottom: 20px;
            color:coral;
            font-style:italic;
            font-family:DFKai-SB;
        }
        .SmallP{
            font-size:10px;
        }
        .orange {
        color: #f57d13;
        }
        .tableInfoAll table.tableInfo {
            vertical-align: top;
            display: table-cell;
        }
        .tableInfoAll {
        display: table;
        width: 100%;
        }
        .tableInfoAll table.tableInfo tr td:first-of-type {
            text-align: right;
            height: 47px;
            line-height: 47px;
            padding-right: 10px;
            background-color: #f5f5f5;
        }
        input[type="text"], input[type="password"] {
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
            border: 1px solid #ddd;
            line-height: 30px;
            height: 30px;
            padding: 0 5px;
        }
        .vt{
            width:120px;
            vertical-align:top;
        }
        .Sectitle{
            font-size: 22px;
            margin-top: 20px;
            margin-bottom: 20px;
            color:coral;
            font-family:DFKai-SB;
        }
        .error{
            color:red;
            font-weight:300;
        }
        .CenterBtn{
            display:block;
            margin:auto;
            width:200px;
        }
         .Thirdtitle{
            font-size: 22px;
            margin-top: 20px;
            margin-bottom: 20px;
            /*color:dimgrey;*/
            font-family:DFKai-SB;
            background-color:red;
        }
         .Messagetable td{
             width:200px;
         }
         .Messagetable {
             height:50px;
         }
         .Toptable
         {
             width:800px;
             border:1px solid red;
             margin:0 auto;
         }
        .button {
            display:inline-block;
        }
    </style>
</head>
<body>
    <form id="commentForm" method="post">
    <div id="wrapper">
    <div id="header">
        <div id="MenuButton"></div>
        <div class="MessTitle">
            <h1 class="BiggestTitle">訪客留言版</h1>
            <div class="SmallP">
                <div>親愛的顧客，您好</div>
                 <div>有事請留言</div>
                <span class="orange">貼心提醒：緊急事件</span>
            </div>
        </div>
    </div>
    <div id="Data">
        
        <table class="tableInfo" id="TableInfo">
            <tr>
                <td class="vt">
                    <b class="orange">*</b>姓名
                </td>
                <td>
                    <input type="text" size="25" id="name" name="name" aria-required="true" class="required"/>
                </td>
            </tr>
            <tr>
                <td class="vt">
                    <b class="orange">*</b>電子信箱
                </td>
                <td>
                    <input type="text" size="25" id="Email" name="Email" maxlength="50" aria-required="true" class="required email" />
                </td>
            </tr>
            <tr>
                <td class="vt">
                    <b class="orange">*</b>手機號碼
                </td>
                <td>
                    <input type="text" size="25" id="Phone" name="Phone" aria-required="true" class="required"/>
                </td>
            </tr>
        </table>
           
    </div>
    <div class="Sectitle">留言內容</div>
    <div id="content">
        <table>
            <tr>
                <td><b class="orange">*</b>內容</td>
                <td>
                    <textarea rows="10" cols="100" id="Message"  name="Message" style="resize:none" class="required"></textarea>
                </td>
            </tr>
        </table>   
        <div class="CenterBtn">
            <input class="submit" type="submit" value="送出"/>
        </div>
    </div>
    <div class="Thirdtitle">歷史留言</div>
    <div id="MessageData"></div>
    <div style="width:200px; margin:0 auto; margin-top:20px;">
        <input class="button" type="button" value="上一頁"onclick="PageUp()"/>
        <input class="button" type="button" value="下一頁" onclick="PageDown()"/>
    </div>

    <div id="footer">
        <%--CustomerMessage--%>
    </div>
</div>
         </form>
    <script>
        var page = 1;
        var aTotalPage = 0;
        $(document).ready(function () {

            $("#commentForm").validate({
                rules: {
                    name: { maxlength: 10  },
                    Phone: { number: true, minlength: 10, maxlength: 10 },
                    Message: { minlength: 0, maxlength: 500 },
                },
                messages: {
                    name: {
                        maxlength: "姓名不能大於10個字."
                    },
                    Phone: { number: "只能輸入數字", minlength: "請輸入正確手機格式", maxlength: "請輸入正確手機格式" },
                    Message: {
                        maxlength: "不能超過500字"
                    },
                },
            });
            GetTotalMessage(page);
        })

        $.validator.setDefaults({
            submitHandler: function () {
                var aName = $("#name").val();
                var aEmail = $("#Email").val();
                var aPhone = $("#Phone").val();
                var aMessage = $("#Message").val();
                var aAccount = readCookie('Account');
                $.ajax(
                    {
                        dataType: "text",
                        type: "GET",
                        //data: "&Name=" + aName + "&Email=" + aEmail + "&Phone=" + aPhone + "&Message=" + aMessage,
                        data: {
                            "Name": aName,
                            "Email": aEmail,
                            "Phone": aPhone,
                            "Message": aMessage,
                            "Account": aAccount,
                        },
                        url: "../Model/M_MessageBoard.aspx",
                        success: function (result) {
                            if (result == "0")
                                alert("成功");
                            else
                                alert("錯誤")
                        },
                        error: function () {
                            alert("error");
                        }
                    });
            }
        });

        function PageUp() {
            if (page > 1) {
                page -= 1;
                GetMessage(page);
            }
        }

        function PageDown() {
            if (page + 1 > aTotalPage) { }
            else {
                page += 1;
                GetMessage(page);
            }
        }

        function GetTotalMessage(iPage) {
            //var Account = 
            var aAccount = readCookie('Account');
            $.ajax(
                {
                    dataType: "text",
                    type: "GET",
                    //data: "&Kind=1" + "&Page=" + iPage,
                    data: {
                        "Kind": 1,
                        "Page": iPage,
                        "Account": aAccount,
                    },
                    url: "../Model/M_GetMessageBoard.aspx",
                    success: function (result) {
                        aTotalPage = Math.ceil(result/5);
                        GetMessage(page);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }

        function GetMessage(iPage) {
            var aAccount = readCookie('Account');
            $.ajax(
                {
                    dataType: "text",
                    type: "GET",
                    //data: "&Kind=2" + "&Page=" + iPage,
                    data: {
                        "Kind": 2,
                        "Page": iPage,
                        "Account": aAccount,
                    },
                    url: "../Model/M_GetMessageBoard.aspx",
                    success: function (result) {
                        $("#MessageData").empty();
                        $("#MessageData").append(result);
                    },
                    error: function () {
                        alert("error");
                    }
                });
        }
    </script>
    <script type="text/javascript" src="../Js/MenuButton.js"></script>
    <script type="text/javascript" src="../Js/Common.js"></script>
    <script type="text/javascript" src="../Js/Top.js"></script>
</body>
</html>
