﻿$("#region_West").html(
    "<div style=\"padding:5px 5px 5px 5px\">" +
    "<span style=\"color:blue\" ></span>您好，切換帳號請點這裡<a href=\"V_index.aspx\">登出</a>"+
    "</div>" +
    "<div style=\"padding:5px 5px 5px 5px\">" +
    "<a href=\"V_index.aspx\" class=\"easyui-linkbutton\" style=\"width:100%;height:50px;\">1</a>" +
    "</div>" +
    "<div style=\"padding:5px 5px 5px 5px\">" +
    "<a href=\"V_LoginData.aspx\" class=\"easyui-linkbutton\" style=\"width:100%;height:50px;\">登入資料</a>" +
    "</div>" +
    "<div style=\"padding:5px 5px 5px 5px\">" +
    "<a href=\"javascript:OpenSaleData()\" class=\"easyui-linkbutton\" style=\"width:100%;height:50px;\">單項商品銷售</a>" +
    "</div>" +
    "<div id=\"ShowTable\" style=\"padding:5px 5px 5px 65px;display:none;\">" +
    "<a href=\"V_SaleData.aspx\" class=\"easyui-linkbutton\" style=\"width:80%;height:50px;\">銷售表格顯示</a>" +
    "</div>" +
    "<div id=\"ShowPic\" style=\"padding:5px 5px 5px 65px;display:none;\">" +
    "<a href=\"V_SaleDataPic.aspx\" class=\"easyui-linkbutton\" style=\"width:80%;height:50px;\">銷售圖表顯示</a>" +
    "</div>" +
    "<div style=\"padding:5px 5px 5px 5px\">" +
    "<a href=\"javascript:OpenShopButton()\" class=\"easyui-linkbutton\" style=\"width:100%;height:50px;\">後台商品管理</a>" +
    "</div>" +
    "<div id=\"AddProduct\" style=\"padding:5px 5px 5px 65px;display:none;\">" +
    "<a href=\"V_SaleDataPic.aspx\" class=\"easyui-linkbutton\" style=\"width:80%;height:50px;\">商品上架</a>" +
    "</div>" +
    "<div id=\"ProductRevision\" style=\"padding:5px 5px 5px 65px;display:none\">" +
    "<a href=\"V_SaleDataPic.aspx\" class=\"easyui-linkbutton\" style=\"width:80%;height:50px;\">商品調整</a>" +
    "</div>" 
);

function OpenShopButton()
{
    $("#AddProduct").slideToggle();
    $("#ProductRevision").slideToggle();
    $("#AddProduct").resize();
    $("#ProductRevision").resize();
}
function OpenSaleData()
{
    $("#ShowPic").slideToggle();
    $("#ShowTable").slideToggle();
    $("#ShowTable").resize();
    $("#ShowPic").resize();
}
