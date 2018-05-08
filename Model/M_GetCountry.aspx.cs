using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetCountry : System.Web.UI.Page
{
    public class CountryData
    {
        public string ID;
        public string CountryNumber;
        public string[] CountryName;
    }

    private CountryData mData;
    private string mLoadPath = "Data/CountryData.txt";
    private string mReStr = "<option>請選擇區</option>";
    private string mHTML = "<option value=\"{0}\">{1}</option>";

    protected void Page_Load(object sender, EventArgs e)
    {
        string aCountryID = string.Empty;
        string aCheckPath = "~";
        CountryData[] aAllData;

        try
        {
            aCountryID = Request["ID"].ToString();

            if (GetIsDebug() == false)
                aCheckPath = "~/Dokkan/";

            using (StreamReader aSR = new StreamReader(Server.MapPath(aCheckPath) + mLoadPath, Encoding.UTF8))
            {
                string zStr = aSR.ReadToEnd();
                aAllData = JsonConvert.DeserializeObject<CountryData[]>(zStr);
            }

            for (int i = 0; i < aAllData.Length; i++)
            {
                if (aAllData[i].ID == aCountryID)
                {
                    mData = aAllData[i];
                    break;
                }
            }

            mReStr = JsonConvert.SerializeObject(mData);

            Response.Write(mReStr);
        }
        catch
        {
            
        }


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