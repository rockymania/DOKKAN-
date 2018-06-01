using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Backstage_Model_M_UploadProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string aResult = "0";

        try
        {
            string aProductID = Request["ProductID"].ToString();
            string aProdcutName = Request["ProductName"].ToString();
            int aProductPrice = int.Parse(Request["ProductPrice"].ToString());
            int aProductCount = int.Parse(Request["ProductCount"].ToString());

            if (CheckProduct(aProductID) == true)
            {
                aResult = "2";
                Response.Write(aResult);
                return;
            }


            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();
                string aSQLStr = string.Format("INSERT INTO ProductList (ProductID,ProductName,ProductPrice,ProductCount) VALUES('{0}',N'{1}','{2}','{3}')",aProductID,aProdcutName,aProductPrice,aProductCount);

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    aCmd.ExecuteNonQuery();
                }
                aCon.Close();
            }


            Response.Write(aResult);
        }
        catch
        {
            aResult = "1";
            //傳入參數有誤
            Response.Write(aResult);
        }
    }
    //檢查是否有這產品了
    private bool CheckProduct(string iProductID)
    {
        int aCount = 0;
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();
            string aSQLStr = string.Format("SELECT * FROM ProductList WHERE ProductID='{0}'",iProductID);

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRd = aCmd.ExecuteReader();
                
                while (aRd.Read())
                {
                    aCount++;
                }




            }
            aCon.Close();

            if (aCount > 0)
                return true;
        }


        return false;
    }
}