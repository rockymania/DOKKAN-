using System;
using Microsoft.Office.Interop.Excel;
using Application = Microsoft.Office.Interop.Excel.Application;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Backstage_Model_M_GetExcelProductData : System.Web.UI.Page
{
    public class ExcelData
    {
        public List<string> ProductID;
        public List<string> ProductName;
        public List<string> Price;

        public ExcelData()
        {
            ProductID = new List<string>();
            ProductName = new List<string>();
            Price = new List<string>();
        }
    }

    public class ExcelAllData
    {
        public string Result;
        public string[] ProductID;
        public string[] ProductName;
        public string[] Price;
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        ExcelData aExcelData = new ExcelData();
        ExcelAllData aExcelAllData = new ExcelAllData();
        string aJsonStr = string.Empty;

        if (Request.Files.AllKeys.Any())
        {
            HttpPostedFile aExcelFile = Request.Files["ExcelFile"];

            string aFileName = aExcelFile.FileName;

            string aPath = HttpContext.Current.Server.MapPath("~/Data/" + aFileName);

            aExcelFile.SaveAs(aPath);

            if (aExcelFile != null && aExcelFile.ContentLength != 0)
            {
                Application aExcelApp = new Microsoft.Office.Interop.Excel.Application();

                Workbook aWorkbook = aExcelApp.Workbooks.Open(aPath, 0, false, 5, "", "", false, XlPlatform.xlWindows, "", true, false, 0, true, false, false);

                Sheets aSheet = aWorkbook.Worksheets;
                //取得第一個sheet
                Worksheet aWorkSheet = (Worksheet)aSheet.get_Item(1);

                Range aRange = aWorkSheet.UsedRange;
                //取出行列數
                int aRow = aRange.Rows.Count;
                int aColumns = aRange.Columns.Count;

                try
                {
                    for (int i = 2; i <= aRow; i++)
                    {
                        aExcelData.ProductID.Add(((Range)aWorkSheet.Cells[i, 1]).Value2.ToString());
                        aExcelData.ProductName.Add(((Range)aWorkSheet.Cells[i, 3]).Value2.ToString());
                        aExcelData.Price.Add(((Range)aWorkSheet.Cells[i, 7]).Value2.ToString());
                    }
                    aWorkbook.Close();
                    File.Delete(aPath);
                }
                catch
                {
                    aWorkbook.Close();
                    File.Delete(aPath);
                    aExcelAllData.Result = "3";
                    aJsonStr = JsonConvert.SerializeObject(aExcelAllData);
                    Response.Write(aJsonStr);
                }

                aExcelAllData.Result = "0";
                aExcelAllData.Price = aExcelData.Price.ToArray();
                aExcelAllData.ProductName = aExcelData.ProductName.ToArray();
                aExcelAllData.ProductID = aExcelData.ProductID.ToArray();

                aJsonStr = JsonConvert.SerializeObject(aExcelAllData);
                Response.Write(aJsonStr);
            }
            else
            {
                aExcelAllData.Result = "2";
                aJsonStr = JsonConvert.SerializeObject(aExcelAllData);
                Response.Write(aJsonStr);
            }
                
            }
        else
        {
            aExcelAllData.Result = "2";
            //沒有檔案或是檔案有問題
            aJsonStr = JsonConvert.SerializeObject(aExcelAllData);
            Response.Write(aJsonStr);
        }
    }
}