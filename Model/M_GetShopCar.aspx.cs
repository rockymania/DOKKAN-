using Newtonsoft.Json;
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
        public string ProductName;
        public string ProductUrl;
        public string ProductImage;
        public string ID;
    }

    private string LoadDataPath = "Data/ProductData";
    private string LoadDataEnd = ".txt";
    private string CreateString2 = "<table class=\"TableItem\"><tr><td><p><a href=\"{0}\"><img src=\"{1}\"/> </a> </p><p class=\"TableP\"><a href=\"{2}\"> {3}</p></td></tr></table>";
    private string CreateString = "<tr class=\"tabletr\"><td class=\"td1\">{0}</td> " +
                                  "<td class=\"td1\">{1}</td>" +
                                  "<td class=\"td2\">{2}</td>" +
                                  "<td class=\"td3\">{3}</td>" +
                                  "<td class=\"td3\">{4}</td>" +
                                  "<td><button onclick = \"\"> 取消 </button ></td>";
    protected void Page_Load(object sender, EventArgs e)
    {

        string aKind = "1";
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

            using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath + aKind + LoadDataEnd, Encoding.UTF8))
            {
                string str = sr.ReadToEnd();
                mData = JsonConvert.DeserializeObject<ShopCarData[]>(str);
            }


            for (int i = 0; i < mData.Length; i++)
            {
                if ( CheckInsertData(aPID, mData[i].ID) == true)
                    json_Data += string.Format(CreateString, mData[i].ProductUrl, mData[i].ProductImage, mData[i].ProductUrl, mData[i].ProductName, mData[i].ProductImage);
            }

            Response.Write(json_Data);
        }
        catch
        {
        }
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