using System;
using System.Data.SqlClient;
using System.Net;
using System.Web;

public partial class Model_M_FBSignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string aMail = Request["Mail"].ToString();
            string aFBID = Request["FBID"].ToString();
            string aName = Request["Name"].ToString();
            string aNickName = aName;

            if (CheckHaveAccount(aFBID) == true)
            {
                Response.Write("1");
                return;
            }
               
            string aRecTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string aAccount = "fb@" + aFBID;
            string aPassword = "";
            string aPhone = "";

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                string aSQLStr = string.Format("INSERT INTO AccountData(Account,Password,FBID,Name,NickName,Phone,Mail,RecTime,Auth) VALUES('{0}','{1}','{2}',N'{3}',N'{4}','{5}','{6}','{7}','{8}')", aAccount, aPassword, aFBID, aName, aNickName, aPhone, aMail, aRecTime, "0");

                using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
                {
                    aCmd.ExecuteNonQuery();
                }
                aCon.Close();
            }

            DoSetCookie(aAccount, aNickName);

            string aResult = "99";

            using (WebClient aWc = new WebClient())
            {
                aResult = aWc.DownloadString(string.Format("http://mobiledaddy.net/Dokkan/Model/M_AutoMail.aspx?Account={0}&Mail={1}&Name={2}", aAccount, aMail,aName));
            }

            if (aResult == "1")
                Response.Write("1");
            else
                Response.Write(aResult);


        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private bool CheckHaveAccount(string iFBID)
    {
        bool aFind = false;
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            string aSQLStr = string.Format("SELECT * FROM AccountData WHERE FBID='{0}'",iFBID);
            
            using (SqlCommand aCmd = new SqlCommand(aSQLStr, aCon))
            {
                SqlDataReader aDr = aCmd.ExecuteReader();

                while (aDr.Read())
                {
                    aFind = true;

                    string aNickName = aDr["NickName"].ToString();
                    string aAccount = aDr["Account"].ToString();
                    DoSetCookie(aAccount, aNickName);
                    break;
                }
                aDr.Close();
            }

            aCon.Close();
        }
        if (aFind == true)
            return true;

        return false;
    }

    private void DoSetCookie(string iAccount, string iNickName)
    {
        //產生一個Cookie
        HttpCookie aNickNameCookie = new HttpCookie("NickName");
        //設定單值
        aNickNameCookie.Value = iNickName;
        //設定過期日
        aNickNameCookie.Expires = DateTime.Now.AddDays(1);
        //寫到用戶端
        Response.Cookies.Add(aNickNameCookie);

        //產生一個Cookie
        HttpCookie aAccountCookie = new HttpCookie("Account");
        //設定單值
        aAccountCookie.Value = iAccount;
        //設定過期日
        aAccountCookie.Expires = DateTime.Now.AddDays(1);
        //寫到用戶端
        Response.Cookies.Add(aAccountCookie);
    }
}