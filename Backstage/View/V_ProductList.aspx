<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_ProductList.aspx.cs" Inherits="Backstage_View_V_ProductList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <title></title>
</head>
<body>
       <div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="商城上商品" style="padding:5px;"><%--Center中間區塊 --%>
           

            <table id="table_data" class="easyui-datagrid" style="width:100%;height:90%"
			        method="get" title="商品資料" iconCls="icon-save"
			        rownumbers="true" toolbar="#tb" footer="#ft" singleSelect="true" >
            </table>

            <div id="tb" style="padding:2px 5px;">
                <a href="javascript:QueryOnline()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search</a>
            </div>
            
		</div>
	</div>
    <script type="text/javascript" src="../Js/Button.js"></script>

    <script>
        var aIndex = null;

        function QueryOnline()
        {
            var aUrl = "../Model/M_ProductList.aspx?Kind=0";

            $("#table_data").datagrid({
                url: aUrl,
                width: 'auto',
                singleSelect: true,
                columns: [[
                    { field: 'ProductID', title: '產品ID', align: 'center' },
                    { field: 'ProductName', title: '產品名稱', align: 'center', editor: 'text' },
                    { field: 'ProductPrice', title: '產品價格', align: 'center', editor: 'numberbox' },
                    { field: 'ProductCount', title: '產品數量', align: 'center', editor: 'numberbox' },
                    {
                        field: 'action', title: 'Action', width: 100, align: 'center', align: 'center',
                        formatter: function (value, row, index) {
                            if (row.editing) {
                                var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
                                var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
                                return s + c;
                            } else {
                                var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
                                var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
                                return e + d;
                            }
                        }
                    }
                ]],
                showFooter: true,
                detailFormatter: function (index, row) {
                    return '<div style="padding:2px"><table class="ddv"></table></div>';
                },
                //後方action 的功能
                onEndEdit: function (index, row) {
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'Name'
                    });
                    $.ajax({
                        type: "GET",
                        url: "../Model/M_ProductList.aspx",
                        data: {
                            Kind: 1,
                            ProductID: row.ProductID,
                            ProductName: row.ProductName,
                            ProductPrice: row.ProductPrice,
                            ProductCount: row.ProductCount,
                        },
                        success: function (result) {
                            alert(result);
                            $('#table_data').datagrid('resize', {
                                width: 'auto'
                            });
                        },
                        error: function (err) {
                            alert(err);
                        }

                    });
                },
                onBeforeEdit: function (index, row) {
                    row.editing = true;
                    $(this).datagrid('refreshRow', index);
                },
                onAfterEdit: function (index, row) {
                    row.editing = false;
                    $(this).datagrid('refreshRow', index);
                },
                onCancelEdit: function (index, row) {
                    row.editing = false;
                    $(this).datagrid('refreshRow', index);
                },
                onClickRow: function (index, row) {
                    aIndex = row;
                }
            });
        }
        function getRowIndex(target) {
            var tr = $(target).closest('tr.datagrid-row');
            return parseInt(tr.attr('datagrid-row-index'));
        }
        function editrow(target) {
            $('#table_data').datagrid('beginEdit', getRowIndex(target));
        }
        function deleterow(target) {
            $.messager.confirm('Confirm', 'Are you sure?', function (r) {
                if (r) {
                    var aUrl = "../Model/M_ProductList.aspx";
                    $.ajax({
                        url: aUrl,
                        data: {
                            Kind: 2,
                            ProductID: aIndex.ProductID,
                        },
                        success: function (result) {
                            alert(result);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });

                    $('#table_data').datagrid('deleteRow', getRowIndex(target));
                    $('#table_data').datagrid('resize', {
                        width: 'auto'
                    });
                }
            });
        }
        function saverow(target) {
            $('#table_data').datagrid('endEdit', getRowIndex(target));
        }
        function cancelrow(target) {
            $('#table_data').datagrid('cancelEdit', getRowIndex(target));
        }
        function Init()
        {
            QueryOnline();
        }
        $(document).ready(function () {
            Init();

        });

    </script>
</body>
</html>
