using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Model_M_GetProduct : System.Web.UI.Page
{
    public class ProductData
    {
        public string ProductName;
        public string ProductUrl;
        public string ProductImage;
        public int ProductID;
    }

    private string LoadDataPath = "Data/ProductData";
    private string LoadDataEnd = ".txt";
    private string CreateString = "<table class=\"TableItem\"><tr><td><p><a href=\"{0}\"><img src=\"{1}\"/> </a> <a href=\"{2}\"> <p>{3}</p></p></td></tr></table>";

    protected void Page_Load(object sender, EventArgs e)
    {

        string aKind = "";

        try
        {
            aKind = Request.QueryString["Kind"];


            ProductData[] mData;
            string json_Data = "";
            string CheckPath = "~";
            if (GetIsDebug() == false)
                CheckPath = "~/Dokkan/";

            using (StreamReader sr = new StreamReader(Server.MapPath(CheckPath) + LoadDataPath + aKind + LoadDataEnd, Encoding.UTF8))
            {
                string str = sr.ReadToEnd();
                mData = JsonConvert.DeserializeObject<ProductData[]>(str);
            }


            for (int i = 0; i < mData.Length; i++)
            {
                json_Data += string.Format(CreateString, mData[i].ProductUrl, mData[i].ProductImage, mData[i].ProductUrl, mData[i].ProductName);
            }

            Response.Write(json_Data);
        }
        catch
        {

        }


        



        //string[] stringArray = new string[(mData.Length / 3) + 1];
        //for (int i = 0, j = 0; i < mData.Length; i++)
        //{
        //    stringArray[j] += string.Format(CreateString, mData[i].ProductUrl, mData[i].ProductImage, mData[i].ProductUrl, mData[i].ProductName);

        //    if (i % 3 == 2)
        //        j++;
        //}
        //string FinalString = "";
        //for (int i = 0; i < stringArray.Length; i++)
        //{
        //    FinalString += string.Format("<tr>{0}</tr>", stringArray[i]);
        //}
        //Response.Write(FinalString);
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
}