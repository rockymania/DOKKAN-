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
        public string Status;
        public string Report;
    }
    private string CreateString = "<table class=\"Toptable\">" +
                                   "<tr class=\"Messagetable\">" +
                                   "<td><b>回報人:{0}</b></td>" +
                                   "<td> 回報時間:{1}</td>" +
                                   "</tr>" +
                                   "<tr>" +
                                   "<td><b>回報內容:{2}</b></td>" +
                                   "</tr>" +
                                   "<tr>"+
                                   "<td {3}><hr><b>{4}</b></td>"+
                                   "</tr>"+
                                   "</table>";
    private string AddClass = "class=\"ReportMessage\"";
    //取得留言板資料。
    protected void Page_Load(object sender, EventArgs e)
    {
        int aPage = 0;
        string aKind = "";// 0;
        string aAccount;
        try
        {
            aKind = Request.QueryString["Kind"].ToString();
            aAccount = Request.QueryString["Account"];

            if (aKind == "1")
            {
                int aTotalCount = 0;
                string bStr = "SELECT COUNT(*) as TotalCount FROM MessageBoard";// Where Account = '{0}'";

                bStr = string.Format(bStr, aAccount);

                using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
                {
                    aCon.Open();
                    using (SqlCommand bCmd = new SqlCommand(bStr, aCon))
                    {
                        SqlDataReader bDataReader = bCmd.ExecuteReader();

                        while (bDataReader.Read())
                        {
                            aTotalCount = int.Parse(bDataReader["TotalCount"].ToString());
                        }
                    }
                }
                Response.Write(aTotalCount);
            }
            else {
                aPage = int.Parse(Request.QueryString["Page"].ToString());
                aAccount = Request.QueryString["Account"];

                string aDataStart = ((aPage - 1) * 5 + 1).ToString();
                string aDataEnd = ((aPage - 1) * 5 + 5).ToString();


                //string aStr = "SELECT* FROM(SELECT*, ROW_NUMBER() OVER (ORDER BY ID) as ROWNUM FROM" +
                //              " (SELECT * FROM MessageBoard Where Account = '{0}')a)b" +
                //              " WHERE b.ROWNUM >= '{1}' and b.ROWNUM <= '{2}'";
                string aStr = "SELECT* FROM(SELECT*, ROW_NUMBER() OVER (ORDER BY ID) as ROWNUM FROM" +
                              " (SELECT * FROM MessageBoard)a)b" +
                              " WHERE b.ROWNUM >= '{0}' and b.ROWNUM <= '{1}'";

                //string aStr = "SELECT * FROM(SELECT*, ROW_NUMBER() OVER (ORDER BY ID) as ROWNUM FROM MessageBoard) " +
                //              "a WHERE ROWNUM >= {0} and ROWNUM <= {1} AND Account = '"+ aAccount+"'";

                aStr = string.Format(aStr, aDataStart, aDataEnd);
                //aStr = string.Format(aStr, aAccount, aDataStart, aDataEnd);

                List<MessageData> ListData = new List<MessageData>();

                using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
                {
                    aCon.Open();
                    using (SqlCommand aCmd = new SqlCommand(aStr, aCon))
                    {
                        SqlDataReader aDataReader = aCmd.ExecuteReader();

                        while (aDataReader.Read())
                        {
                            MessageData aData = new MessageData();
                            aData.Name = aDataReader["Name"].ToString();
                            aData.Email = aDataReader["Email"].ToString();
                            aData.Message = aDataReader["Message"].ToString();
                            aData.Phone = aDataReader["Phone"].ToString();
                            aData.DateTime = aDataReader["DateTime"].ToString();
                            aData.Status = aDataReader["Status"].ToString();
                            aData.Report = aDataReader["Report"].ToString();
                            ListData.Add(aData);
                        }
                    }

                    string jsonData = "";

                    for (int i = 0; i < ListData.Count; i++)
                    {
                        if (ListData[i].Status == "1")
                            jsonData += string.Format(CreateString, ListData[i].Name, ListData[i].DateTime, ListData[i].Message, AddClass, ListData[i].Report);
                        else
                            jsonData += string.Format(CreateString, ListData[i].Name, ListData[i].DateTime, ListData[i].Message, "","");
                    }

                    Response.Write(jsonData);
                }
            }


        }
        catch(Exception ex)
        {
            Response.Write(ex);
        }
    }
}