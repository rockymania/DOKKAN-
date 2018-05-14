using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_VerificationAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aAccount = Request["Account"].ToString();
            bool aFind = false;

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();
                string aSQLStr = string.Format("SELECT * FROM AccountData WHERE Account='{0}'",aAccount);

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    SqlDataReader aRead = aCmd.ExecuteReader();
                    while (aRead.Read())
                    {
                        if (aRead["Account"].ToString() == aAccount)
                        {
                            aFind = true;
                            break;
                        }
                    }
                    aRead.Close();
                }
                aCon.Close();
            }

            if (aFind == true)
            {
                DoVerificationAccount(aAccount);
                Response.Write("驗證成功");
                Response.Redirect("http://mobiledaddy.net/Dokkan/View/index.aspx");
            }
            else
            {
                Response.Write("無此驗證帳號");
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private void DoVerificationAccount(string iAccount)
    {
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            string aSQLStr = string.Format("UPDATE AccountData SET Auth='1' WHERE Account='{0}' AND Auth='0'",iAccount);

            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                aCmd.ExecuteNonQuery();
            }
            aCon.Close();
        }
    }
}