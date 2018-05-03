using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetProduct : System.Web.UI.Page
{
    public class ProductData
    {
        public string ID;               //ID
        public string ShopKind;         //商品種類 EX: 飲料 餐飲
        public string ProductName;      //商品名稱
        public string ProductImage;     //商品圖片
        public string ProductUrl;       //商品連結
        public string ProductKind;      //商品類別(開啟url用)
    }

    private string LoadDataPath = "Data/ProductData.txt";
    private string CreateString = "<table class=\"TableItem\"><tr><td><p><a href=\"{0}\"><img src=\"{1}\"/> </a> </p><p class=\"TableP\"><a href=\"{2}\"> {3}</p></td></tr></table>";

    protected void Page_Load(object sender, EventArgs e)
    {

        string aKind = "";

        try
        {
            aKind = Request.QueryString["Kind"];

            ProductData[] mData;
            string json_Data = "";
            string CheckPath = "~";
            if (GetIsDebug() == false)
                CheckPath = "~/Dokkan/";

            using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath, Encoding.UTF8))
            {
                string str = sr.ReadToEnd();
                mData = JsonConvert.DeserializeObject<ProductData[]>(str);
            }

            if (mData.Length == 0)
            { 
                Response.Write("0");
                return;
            }
            //"<table class=\"TableItem\"><tr><td><p><a href=\"{0}\"><img src=\"{1}\"/> </a> </p><p class=\"TableP\"><a href=\"{2}\"> {3}</p></td></tr></table>";
            //{0}商品連結 {1} 商品圖片 {2} 商品連結 {3}商品名稱

            for (int i = 0; i < mData.Length; i++)
            {
                if (CheckStatus(aKind,mData[i].ShopKind)==true)
                    json_Data += string.Format(CreateString, mData[i].ProductUrl+mData[i].ProductKind, mData[i].ProductImage, mData[i].ProductUrl + mData[i].ProductKind, mData[i].ProductName);
            }

            Response.Write(json_Data);
        }
        catch
        {

        }
    }

    private bool CheckStatus(string iKind,string DataKind)
    {
        if (iKind == DataKind)
            return true;

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