using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Backstage_Model_M_ProductList : System.Web.UI.Page
{
    public class ProductData
    {
        public string ProductID;
        public string ProductName;
        public string ProductPrice;
        public string ProductCount;
    }

    List<ProductData> aData = new List<ProductData>();

    protected void Page_Load(object sender, EventArgs e)
    {
        string aResult = "";

        try
        {
            string aKind = Request["Kind"].ToString();

            switch (aKind)
            {
                case "0":
                    aResult = GetProductData();
                    break;
                case "1":
                    string aProductID = Request["ProductID"].ToString();
                    string aProductName = Request["ProductName"].ToString();
                    string aProductPrice = Request["ProductPrice"].ToString();
                    string aProductCount = Request["ProductCount"].ToString();
                    aResult = UpdateProductData(aProductID, aProductName, aProductPrice, aProductCount);
                    break;
                case "2":
                    string zProductID = Request["ProductID"].ToString();
                    aResult = DeleteProductItem(zProductID);
                    break;
            }


            Response.Write(aResult);
        }
        catch
        {
            Response.Write("參數錯誤");
        }
    }

    private string GetProductData()
    {
        string aJsonStr = "";
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            string aSQLStr = "SELECT * FROM ProductList";

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRD = aCmd.ExecuteReader();

                while (aRD.Read())
                {
                    ProductData aSqlData = new ProductData();
                    aSqlData.ProductID = aRD["ProductID"].ToString();
                    aSqlData.ProductName = aRD["ProductName"].ToString();
                    aSqlData.ProductPrice = aRD["ProductPrice"].ToString();
                    aSqlData.ProductCount = aRD["ProductCount"].ToString();

                    aData.Add(aSqlData);
                }
                aRD.Close();
            }
            aCon.Close();
        }

        ProductData[] aAllData = aData.ToArray();

        aJsonStr = JsonConvert.SerializeObject(aAllData);

        return aJsonStr;
    }
    private string UpdateProductData(string iProductID,string iProductName,string iProductCount,string iProductPrice)
    {
        string aResult = "";

        try
        {
            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                string aSQLStr = string.Format("UPDATE ProductList SET ProductName=N'{0}',ProductPrice={1},ProductCount={2} WHERE ProductID='{3}'",iProductName,iProductPrice,iProductCount, iProductID);

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    aCmd.ExecuteNonQuery();

                }
                aCon.Close();
            }
            aResult = "完成資料更新";
        }
        catch(Exception ex)
        {
            aResult = ex.ToString();
        }

        return aResult;
    }

    private string DeleteProductItem(string iProductID)
    {
        string aResult = "";

        try
        {
            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                string aSQLStr = string.Format("DELETE FROM ProductList WHERE ProductID='{0}'", iProductID);

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    aCmd.ExecuteNonQuery();

                }
                aCon.Close();
            }
            aResult = "已刪除資料";
        }
        catch (Exception ex)
        {
            aResult = ex.ToString();
        }

        return aResult;
    }
}