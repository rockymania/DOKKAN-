using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

public partial class Model_M_SignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aAccount = Request["Account"].ToString();
            string aPassword = Request["Password"].ToString();
            string aName = Request["Name"].ToString();
            string aNickName = Request["NickName"].ToString();
            string aPhone = Request["Phone"].ToString();
            string aMail = Request["Mail"].ToString();
            string aRecTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            if (CheckAccount(aAccount) == true)
            {
                Response.Write("帳號重複");
                return;
            }

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                string aSQLStr = string.Format("INSERT INTO AccountData(Account,Password,FBID,Name,NickName,Phone,Mail,RecTime,Auth) VALUES('{0}','{1}','{2}',N'{3}',N'{4}','{5}','{6}','{7}','{8}')", aAccount,aPassword,"",aName,aNickName,aPhone,aMail,aRecTime,"0");
                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    aCmd.ExecuteNonQuery();
                }
                
                aCon.Close();
            }
            string aResult = "99";

            using (WebClient aWc = new WebClient())
            {
                aResult = aWc.DownloadString(string.Format("http://mobiledaddy.net/Dokkan/Model/M_AutoMail.aspx?Account={0}&Mail={1}&Name={2}", aAccount, aMail, aName));
            }

            if (aResult == "1")
            {
                Response.Write("1");
                //創立角色資料塞入SQL
                UpdateMonthData();
            }
            else
                Response.Write(aResult);
        }
        catch(Exception ex)
        {
            Response.Write(ex);
        }
    }

    private void UpdateMonthData()
    {
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();
            //取出目前月份
            string aTime = DateTime.Now.ToString("yyyyMM");

            string aSqlStr = "UPDATE Month_SignUp SET TotalSignUp = TotalSignUp + 1 WHERE(ID = " + aTime +")";

            using (SqlCommand aCmd = new SqlCommand(aSqlStr, aCon))
            {
                aCmd.ExecuteNonQuery();
            }
        }
    }

    private bool CheckAccount(string iAccount)
    {
        bool aFind = false;
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            string aSQLStr = string.Format("SELECT * FROM AccountData WHERE Account='{0}'",iAccount);
           
            
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aRead = aCmd.ExecuteReader();

                while (aRead.Read())
                {
                    if (aRead["Account"].ToString() == iAccount)
                    {
                        aFind = true;
                        break;
                    }
                }
            }

            aCon.Close();
        }
        //有重複
        if (aFind == true)
            return true;

        return false;
    }
}