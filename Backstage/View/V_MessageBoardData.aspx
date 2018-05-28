<%@ Page Language="C#" AutoEventWireup="true" CodeFile="V_MessageBoardData.aspx.cs" Inherits="Backstage_View_V_MessageBoardData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../EasyUI/demo/demo.css"/>
    <script type="text/javascript" src="../EasyUI/jquery.min.js"></script>
    <script type="text/javascript" src="../EasyUI/jquery.easyui.min.js"></script>
    <title>留言板管理</title>
</head>
<body>
<div id="cc" class="easyui-layout" style="width:90%;height:640px;"><%-- 建立一個layout --%>
		<div id="region_West" region="west" split="true" title="功能列表區" style="width:30%;padding:10px;"><%--West左邊區塊 --%>
		</div>
		<div id="region_Center" region="center"  split="true" title="留言板" style="padding:5px;"><%--Center中間區塊 --%>
           

            <table id="tt" class="easyui-datagrid" style="width:100%;height:90%"
			        method="get" title="留言資料" iconCls="icon-save"
			        rownumbers="true" toolbar="#tb" footer="#ft" singleSelect="true" >
            </table>


            <div id="tb" style="padding:2px 5px;">
                
                <a href="javascript:QueryOnline(0)" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px">Search ALL</a>
                <a href="javascript:QueryOnline(1)" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px;margin-left:50px;">Search 已回覆</a>
                <a href="javascript:QueryOnline(2)" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px;margin-left:50px;">Search 尚未回覆</a>
                <a href="javascript:BusApi()" class="easyui-linkbutton" iconCls="icon-search" style="margin-right:0px;margin-left:50px;">Bus</a>
            </div>
            <%--<div id="ft" style="padding:2px 5px";></div>--%>
		</div>
	</div>
    <script>
        function BusApi() {
            var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/RealTimeNearStop/City/Keelung/402?$select=PlateNumb%2CStopName&$top=30&$format=JSON";

            $.ajax({
                type: "GET",
                url: "http://ptx.transportdata.tw/MOTC/v2/Bus/RealTimeNearStop/City/Keelung/402?$select=PlateNumb%2CStopName&$top=30&$format=JSONel/M_GetMessageBoardData.aspx",
                success: function (result) {
                    BusApi2(result);
                },
                error: function (err) {
                    alert(err);
                }
            });


            //$('#tt').datagrid({
            //    title: '公車系統',
            //    iconCls: 'icon-edit',
            //    singleSelect: true,
            //    url: aUrl,
            //    data: aData,
            //    columns: [[
            //        { field: 'PlateNumb', title: 'PlateNumb', width: 100, align: 'center' },
            //    //    { field: 'StopName.Zh_tw', title: 'StopName', width: 200, align: 'center', formatter: function (value, row) { return row.StopName.Zh_tw } },
            //    //    { field: 'Direction', title: 'Direction', width: 150, align: 'center', formatter: function (value, row) { if (row.Direction == 0) return "往基隆"; else return "往堵南里" } },
            //    ]],
            //});
        };
        function BusApi2(result) {
            var aUrl = "http://ptx.transportdata.tw/MOTC/v2/Bus/RealTimeNearStop/City/Keelung/402?$select=PlateNumb%2CStopName&$top=30&$format=JSON";

            var array = [];
            var columns = [];

            columns.push(array);

            columns[0].push({ field: 'PlateNumb', title: 'PlateNumb' });

            columns[0].push({ field: 'StopName.Zh_tw', title: 'StopName.Zh_tw', formatter: function (value, row) { return row.StopName.Zh_tw } });
            columns[0].push({ field: 'StopName.En', title: 'StopName.En', formatter: function (value, row) { return row.StopName.En } });
                //columns[0].push({ field: 'StopName.Zh_tw', title: 'StopName.Zh_tw', formatter: function (value, row) { return row.StopName.Zh_tw } });
                //columns[0].push({ field: 'StopName.En', title: 'StopName.En', formatter: function (value, row) { return row.StopName.En } });
            

            columns[0].push({ field: 'StopName', title: 'StopName', formatter: function (value, row) { return row.StopName.Zh_tw} });

            for (var i = 0; i < result[0].StopName.length; i++) {
                //columns[0].push({ field: 'PlateNumb', title: 'PlateNumb' });
                    //for (var j = 0; j < result[i].StopName.length; j++)
                    //    columns[0].push({ field: 'StopName', title: 'PlateNumb', formatter: function (value, row) { return row.StopName[value] } });
            };

            $('#tt').datagrid({
                columns: columns,
                dataType: 'json',
                url: aUrl
            });
        }

        function QueryOnline(iKind) {
            var aUrl = "../Model/M_GetMessageBoardData.aspx?Kind=" + 1 + "&SearchKind=" + iKind;//+ "&LoginValue=" + LoginValue + "&DateFrom=" + aDateFrom + "&DateTo=" + aDateTo + "&Account=" + Account + "&LoginCondition=" + LoginCondition;

            $('#tt').datagrid({
                title: '留言板系統',
                iconCls: 'icon-edit',
                //width: 660,
                //height: 250,
                singleSelect: true,
                //idField: 'itemid',
                width: 'auto',
                url: aUrl,
                columns: [[
                    { field: 'Name', title: 'Name', align: 'center' },
                    { field: 'Message', title: 'Message', align: 'center' },
                    { field: 'DateTime', title: 'DateTime',  align: 'center' },
                    {
                        field: 'Status', title: 'Status', align: 'center'
                    },
                    {
                        field: 'Report', title: 'Report', width: 250, editor: 'text', align: 'center',
                    },
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

                //後方action 的功能
                onEndEdit: function (index, row) {
                    var ed = $(this).datagrid('getEditor', {
                        index: index,
                        field: 'Name'
                    });
                    $.ajax({
                        type: "GET",
                        url: "../Model/M_GetMessageBoardData.aspx",
                        data: {
                            Kind: 2,
                            Status: row.Status,
                            Report: row.Report,
                            ID:row.ID,
                        },
                        success: function (result) {
                            alert(result);
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
                onDblClickRow: function (index, row) {
                    OpenJumpWindow(row.Message, row.Report);
                }
            });
        }

        function getRowIndex(target) {
            var tr = $(target).closest('tr.datagrid-row');
            return parseInt(tr.attr('datagrid-row-index'));
        }
        function editrow(target) {
            $('#tt').datagrid('beginEdit', getRowIndex(target));
        }
        function deleterow(target) {
            $.messager.confirm('Confirm', 'Are you sure?', function (r) {
                if (r) {
                    $('#tt').datagrid('deleteRow', getRowIndex(target));
                }
            });
        }
        function saverow(target) {
            $('#tt').datagrid('endEdit', getRowIndex(target));
        }
        function cancelrow(target) {
            $('#tt').datagrid('cancelEdit', getRowIndex(target));
        }
        $(document).ready(function () {
            //Init();
            //SetDate();//預設一開始的時間
        });
    </script>


    <script type="text/javascript" src="../Js/Button.js"></script>
</body>
</html>
