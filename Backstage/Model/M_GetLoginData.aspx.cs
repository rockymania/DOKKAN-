using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Newtonsoft.Json;

public partial class Backstage_Model_M_GetLoginData : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        int aLoginValue = 0;

        try
        {
            aLoginValue = int.Parse(Request.QueryString["LoginValue"].ToString());


            switch (aLoginValue)
            {
                case 1:
                    GetMonthSignAuthData();
                    break;
                case 2:
                    GetAccountAuthData();
                    break;
                case 3:
                    break;
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    public class MonthSignAuthData
    {
        public int ID;
        public int TotalSignUp;
        public int AuthNum;
    }

    //取得每個月的帳號註冊人數跟驗證人數
    private void GetMonthSignAuthData()
    {
        string aStr = "Select * from Month_SignUp";
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();
            List<MonthSignAuthData> ListData = new List<MonthSignAuthData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    MonthSignAuthData aData = new MonthSignAuthData();
                    aData.ID = int.Parse(aReader["ID"].ToString());
                    aData.TotalSignUp = int.Parse(aReader["TotalSignUp"].ToString());
                    aData.AuthNum = int.Parse(aReader["AuthNum"].ToString());
                    ListData.Add(aData);
                }
            }
            MonthSignAuthData[] SignAuthData;
            SignAuthData = ListData.ToArray();

            string jsonData = JsonConvert.SerializeObject(SignAuthData, Formatting.Indented);

            Response.Write(jsonData);
        }
    }

    public class AuthData
    {
        public int AuthKind;
        public int TotalCount;
    }

    //取得目前所有註冊帳號中，有收到信驗證的帳號跟未驗證的帳號
    private void GetAccountAuthData()
    {
        string aStr = "SELECT Auth as AuthKind, count(Auth) as TotalCount FROM AccountData GROUP BY Auth";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<AuthData> ListData = new List<AuthData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    AuthData aData = new AuthData();
                    aData.AuthKind = int.Parse(aReader["AuthKind"].ToString());
                    aData.TotalCount = int.Parse(aReader["TotalCount"].ToString());
                    ListData.Add(aData);
                }
            }
            AuthData[] AuthData3;
            AuthData3 = ListData.ToArray();

            string jsonData = JsonConvert.SerializeObject(AuthData3, Formatting.Indented);

            Response.Write(jsonData);
        }
    }

    //取得所有帳號某時間內登錄紀錄(可帶入參數判斷特定帳號)。
    private void GetAccountLoginData()
    {
        string aStr = "SELECT Auth as AuthKind, count(Auth) as TotalCount FROM AccountData GROUP BY Auth";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<AuthData> ListData = new List<AuthData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    AuthData aData = new AuthData();
                    aData.AuthKind = int.Parse(aReader["AuthKind"].ToString());
                    aData.TotalCount = int.Parse(aReader["TotalCount"].ToString());
                    ListData.Add(aData);
                }
            }
            AuthData[] AuthData3;
            AuthData3 = ListData.ToArray();

            string jsonData = JsonConvert.SerializeObject(AuthData3, Formatting.Indented);

            Response.Write(jsonData);
        }
    }

}