using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Model_M_GetBanner : System.Web.UI.Page
{
    public class BannerData
    {
        public string BannerName;
        public string BannerUrl;
    }
    private string LoadDataPath = "Data/BannerData.txt";
    private string CreateString = "<li><a href= \"{0}\" > <img src = \"{1}\"/></a></li>";

    protected void Page_Load(object sender, EventArgs e)
    {
        BannerData[] mData;
        string json_Data = "";
        using (StreamReader sr = new StreamReader(Server.MapPath("~")+ LoadDataPath, Encoding.UTF8))
        {
            string str = sr.ReadToEnd();
            mData = JsonConvert.DeserializeObject<BannerData[]>(str);
        }

        for (int i = 0; i < mData.Length; i++)
            json_Data += string.Format(CreateString, mData[i].BannerUrl, mData[i].BannerName);

        Response.Write(json_Data);
    }
}