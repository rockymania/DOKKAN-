using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Model_M_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string aAccount = string.Empty;
        string aPassword = string.Empty;

        try
        {
            aAccount = Request["Account"].ToString();
            aPassword = Request["Password"].ToString();

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();
                string aSQLStr = "SELECT * FROM AccountData";
                bool aFind = false;
                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    SqlDataReader aDr = aCmd.ExecuteReader();
                    while (aDr.Read())
                    {
                        if (aDr["Account"].ToString() == aAccount)
                        {
                            aFind = true;
                            if (aDr["Password"].ToString() == aPassword)
                            {
                                string aNickName = aDr["NickName"].ToString();

                                //產生一個Cookie
                                HttpCookie cookie = new HttpCookie("NickName");
                                //設定單值
                                cookie.Value = aNickName;
                                //設定過期日
                                cookie.Expires = DateTime.Now.AddDays(1);
                                //寫到用戶端
                                Response.Cookies.Add(cookie);

                                Response.Write("1");
                            }
                            else
                            {
                                Response.Write("2");
                            }
                            break;
                        }
                    }

                    aDr.Close();

                    if (aFind == false)
                        Response.Write("3");
                }

            }
        }
        catch
        {
            Response.Write("帳號資料庫錯誤");
        }
    }
}