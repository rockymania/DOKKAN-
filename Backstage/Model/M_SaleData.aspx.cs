using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Backstage_Model_M_SaleData : System.Web.UI.Page
{
    public class SaleData
    {
        public string Date;
        public string SaleCount;
    }

    public class AllSaleData
    {
        public int total;
        public SaleData[] rows;
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        List<SaleData> aSaleData = new List<SaleData>();

        try
        {
            string aProductID = Request["ProductID"].ToString();
            DateTime aFrom = DateTime.Parse(Request["DateFrom"].ToString());
            DateTime aTo = DateTime.Parse(Request["DateTo"].ToString());
            //取出日期差
            TimeSpan aTS = aTo - aFrom;

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                for (int i = 0; i < aTS.Days + 1; i++)
                {
                    DateTime aSerchTime = aFrom.AddDays(i);
                    string aDate = aSerchTime.Year.ToString() + aSerchTime.Month.ToString("00") + aSerchTime.Day.ToString("00");

                    string aSQLStr = string.Format("SELECT * FROM BuyData WHERE SingleNumber LIKE '{0}%' AND ProductID='{1}'", aDate,aProductID);

                    int aCount = 0;

                    using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                    {
                        SqlDataReader aRD = aCmd.ExecuteReader();

                        while (aRD.Read())
                        {
                            aCount += int.Parse(aRD["ProductCount"].ToString());
                        }
                        aRD.Close();
                        aCmd.Clone();
                    }

                    SaleData zSD = new SaleData();
                    zSD.SaleCount = aCount.ToString();
                    zSD.Date = aSerchTime.ToString("yyyy - MM - dd");
                    aSaleData.Add(zSD);
                }
                aCon.Close();
            }

            AllSaleData aAllData = new AllSaleData();
            aAllData.rows = aSaleData.ToArray();

            string aJsonStr = JsonConvert.SerializeObject(aAllData);

            Response.Write(aJsonStr);

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }





        //List<SaleData> aTest = new List<SaleData>();


        //for (int i = 0; i < 2; i++)
        //{
        //    SaleData aTest2 = new SaleData();
        //    aTest2.Date = "123";
        //    aTest2.SaleCount = i.ToString();

        //    aTest.Add(aTest2);
        //}

        //AllSaleData aTest3 = new AllSaleData();
        //aTest3.rows = aTest.ToArray();

        //string aJson = JsonConvert.SerializeObject(aTest3);

        //Response.Write(aJson);

    }
}