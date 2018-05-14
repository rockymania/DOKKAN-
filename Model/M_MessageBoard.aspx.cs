using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_MessageBoard : System.Web.UI.Page
{
    public class MessageData
    {
        public string Name;
        public string Email;
        public string Phone;
        public string Message;
        public string NowTime;

        public MessageData(string iName,string iEamil,string iPhone,string iMessage, string iNowTime)
        {
            Name = iName;
            Email = iEamil;
            Phone = iPhone;
            Message = iMessage;
            iNowTime = NowTime;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        string aName = Request.QueryString["Name"];
        string aEmail = Request.QueryString["Email"];
        string aPhone = Request.QueryString["Phone"];
        string aMessage = Request.QueryString["Message"];
        string aTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        string aAccount = Request.QueryString["Account"];

        MessageData aData = new MessageData(aName, aEmail, aPhone, aMessage, aTime);

        try
        {
            string vStr = "INSERT INTO MessageBoard(Account,Name,Email,Phone,Message,DateTime) VALUES(N'" + aAccount + "'," + "N'" + aData.Name +
                            "','" + aData.Email + "','" + aData.Phone + "',N'" + aData.Message + "','" + aTime + " ')";

            using (SqlConnection vCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                vCon.Open();
                using (SqlCommand vCmd = new SqlCommand(vStr, vCon))
                {
                    vCmd.ExecuteNonQuery();
                }
            }
            Response.Write("0");
        }
        catch (Exception ex)
        {
            Response.Write("1");
        }

    }
}