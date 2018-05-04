<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_MessageBoard.aspx.cs" Inherits="View_V_MessageBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://flexslider.woothemes.com/js/jquery.flexslider.js"></script>
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
    </style>
</head>
<body>
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
    <div id="Data" class="tableInfoAll">
        <table class="tableInfo">
            <tr>
                <td class="vt">
                    <b class="orange">*</b>姓名
                </td>
                <td>
                    <input type="text" size="25" name="name" maxlength="24" aria-required="true"/>
                </td>
            </tr>
            <tr>
                <td class="vt">
                    <b class="orange">*</b>電子信箱
                </td>
                <td>
                    <input type="text" size="25" name="email" maxlength="50" aria-required="true" />
                </td>
            </tr>
            <tr>
                <td class="vt">
                    <b class="orange">*</b>手機號碼
                </td>
                <td>
                    <input type="text" size="25" name="email" maxlength="50" aria-required="true" />
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
                    <textarea rows="10" cols="100" required="required" name="ContentText"  style="resize:none">請輸入你要輸入的內容</textarea>
                </td>
            </tr>
        </table>     
    </div>
    <div id="footer">
        <button style="margin-left:700px;">送出</button><%--CustomerMessage--%>
    </div>
</div>

    <script type="text/javascript" src="../Js/MenuButton.js"></script>
</body>
</html>
