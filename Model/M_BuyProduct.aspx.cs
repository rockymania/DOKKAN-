using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_BuyProduct : System.Web.UI.Page
{
    public class ShopCarData
    {
        public string BuyName;//購買人姓名
        public string BuyPhone;//購買人電話
        public string CardNumber;//信用卡卡號
        public string CardMonth;//信用卡有效月
        public string CardYear; //信用卡有效年
        public string Password;//信用卡驗證碼
        public string BuyAddressCity;//購買者縣市
        public string BuyAddressArea;//購買者區
        public string BuyAddress;//購買者地址
        public string GetName;//收貨人姓名
        public string GetPhone;//收貨人電話
        public string GetAddressCity;//收貨人縣市
        public string GetAddressArea;//收貨人區
        public string GetAddress;//收貨人地址
    }

    public class CountryData
    {
        public string ID;
        public string CountryNumber;
        public string[] CountryName;
    }

    private string[] mProductID;
    private string[] mProductCount;


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aJsonDataStr = Request["JsonData"].ToString();
            ShopCarData aShopCarData = JsonConvert.DeserializeObject<ShopCarData>(aJsonDataStr);

            HttpCookie aCookie = Request.Cookies["Ricky"];
            //取得cookie字串
            string aCookieData = aCookie.Value;
            //把資料分隔開來
            string[] aNewContent = aCookieData.Split(Convert.ToChar(','));
            //重新給陣列大小
            Array.Resize(ref mProductID, aNewContent.Length);
            Array.Resize(ref mProductCount, aNewContent.Length);

            for (int i = 0; i < aNewContent.Length; i++)
            {
                string[] aTemp = aNewContent[i].Split(Convert.ToChar('|'));
                mProductID[i] = aTemp[0];
                mProductCount[i] = aTemp[1];
            }
            //開始寫入SQL
            try
            {
                string aStr = "INSERT INTO BuyData(ProductID,ProductCount,CardNumber,Password,BuyAddress,BuyName,BuyPhone,GetName,GetPhone,GetAddress) VALUES('{0}','{1}','{2}','{3}',N'{4}',N'{5}','{6}',N'{7}','{8}',N'{9}')";

                using (SqlConnection vCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
                {
                    vCon.Open();

                    for (int i = 0; i < mProductID.Length; i++)
                    {

                        string aBuyAddress = GetAddress(aShopCarData.BuyAddressCity, aShopCarData.BuyAddressArea, aShopCarData.BuyAddress);
                        string aGetAddress = GetAddress(aShopCarData.GetAddressCity, aShopCarData.GetAddressArea, aShopCarData.GetAddress);

                        string aSQLStr = string.Format(aStr, mProductID[i], mProductCount[i], aShopCarData.CardNumber, aShopCarData.Password, aBuyAddress, aShopCarData.BuyName, aShopCarData.BuyPhone, aShopCarData.GetName, aShopCarData.GetPhone, aGetAddress);

                        using (SqlCommand vCmd = new SqlCommand(aSQLStr, vCon))
                        {
                            vCmd.ExecuteNonQuery();
                        }
                    }
                }

                Response.Write("完成");
            }
            catch
            {

            }

        }
        catch
        {
            Response.Write("收到的資料有錯誤");
        }
    }

    private string GetAddress(string iCity,string iArea,string iAddress)
    {
        string aAddress = string.Empty;
        string aCheckPath = "~";
        string aLoadPath = "Data/CountryData.txt";
        string aCityName = string.Empty;
        CountryData[] aAllData;

        if (GetIsDebug() == false)
            aCheckPath = "~/Dokkan/";

        using (StreamReader aSr = new StreamReader(Server.MapPath(aCheckPath) + aLoadPath, Encoding.UTF8))
        {
            string aStr = aSr.ReadToEnd();
            aAllData = JsonConvert.DeserializeObject<CountryData[]>(aStr);
            aSr.Close();
        }

        for (int i = 0; i < aAllData.Length; i++)
        {
            if (aAllData[i].ID == iCity)
            {
                aCityName = aAllData[i].CountryNumber;
                break;
            }
        }

        aAddress = string.Format("{0}{1}區{2}", aCityName, iArea, iAddress);

        return aAddress;
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