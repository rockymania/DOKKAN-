﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetShopCar : System.Web.UI.Page
{
    public class ShopCarData
    {
        public string ID;               //ID
        public string ShopKind;         //商品種類 EX: 飲料 餐飲
        public string ProductName;      //商品名稱
        public string ProductImage;     //商品圖片
        public string ProductUrl;       //商品連結
        public string ProductKind;      //商品類別(開啟url用)
        public string Price;            //商品價格
    }

    private string LoadDataPath = "Data/ProductData.txt";
    private string CreateString = "<tr class=\"tabletr\"><td class=\"td1\">{0}</td> " +
                                  "<td class=\"td1\">{1}</td>" +
                                  "<td class=\"td2\">{2}</td>" +
                                  "<td class=\"td3\">{3}</td>" +
                                  "<td class=\"td3\">{4}</td>" +
                                  "<td><button onclick = \"ClearProduct({5})\"> 取消 </button ></td>";
    protected void Page_Load(object sender, EventArgs e)
    {
        string aCookieShopCar;
        string[] aPID= { };
        string[] aPNUM= { };
        string[] aTempData;
        try
        {
            aCookieShopCar = Request.QueryString["CookieShopCar"];
            string[] aNewContent = aCookieShopCar.Split(Convert.ToChar(','));

            Array.Resize(ref aPID, aNewContent.Length);
            Array.Resize(ref aPNUM, aNewContent.Length);

            for (int i = 0; i < aNewContent.Length;i++)
            {
                aTempData = aNewContent[i].Split(Convert.ToChar('|'));
                aPID[i] = aTempData[0];
                aPNUM[i] = aTempData[1];
            }
             

            ShopCarData[] mData;
            string json_Data = "";
            string CheckPath = "~";
            if (GetIsDebug() == false)
                CheckPath = "~/Dokkan/";

            using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath, Encoding.UTF8))
            {
                string str = sr.ReadToEnd();
                mData = JsonConvert.DeserializeObject<ShopCarData[]>(str);
            }

            //string aKind;

            //for (int i = 0; i < mData.Length; i++)
            //{
            //    if (CheckInsertData(aPID, mData[i].ID) == true)
            //        json_Data += string.Format(CreateString, mData[i].ProductName, "規格", "數量", mData[i].Price, "總計");
            //}
            ShopCarData TempData;
            for (int i = 0; i <aPID.Length;i++)
            {
                TempData = GetShopCarData(aPID[i], mData);

                if (TempData.ID != "0")
                {
                    json_Data += string.Format(CreateString, TempData.ProductName, "規格", aPNUM[i], TempData.Price, int.Parse(aPNUM[i]) * int.Parse(TempData.Price), aPID[i]);
                }
            }

            Response.Write(json_Data);
        }
        catch
        {
        }
    }

    private ShopCarData GetShopCarData(string iPID, ShopCarData[] iData)
    {
        ShopCarData TempData = new ShopCarData();

        for (int i = 0; i < iData.Length; i++)
        {
            if ( iPID == iData[i].ID)
            {
                TempData = iData[i];
                return TempData;
            }
        }

        return TempData;
    }

    private bool CheckInsertData(string[] iPID,string iProductID)
    {
        for(int i = 0; i < iPID.Length; i++)
        {
            if (iPID[i] == iProductID)
                return true;
        }
   
        return false;
    }

    private bool GetIsDebug()
    {
        bool isLocal = HttpContext.Current.Request.IsLocal;
        if (!isLocal)
        {
            //記錄資料1
            return false;
        }
        return true;
    }
}