using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using Newtonsoft.Json;
using System.Text;

public partial class Model_M_GetOrder : System.Web.UI.Page
{
    public class OrderHistory
    {
        //public string UserAccount;
        public string ProductID;
        public string ProductCount;
        public string SingleNumber;
        public string RecTime;
    }

    public class ProductData
    {
        public string ProductName;
        public int TotalPrice;
    }

    public class ShopCarData
    {
        public string ID;               //ID
        public string ProductName;      //商品名稱
        public string ProductUrl;       //商品連結
        public string Price;            //商品價格
    }

    private string CreateString = "<tr class=\"OrderTr\">" +
                    "<td>{0}</td>" +
                    "<td>{1}</td>" +
                    "<td>{2}</td>" +
                    "<td>{3}</td>" +
                    "<td>{4}</td>" +
                    "</tr>";

    private string BaseStr = "<table id=\"TopTable\">" + 
                          "<tr id=\"TopTr\" class=\"OrderTr\">" +
                          "<td style = \"width:400px\">訂單標號</td>" +
                          "<td style = \"width:200px\">日期</td>" +
                          "<td style = \"width:80px\">狀態</td>" +
                          "<td style = \"width:80px\">總價</td>" +
                          "<td style = \"width:40px\">其他</td>" +
                          "</tr>";

    private string EndStr = "</table>";

    private string SliderStr =  "<tr class=\"DetailTr\">" +
                                "<td style = \"width:400px\" >{0}</td>"+
                                "<td style = \"width:120px\" >{1}</td>" +
                                "<td style = \"width:120px\" >{2}</td>" +
                                "<td style = \"width:80px\" >{3}</td>" +
                                "<td style = \"width:80px\" >{4}</td>" +
                                "</tr>";

    private string SlidetBtn = "<button onclick=\"Test({0});\">詳細訂單</button>";
    private string SliderTop = "<div id =\"{0}\" class=\"SliderP\"> <table style=\"width:800px\">";
    private string SlidetEnd = "</div>";

    private string LoadDataPath = "Data/ProductData.txt";

    protected void Page_Load(object sender, EventArgs e)
    {
        //語法
        string aStr = "Select * FROM BuyData";

        //準備連線
        using (SqlConnection aCon = new SqlConnection("Data Source=184.168.47.10;Integrated Security=False;User ID=MobileDaddy;PASSWORD=Aa54380438!;Connect Timeout=15;Encrypt=False;Packet Size=4096"))
        {
            //連線成功打開
            aCon.Open();
            //準備要做的事情
            using (SqlCommand aComm = new SqlCommand(aStr, aCon))
            {
                //讀檔
                SqlDataReader aDataReader = aComm.ExecuteReader();

                List<OrderHistory> ListData = new List<OrderHistory>();

                int[] OrderTotalMoney;

                while (aDataReader.Read())
                {
                    OrderHistory aData = new OrderHistory();
                    aData.ProductID = aDataReader["ProductID"].ToString();
                    aData.ProductCount = aDataReader["ProductCount"].ToString();
                    aData.SingleNumber = aDataReader["SingleNumber"].ToString();
                    aData.RecTime = aDataReader["RecTime"].ToString();

                    ListData.Add(aData);
                }

                //這個LIST有所有這個玩家的資料。要分成 A.單號 (Only One) ListData==(Total)
                List<OrderHistory> aList = new List<OrderHistory>();
                bool Insert = true;
                for(int i = 0; i < ListData.Count; i++)
                {
                    //如果沒有資料，就塞第一筆資料進去
                    if (aList.Count == 0)
                        aList.Add(ListData[i]);
                    //開始判斷要塞進去的資料跟已經存起來的資料是否相同
                    for (int j = 0; j < aList.Count;j++)
                    {
                        if (aList[j].SingleNumber == ListData[i].SingleNumber)
                        {
                            //如果有一筆資料相同的話，
                            Insert = false;
                        }
                    }

                    if (Insert != false)
                        aList.Add(ListData[i]);
                    Insert = true;
                }

                OrderTotalMoney = new int[aList.Count];

                //塞總金額
                for (int i = 0; i < aList.Count; i++)
                {
                    for (int j = 0; j < ListData.Count; j++)
                    {
                        if (aList[i].SingleNumber == ListData[j].SingleNumber)
                        {
                            OrderTotalMoney[i] += GetTotalPrice(ListData[j]);
                        }
                    }
                }


                string jsonData = "";
                ProductData bData = new ProductData();
                //要先塞一筆ALIST的資料。在塞入LISTDATA 相對應的資料。
                for (int i = 0; i <aList.Count;i++)
                {

                    jsonData += BaseStr;
                    jsonData += string.Format(CreateString, aList[i].SingleNumber, aList[i].RecTime, aList[i].ProductID, OrderTotalMoney[i].ToString(), "");
                    jsonData += EndStr;

                    jsonData += string.Format(SliderTop, aList[i].SingleNumber);

                    for (int j = 0; j < ListData.Count; j++)
                    {
                        if (aList[i].SingleNumber == ListData[j].SingleNumber)
                        {
                            bData = GetData(ListData[j]);

                            jsonData += string.Format(SliderStr, bData.ProductName, ListData[j].ProductCount, bData.TotalPrice, "", "");
                        }
                    }
                    jsonData += EndStr;
                    jsonData += SlidetEnd;
                    jsonData += string.Format(SlidetBtn, aList[i].SingleNumber);
                }



                //for (int i = 0; i < ListData.Count; i++)
                //{
                //    jsonData += BaseStr;
                //    jsonData += string.Format(CreateString, ListData[i].SingleNumber, ListData[i].RecTime, ListData[i].ProductID, ListData[i].ProductCount,"");
                //    jsonData += EndStr;
                //    jsonData += string.Format(SliderStr, ListData[i].SingleNumber, ListData[i].SingleNumber);
                //}

                Response.Write(jsonData);
            }
        }
    }

    private bool GetIsDebug()
    {
        bool isLocal = HttpContext.Current.Request.IsLocal;
        if (!isLocal)
        {
            //記錄資料1
            return false;
        }
        return true;
    }

    private int GetTotalPrice(OrderHistory iProdectData)
    {
        ShopCarData[] mData;
        string CheckPath = "~";
        int TotalPrice = 0;
        if (GetIsDebug() == false)
            CheckPath = "~/Dokkan/";

        using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath, Encoding.UTF8))
        {
            string str = sr.ReadToEnd();
            mData = JsonConvert.DeserializeObject<ShopCarData[]>(str);
        }

        for (int i = 0; i < mData.Length; i++)
        {
            if (mData[i].ID == iProdectData.ProductID)
            {
                TotalPrice =int.Parse(iProdectData.ProductCount) * int.Parse(mData[i].Price);
                return TotalPrice;
            }
        }

        return 0;
    }

    private ProductData GetData(OrderHistory iProdectData)
    {
        ShopCarData[] mData;
        ProductData TempData = new ProductData();
        string CheckPath = "~";

        if (GetIsDebug() == false)
            CheckPath = "~/Dokkan/";

        using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath, Encoding.UTF8))
        {
            string str = sr.ReadToEnd();
            mData = JsonConvert.DeserializeObject<ShopCarData[]>(str);
        }

        for(int i = 0; i < mData.Length; i++)
        {
            if (mData[i].ID == iProdectData.ProductID)
            {
                TempData.ProductName = mData[i].ProductName;
                TempData.TotalPrice = int.Parse(iProdectData.ProductCount) * int.Parse(mData[i].Price);
                break;
            }
        }

        return TempData;
    }
}