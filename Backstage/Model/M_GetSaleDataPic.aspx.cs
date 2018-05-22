using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Backstage_Model_M_GetSaleDataPic : System.Web.UI.Page
{
    public class SaleData
    {
        public string Date;
        public int SaleCount;
    }

    public class AllSaleData
    {
        public int DataCount;
        public string[] Date;
        public int[] SaleCount;
    }

    List<SaleData> aSaleData = new List<SaleData>();
    List<SaleData> aSQLData = new List<SaleData>();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aProductID = Request["ProductID"].ToString();
            DateTime aFrom = DateTime.Parse(Request["DateFrom"].ToString());
            DateTime aTo = DateTime.Parse(Request["DateTo"].ToString());
            //取出日期差
            TimeSpan aTS = aTo - aFrom;

            if (aProductID == "")
                return;

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                string aSQLStr = string.Format("SELECT * FROM BuyData WHERE RecTime >= '{0}' AND RecTime< '{1}' AND ProductID = '{2}'", aFrom.ToString("yyyy - MM - dd"), aTo.ToString("yyyy - MM - dd"), aProductID);

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    SqlDataReader aRD = aCmd.ExecuteReader();

                    while (aRD.Read())
                    {
                        SaleData aData = new SaleData();
                        aData.Date = aRD["RecTime"].ToString();
                        aData.SaleCount = int.Parse(aRD["ProductCount"].ToString());
                        aSQLData.Add(aData);
                    }
                    aRD.Close();
                }

                aCon.Close();
            }

            SortData(aFrom, aTo);

            AllSaleData aAllData = new AllSaleData();

            aAllData.Date = new string[aSaleData.Count];
            aAllData.SaleCount = new int[aSaleData.Count];
            aAllData.DataCount = aSaleData.Count;

            for (int i = 0; i < aSaleData.Count; i++)
            {
                aAllData.Date[i] = aSaleData[i].Date;
                aAllData.SaleCount[i] = aSaleData[i].SaleCount;
            }

            string aJsonStr = JsonConvert.SerializeObject(aAllData);

            Response.Write(aJsonStr);

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }


    private void SortData(DateTime iFrom, DateTime iTo)
    {
        TimeSpan aTS = iTo - iFrom;

        for (int i = 0; i < aTS.Days; i++)
        {
            DateTime aTime = iFrom.AddDays(i);

            SaleData aData = new SaleData();
            aData.Date = aTime.ToString("yyyy-MM-dd");
            aData.SaleCount = 0;
            aSaleData.Add(aData);
        }

        for (int i = 0; i < aSQLData.Count; i++)
        {
            for (int k = 0; k < aSaleData.Count; k++)
            {
                string iTime = DateTime.Parse(aSQLData[i].Date).ToString("yyyy-MM-dd");
                string kTime = DateTime.Parse(aSaleData[k].Date).ToString("yyyy-MM-dd");

                if (iTime == kTime)
                {
                    aSaleData[k].SaleCount += aSQLData[i].SaleCount;
                    break;
                }
            }
        }

    }
}