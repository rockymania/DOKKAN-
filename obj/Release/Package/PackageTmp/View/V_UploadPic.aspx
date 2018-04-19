<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_UploadPic.aspx.cs" Inherits="View_V_UploadPic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <asp:Label ID="Label1" runat="server" Text="檔案名稱:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>Test0</asp:ListItem>
            <asp:ListItem>Test1</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <button type="button" onclick="UploadPic()">上傳</button>
    </form>
</body>
</html>

<script>
    function UploadPic()
    {
        var vData = new FormData();
        var vFile = $("#FileUpload1").get(0).files;
        var vFilePath = $("#DropDownList1").get(0).value;
        var aPicName = document.getElementById("TextBox1").value;
        

        if (vFile.length > 0)
        {
            vData.append("Pic", vFile[0]);
            vData.append("PicPath", vFilePath);
            vData.append("PicName", aPicName);

        }
        else
        {
            alert("無檔案");
            return;
        }

        if (aPicName == null || aPicName == "")
        {
            alert("檔案名稱為空");
            return;
        }

        $.ajax({
            type: "POST",
            url: "../Model/M_UploadPic.aspx",
            contentType: false,
            processData: false,
            dataType: "JSON",
            data: vData,

            success: function (result)
            {
                switch (result)
                {
                    case 0:
                        alert("上傳成功");
                        break;
                    case 1:
                        alert("沒有檔案或是檔案有問題");
                        break;
                    case 2:
                        alert("上傳圖片失敗");
                        break;
                }
            }


        })

    };

</script>
