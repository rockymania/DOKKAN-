<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_index.aspx.cs" Inherits="Backstage_View_V_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <title>登入頁面</title>
</head>
<body>
<div align="center">
       <div class="easyui-panel" title="使用者登入" style="padding:5px;width:400px;">
           <div style="padding:10px 60px 20px 60px">
               <table cellpadding="5">
                   <tbody>
                       <tr>
                           <td>Account:</td>
                           <td>
                               <input class="easyui-textbox" type="text" id="Account" name="Account" data-option="reqired:true" />
                           </td>
                       </tr>
                       <tr>
                           <td>Password:</td>
                           <td>
                               <input class="easyui-textbox" type="password" id="Password" name="Password" data-option="reqired:true" />
                           </td>
                       </tr>
                   </tbody>
               </table>
               <div style="text-align:center;">
                   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="">確認</a>
                   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="">取消</a>
               </div>

           </div>
    </div>
</div>

    <script>
        function Button_Sumbit()
        {
            $.ajax({
                url: "../Model/M_Login.aspx",
                type: "GET",
                data: {
                    Account: $("#Account").val(),
                    Password: $("Password").val(),
                },
                success: function (result)
                {
                    switch (result)
                    {
                        case "1":
                            window.location.replace("V_Main");
                            break;
                        default:
                            $.message.alerf('Fail', result, 'error');
                            break;
                    }

                },
                error: function (err)
                {

                }
            })
        }
        function Button_Cancel()
        {

        }

    </script>
</body>
</html>
