using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Model_M_GetMessageBoard : System.Web.UI.Page
{

    public class MessageData
    {
        public string Name;
        public string Email;
        public string Phone;
        public string Message;
        public string DateTime;
    }
    private string CreateString = "<table style=\"width:800px;\">"+
                                   "<tr class=\"Messagetable\">" +
                                   "<td><b>回報人:{0}</b></td>" +
                                   "<td> 回報時間:{1}</td>" +
                                   "</tr>" +
                                   "<tr>" +
                                   "<td><b>回報內容:{2}</b></td>" +
                                   "</tr>" +
                                   "</table>";
    //取得留言板資料。
    protected void Page_Load(object sender, EventArgs e)
    {
        int aPage = 0;

        try
        {
            aPage = int.Parse(Request.QueryString["Page"].ToString());

            string aDataStart = ((aPage-1) * 5 + 1).ToString();
            string aDataEnd = aDataStart + 5;

            string aStr = "SELECT * FROM(SELECT*, ROW_NUMBER() OVER (ORDER BY ID) as ROWNUM FROM MessageBoard) " +
                          "a WHERE ROWNUM >= {0} and ROWNUM <= {1}";

            aStr = string.Format(aStr, aDataStart, aDataEnd);

            List<MessageData> ListData = new List<MessageData>();

            using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
            {
                aCon.Open();
                using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
                {
                    SqlDataReader aDataReader = aCmd.ExecuteReader();

                    while(aDataReader.Read())
                    {
                        MessageData aData = new MessageData();
                        aData.Name = aDataReader["Name"].ToString();
                        aData.Email = aDataReader["Email"].ToString();
                        aData.Message = aDataReader["Message"].ToString();
                        aData.Phone = aDataReader["Phone"].ToString();
                        aData.DateTime = aDataReader["DateTime"].ToString();

                        ListData.Add(aData);
                    }
                }

                string jsonData = "";

                for(int i = 0; i < ListData.Count;i++)
                {
                    jsonData += string.Format(CreateString, ListData[i].Name, ListData[i].DateTime, ListData[i].Message);
                }

                Response.Write(jsonData);
            }

        }
        catch(Exception ex)
        {
            Response.Write(ex);
        }
    }
}