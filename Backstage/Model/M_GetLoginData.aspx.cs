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
    public class AuthData
    {
        public int AuthKind;
        public int TotalCount;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        int aLoginValue = 0;

        try
        {
            aLoginValue = int.Parse(Request.QueryString["LoginValue"].ToString());

            string aResult = "";

            switch(aLoginValue)
            {
                case 1:
                    aResult = GetAccountAuthData();
                    break;
                case 2:
                    aResult = GetAccountAuthData();
                    break;
            }

            //GetBuyData();
            Response.Write(aResult);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    //取得目前所有註冊帳號中，有收到信驗證的帳號跟未驗證的帳號
    private string GetAccountAuthData()
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

            return jsonData;
            //Response.Write(jsonData);

            //string zStr = string.Format("總共有{0}組</br>", ListData.Count);

            //for (int i = 0; i < ListData.Count; i++)
            //{
            //    if (ListData[i].AuthKind == 0)
            //        zStr += string.Format("尚未驗證資料總共{0}組</br>", ListData[i].TotalCount);
            //    else
            //        zStr += string.Format("已驗證資料總共{0}組", ListData[i].TotalCount);
            //}

            //Response.Write(zStr);
        }
    }

}