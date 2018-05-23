using System;
using Microsoft.Office.Interop.Excel;
using Application = Microsoft.Office.Interop.Excel.Application;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Backstage_Model_M_GetExcelProductData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Files.AllKeys.Any())
        {
            HttpPostedFile aExcelFile = Request.Files["ExcelFile"];

            string aFileName = aExcelFile.FileName;

            string path = HttpContext.Current.Server.MapPath("~/Data/" + aFileName);
            aExcelFile.SaveAs(path);



            if (aExcelFile != null && aExcelFile.ContentLength != 0)
            {
                Application ExcelApp = new Microsoft.Office.Interop.Excel.Application();

                Workbook oWorkbook = ExcelApp.Workbooks.Open(path, 0, false, 5, "", "", false, XlPlatform.xlWindows, "", true, false, 0, true, false, false);

                Response.Write("0");
                oWorkbook.Close();
                File.Delete(path);
            }
            else
                Response.Write("2");
        }
        else
        {
            //沒有檔案或是檔案有問題
            Response.Write("1");
        }
    }
}