using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Data.SqlClient;

public partial class Backstage_Model_M_GetMessageBoardData : System.Web.UI.Page
{

    public class MessageData
    {
        public string ID;
        public string Name;
        public string Email;
        public string Phone;
        public string Message;
        public string DateTime;
        public string Status;
        public string Report;
    }

    private int mKind = 0;
    private int mSearchKind = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        mKind = int.Parse(Request.QueryString["Kind"].ToString());
        mSearchKind = int.Parse(Request.QueryString["SearchKind"].ToString());

        if (mKind == 1)
        {
            //取得資料
            string aStr = "";
            if (mSearchKind == 0)
                aStr = "SELECT * from MessageBoard order by Status Desc , DateTime Asc";
            else if (mSearchKind == 1)
                aStr = "SELECT * from MessageBoard where status = '1' order by Status Desc , DateTime Asc"; 
            else
                aStr = "SELECT * from MessageBoard where status = '0' order by Status Desc , DateTime Asc"; 


            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();

                List<MessageData> ListData = new List<MessageData>();

                using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
                {
                    SqlDataReader aDataReader = aCmd.ExecuteReader();

                    while (aDataReader.Read())
                    {
                        MessageData aData = new MessageData();
                        aData.ID = aDataReader["ID"].ToString();
                        aData.Name = aDataReader["Name"].ToString();
                        aData.Email = aDataReader["Email"].ToString();
                        aData.Message = aDataReader["Message"].ToString();
                        aData.Phone = aDataReader["Phone"].ToString();
                        aData.DateTime = aDataReader["DateTime"].ToString();
                        aData.Status = aDataReader["Status"].ToString();
                        if (aData.Status == "0")
                            aData.Status = "處理中";
                        else if (aData.Status == "1")
                            aData.Status = "已回覆";

                        aData.Report = aDataReader["Report"].ToString();
                        ListData.Add(aData);
                    }
                    aDataReader.Close();
                }

                MessageData[] SignAuthData;
                SignAuthData = ListData.ToArray();

                string jsonData = JsonConvert.SerializeObject(SignAuthData, Formatting.Indented);

                Response.Write(jsonData);
            }
        }
        else
        {
            try
            {
                //修改資料UPDATE  MessageBoard Set Status = 0 , Report = N'等待回覆'
                string aStr = "UPDATE  MessageBoard Set Status = 1 ,  Report = N'{0}' Where ID = {1}";

                string aStatus = Request.QueryString["Status"].ToString();
                string aReport = Request.QueryString["Report"].ToString();
                string aID = Request.QueryString["ID"].ToString();

                aStr = string.Format(aStr, aReport, aID);

                using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
                {
                    aCon.Open();

                    using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
                    {
                        aCmd.ExecuteNonQuery();
                    }
                    Response.Write("0");
                }
            }
            catch
            {
                Response.Write("1");
            }
        }
    }
}