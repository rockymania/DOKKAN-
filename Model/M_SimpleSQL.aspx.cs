using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_SimpleSQL : System.Web.UI.Page
{
    public class AuthData
    {
        public int AuthKind;
        public int TotalCount;
    }

    public class SingleNumberData
    {
        public DateTime DataTime;
        public Int64 SingleNumber;
    }

    public class MessageBoardData
    {
        public string Account;
        public string MessageCount;
    }

    public class BuyData
    {
        public string ProductID;        //物品ID
        public string ProductCount;     //物品數量
        public string CardNumber;       //信用卡號碼
        public string BuyAddress;       //購買人地址
        public string BuyName;          //購買人姓名
        public string BuyPhone;         //購買人電話
        public string GetName;          //收件人姓名
        public string GetPhone;         //收件人電話
        public string GetAddress;       //收件人地址
        public string UserAccount;      //購買帳號
        public string SingleNumber;     //流水號
        public string RecTime;          //購買時間
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //GetBuyData();
            GetAccountAuthData();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private string[] BuyDataString = new string[]
   {
        "SELECT * FROM BuyData",                                                                //全部的資料
        "SELECT UserAccount, Count(SingleNumber) AS BuyCount FROM BuyData GROUP BY UserAccount",//取得所有帳號總購買紀錄
        "SELECT DISTINCT SingleNumber FROM BuyData",                                            //SQL語法查詢結果去除重複性資料
        "SELECT ProductID, sum(ProductCount) AS SaleCount FROM BuyData GROUP BY ProductID",      //取得所有商品總銷售量
        "SELECT ProductID, sum(ProductCount) AS SaleCount FROM BuyData WHERE RecTime >'2018-05-16' AND RecTime <'2018-05-17'　GROUP BY ProductID;",//取得某商品每一日的銷售數量

   };

    private void GetBuyData()
    {
        string aStr = "SELECT * FROM BuyData";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<BuyData> ListData = new List<BuyData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    BuyData aData = new BuyData();
                    aData.ProductID = aReader["ProductID"].ToString();
                    aData.ProductCount = aReader["ProductCount"].ToString();
                    aData.CardNumber = aReader["CardNumber"].ToString();
                    aData.BuyAddress = aReader["BuyAddress"].ToString();
                    aData.BuyName = aReader["BuyName"].ToString();
                    aData.BuyPhone = aReader["BuyPhone"].ToString();
                    aData.GetName = aReader["GetName"].ToString();
                    aData.GetPhone = aReader["GetPhone"].ToString();
                    aData.GetPhone = aReader["GetPhone"].ToString();
                    aData.GetAddress = aReader["GetAddress"].ToString();
                    aData.UserAccount = aReader["UserAccount"].ToString();
                    aData.SingleNumber = aReader["SingleNumber"].ToString();
                    aData.RecTime = aReader["RecTime"].ToString();
                    ListData.Add(aData);
                }
            }

            string zStr = string.Format("總共有{0}筆購買資料</br>", ListData.Count);
            //int aTotalCount = 0;
            //for (int i = 0; i < ListData.Count;i++)
            //{
            //    zStr += string.Format("{0}總共留言過[{1}]次</br>", ListData[i].Account, ListData[i].MessageCount);
            //    aTotalCount += int.Parse(ListData[i].MessageCount);
            //}

            //zStr += string.Format("總共有{0}則留言</br>", aTotalCount);

            Response.Write(zStr);
        }
    }

    private void GetMessageBoardData()
    {
        string aStr = "SELECT Account, Count(Account) AS MessageCount FROM MessageBoard GROUP BY Account";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<MessageBoardData> ListData = new List<MessageBoardData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    MessageBoardData aData = new MessageBoardData();
                    aData.Account = aReader["Account"].ToString();
                    aData.MessageCount = aReader["MessageCount"].ToString();
                    ListData.Add(aData);
                }
            }

            string zStr = string.Format("總共有{0}人留言過</br>", ListData.Count);
            int aTotalCount = 0;
            for (int i = 0; i < ListData.Count; i++)
            {
                zStr += string.Format("{0}總共留言過[{1}]次</br>", ListData[i].Account, ListData[i].MessageCount);
                aTotalCount += int.Parse(ListData[i].MessageCount);
            }

            zStr += string.Format("總共有{0}則留言</br>", aTotalCount);

            Response.Write(zStr);
        }
    }

    private void GetEveryDaySingleNumber()
    {
        //取得每一天的銷售訂單FORM singleNumberMgr
        string aStr = "SELECT * FROM SingleNumberMgr";

        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            aCon.Open();

            List<SingleNumberData> ListData = new List<SingleNumberData>();

            using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
            {
                SqlDataReader aReader = aCmd.ExecuteReader();

                while (aReader.Read())
                {
                    SingleNumberData aData = new SingleNumberData();
                    string aString = aReader["SingleNumber"].ToString();
                    aData.DataTime = DateTime.ParseExact(aString.Substring(0, 8), "yyyyMMdd", null, System.Globalization.DateTimeStyles.AllowWhiteSpaces);
                    aString = aString.Substring(8);
                    aData.SingleNumber = Int64.Parse(aString);
                    ListData.Add(aData);
                }
            }

            string zStr = "";

            for (int i = 0; i < ListData.Count; i++)
            {
                zStr += string.Format("{0}總共{1}組訂單</br>", ListData[i].DataTime.ToString("MM月dd日"), ListData[i].SingleNumber);
            }

            Response.Write(zStr);
        }
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
}