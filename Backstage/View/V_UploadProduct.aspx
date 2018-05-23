<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_UploadProduct.aspx.cs" Inherits="Backstage_View_V_UploadProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <!--多檔案上傳用-->
    <%--<script src="//github.com/fyneworks/multifile/blob/master/jQuery.MultiFile.min.js" type="text/javascript" language="javascript"></script>--%>
    <title>新增販售商品</title>
</head>
<body>
    <div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="新增上架商品" style="padding:5px;"><%--Center中間區塊 --%>
        <input id="ExcelFile" type="file" name="ExcelFile" />
        <a href="javascript:GetExcelData()" class="easyui-linkbutton" style="margin-right:0px">匯入資料</a>  
        <div id="ShowClass">

        </div>
		</div>

	</div>

    <script>
        function QueryOnline()
        {

        }

        function GetExcelData()
        {
            var vData = new FormData();
            var vFile = $("#ExcelFile").get(0).files;

            if (vFile.length > 0)
            {
                vData.append("ExcelFile", vFile[0]);
            }
            else
            {
                window.alert("沒選擇檔案");
                return;
            }

            $.ajax({
                type: "POST",
                url: "../Model/M_GetExcelProductData.aspx",
                contentType: false,
                processData: false,
                dataType: "JSON",
                data: vData,

                success: function (result) {
                    switch (result) {
                        case 0:
                            alert("上傳成功");
                            break;
                        case 1:
                            alert("沒有檔案或是檔案有問題");
                            break;
                        case 2:
                            alert("上傳Excel失敗");
                            break;
                        default:
                            alert(result);
                            break;
                    }
                }
            })
        }

    </script>

    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
