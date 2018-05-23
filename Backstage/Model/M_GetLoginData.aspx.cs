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
        int aLoginCondition = 0;
        string aAccount;
        DateTime aDateFrom;
        string aFrom;
        DateTime aDateTo;
        string aTo;
        int aKind;

        try
        {
            aLoginValue = int.Parse(Request.QueryString["LoginValue"].ToString());
            aLoginCondition = int.Parse(Request.QueryString["LoginCondition"].ToString());
            aAccount = Request["Account"].ToString();
            aDateFrom = DateTime.Parse(Request["DateFrom"].ToString());
            aFrom = aDateFrom.ToString("yyyy-MM-dd");
            aDateTo = DateTime.Parse(Request["DateTo"].ToString());
            aTo = aDateTo.ToString("yyyy-MM-dd");
            aKind = int.Parse(Request.QueryString["Kind"].ToString());

            switch (aLoginValue)
            {
                case 1:
                    GetMonthSignAuthData(aKind);
                    break;
                case 2:
                    GetAccountAuthData(aKind);
                    break;
                case 3:
                    GetAccountLoginData(aLoginCondition, aAccount, aFrom, aTo);
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

    public class AllMonthSignData
    {
        public int total;
        public MonthSignAuthData[] rows;
        public MonthSign_FooterData[] footer;
    }

    public class MonthSign_FooterData
    {
        public int TotalSignUp;
        public int AuthNum;
        public string Rate;
    }

    //取得每個月的帳號註冊人數跟驗證人數
    private void GetMonthSignAuthData(int iKind)
    {
        string aStr = "Select * from Month_SignUp";
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();
            List<MonthSignAuthData> ListData = new List<MonthSignAuthData>();
            List<MonthSign_FooterData> Footer = new List<MonthSign_FooterData>();
            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();
                MonthSign_FooterData aFooter = new MonthSign_FooterData();
                while (aReader.Read())
                {
                    MonthSignAuthData aData = new MonthSignAuthData();
                    aData.ID = int.Parse(aReader["ID"].ToString());
                    aData.TotalSignUp = int.Parse(aReader["TotalSignUp"].ToString());
                    aFooter.TotalSignUp += aData.TotalSignUp;
                    aData.AuthNum = int.Parse(aReader["AuthNum"].ToString());
                    aFooter.AuthNum += aData.AuthNum;
                    ListData.Add(aData);
                }
                aFooter.Rate = Math.Round(Math.Abs(aFooter.AuthNum) / 1F / Math.Abs(aFooter.TotalSignUp) / 1F * 100F, 2) + "%";
                Footer.Add(aFooter);
                aReader.Close();
            }
            if(iKind == 1)
            {
                MonthSignAuthData[] SignAuthData;
                SignAuthData = ListData.ToArray();

                string jsonData = JsonConvert.SerializeObject(SignAuthData, Formatting.Indented);

                Response.Write(jsonData);
            }
            else
            {
                AllMonthSignData aResult = new AllMonthSignData();
                aResult.rows = ListData.ToArray();
                aResult.footer = Footer.ToArray();
                string json_data = JsonConvert.SerializeObject(aResult, Formatting.Indented);
                Response.Write(json_data);
            }
            
        }
    }

    public class AuthData
    {
        public int AuthKind;
        public int TotalCount;
        public string AuthString;
    }

    public class AllAuthData
    {
        public int total;
        public AuthData[] rows;
        public Account_FooterData[] footer;
    }

    public class Account_FooterData
    {
        public int TotalCount;
    }

    //取得目前所有註冊帳號中，有收到信驗證的帳號跟未驗證的帳號
    private void GetAccountAuthData(int iKind)
    {
        string aStr = "SELECT Auth as AuthKind, count(Auth) as TotalCount FROM AccountData GROUP BY Auth";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<AuthData> ListData = new List<AuthData>();
            List<Account_FooterData> Footer = new List<Account_FooterData>();
            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();
                Account_FooterData aFooter = new Account_FooterData();
                while (aReader.Read())
                {
                    AuthData aData = new AuthData();
                    
                    aData.AuthKind = int.Parse(aReader["AuthKind"].ToString());
                    if (aData.AuthKind == 0)
                        aData.AuthString = "未驗證人數";
                    else
                        aData.AuthString = "已驗證人數";
                    aData.TotalCount = int.Parse(aReader["TotalCount"].ToString());
                    aFooter.TotalCount += aData.TotalCount;
                    ListData.Add(aData);
                }
                Footer.Add(aFooter);
                aReader.Close();
            }

            if (iKind==1)
            {
                AuthData[] AuthData3;
                AuthData3 = ListData.ToArray();
                string jsonData = JsonConvert.SerializeObject(AuthData3, Formatting.Indented);
                Response.Write(jsonData);
            }
            else
            {
                AllAuthData aResult = new AllAuthData();
                aResult.rows = ListData.ToArray();
                aResult.footer = Footer.ToArray();
                string json_data = JsonConvert.SerializeObject(aResult, Formatting.Indented);
                Response.Write(json_data);
            }
        }
    }

    public class AccountLoginData
    {
        public string Account;
        public string IP;
        public string LoginTime;
    }

    //取得所有帳號某時間內登錄紀錄(可帶入參數判斷特定帳號)。
    private void GetAccountLoginData(int iKind, string iAccount, string iDateFrom, string iDateTo)
    {
        string aStr = string.Empty;
        if (iKind == 101)//透過時間以及帳號
        {
            if (iAccount == string.Empty) { Response.Write("101"); return; }

            aStr = "select * from LoginAnalysis WHERE Account = '{0}' AND LoginTime >= '{1}' AND LoginTime< '{2}'";

            aStr = string.Format(aStr, iAccount, iDateFrom, iDateTo);
        }
        else if (iKind == 102)//僅透過時間
        {
            aStr = "select * from LoginAnalysis WHERE LoginTime >= '{0}' AND LoginTime< '{1}'";

            aStr = string.Format(aStr, iDateFrom, iDateTo);
        }
        else if (iKind == 103)//僅透過帳號
        {
            if (iAccount == string.Empty) { Response.Write("101"); return; }

            aStr = "select * from LoginAnalysis WHERE Account = '{0}'";

            aStr = string.Format(aStr, iAccount);
        }

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<AccountLoginData> ListData = new List<AccountLoginData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    AccountLoginData aData = new AccountLoginData();
                    aData.Account = aReader["Account"].ToString();
                    aData.IP = aReader["IP"].ToString();
                    aData.LoginTime = aReader["LoginTime"].ToString();
                    ListData.Add(aData);
                }
            }
            AccountLoginData[] AuthData3;
            AuthData3 = ListData.ToArray();

            string jsonData = JsonConvert.SerializeObject(AuthData3, Formatting.Indented);

            Response.Write(jsonData);
        }
    }

}