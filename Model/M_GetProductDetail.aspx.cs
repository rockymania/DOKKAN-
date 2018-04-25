using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetProductDetail : System.Web.UI.Page
{
    public class DetailData
    {
        public string ID;
        public string Title;
        public string Price;
        public string[] Detail;

        public DetailData()
        {
            ID = string.Empty;
            Title = string.Empty;
            Price = string.Empty;
        }
    }

    private string mLoadPath = "Data/ProductDetail.txt";
    

    protected void Page_Load(object sender, EventArgs e)
    {
        string aID = string.Empty;
        string aCheckPath = "~";
        string aReStr = "<p id=\"Title\">{0}</p><ul>";
        string aLiStr = "<li>{0}</li>";
        DetailData[] aDetailData;
        DetailData aData;

        try
        {
            aID = "0";

            aData = new DetailData();

            if (GetIsDebug() == false)
                aCheckPath = "~/Dokkan/";

            using (StreamReader aSR = new StreamReader(Server.MapPath(aCheckPath) + mLoadPath, Encoding.UTF8))
            {
                string zStr = aSR.ReadToEnd();

                aDetailData = JsonConvert.DeserializeObject<DetailData[]>(zStr);
            }

            for (int i = 0; i < aDetailData.Length; i++)
            {
                if (aID == aDetailData[i].ID)
                {
                    aData = aDetailData[i];
                    break;
                }
            }

            aReStr = string.Format(aReStr, aData.Title);

            int aDetailCount = GetDetailCount(aData);

            for (int i = 0; i < aDetailCount; i++)
            {
                aReStr += string.Format(aLiStr,aData.Detail[i]);
            }


            aReStr += "</ul>";

            aReStr += string.Format("<p id=\"Price\">售價{0}</p>",aData.Price);

            Response.Write(aReStr);

        }
        catch(Exception wz)
        {
            //無效的ID
            Response.Write(wz);            
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

    private int GetDetailCount(DetailData iData)
    {
        int aCount = 0;

        for (int i = 0; i < iData.Detail.Length; i++)
        {
            if (iData.Detail[i] == "")
            {
                break;
            }
            aCount++;
        }

        return aCount;
    }

}