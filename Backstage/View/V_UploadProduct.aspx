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
    <style>
        .easyui-textbox {
            width:400px;

        }
        .CenterList {
            margin:20px -60px;
        }

    </style>

    <title>新增販售商品</title>
</head>
<body>
    <div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="新增上架商品" style="padding:5px;"><%--Center中間區塊 --%>
            <div style="margin:20px 200px;">
                   <input id="ExcelFile" type="file" name="ExcelFile" />
                   <a href="javascript:GetExcelData()" class="easyui-linkbutton" style="margin-right:0px">匯入資料</a>  
            </div>

        <div id="ShowClass" style="margin:20px 300px;">
            <input class="easyui-combobox" id="ProductSelect"  data-options="valueField:'id', textField:'text', panelHeight:'auto'" />

            <div class="CenterList">
                <label>產品ID</label>
                <input class="easyui-textbox" name="ProductID" id="ProductID" data-options="label:':'" />
            </div>

            <div class="CenterList">
                <label>產品名稱</label>
                <input class="easyui-textbox" name="ProductName" id="ProductName" data-options="label:':'" />
            </div>

            <div class="CenterList">
                <label>產品價格</label>
                <input class="easyui-numberbox" name="ProductPrice" id="ProductPrice" style="width:400px" data-options="min:1,max:1000,required:true,label:':'" />
            </div>

            <div class="CenterList">
                <label>產品數量</label>
                <input class="easyui-numberbox" name="ProductCount" id="ProductCount" value="1" style="width:400px" data-options="min:1,max:1000,required:true,label:':'"  />
            </div>
            <div style="margin:20px 70px">
                <a href="javascript:QueryOnline()" class="easyui-linkbutton">上傳</a>
            </div>
        </div>
		</div>

	</div>

    <script>

        var aProductData = {
            ProductID: {},
            ProductName: {},
            Price:{}
        }

        var aSetExcel = false;
        var aSelectIndex = 0;

        var aSelectData = {};

        function QueryOnline()
        {
            $.ajax({
                url: "../Model/M_UploadProduct.aspx",
                type:"POST",
                data: {
                    ProductName: aProductData.ProductName[aSelectIndex],
                    ProductID: aProductData.ProductID[aSelectIndex],
                    ProductPrice: $("#ProductPrice").numberbox('getValue'),
                    ProductCount: $("#ProductCount").numberbox('getValue')
                },
                success: function (result)
                {
                    switch (result)
                    {
                        case "0":
                            alert("成功上傳到資料庫");
                            break;
                        case "1":
                            alert("傳入參數錯誤");
                            break;
                        case "2":
                            alert("資料庫已有資料");
                            break;
                    }
                },


            })
        }

        function GetExcelData() {
            if (aSetExcel == true)
            {
                alert("檔案已載入");
                return;
            }

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

                    switch (result.Result) {
                        case "0":
                            aProductData.ProductID = result.ProductID;
                            aProductData.ProductName = result.ProductName;
                            aProductData.Price = result.Price;

                            var aData = new Array();

                            for (var i = 0; i < aProductData.ProductID.length; i++)
                            {
                                if(i != 0)
                                    aData.push({ text: aProductData.ProductName[i], value: aProductData.ProductID[i] });
                                else
                                    aData.push({ text: aProductData.ProductName[i], value: aProductData.ProductID[i], selected:true });
                            }

                            $("#ProductSelect").combobox({
                                data: aData,
                                valueField: 'value',
                                textField: 'text'
                            });

                            alert("載入成功");
                            aSetExcel = true;
                            $("#ShowClass").show();
                            break;
                        case "1":
                            alert("沒有檔案或是檔案有問題");
                            break;
                        case "2":
                            alert("上傳Excel失敗");
                            break;
                        case "3":
                            alert("Excel格式有誤");
                            break;
                        default:
                            alert(result);
                            break;
                    }
                }
            })
        }

        function ChangeProductData(value)
        {
            aSelectIndex = value -1;
            $("#ProductID").textbox('setText', aProductData.ProductID[value - 1]);
            $("#ProductName").textbox('setText', aProductData.ProductName[value - 1]);
            $("#ProductPrice").textbox('setValue', aProductData.Price[value - 1]);
        }

        function Init()
        {
            $("#ProductSelect").combobox({
                valueField: 'value',
                textField: 'text',
                onChange: function (value) {
                    ChangeProductData(value);
                }
            });
            $("#ProductID").textbox('textbox').attr('readonly', true);
            $('#ProductID').textbox('textbox').css('background', '#DDDDDD');
            $("#ProductName").textbox('textbox').attr('readonly', true);
            $('#ProductName').textbox('textbox').css('background', '#DDDDDD');
        }
        $(document).ready(function () {
            $("#ShowClass").hide();
            Init();
        });
    </script>

    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
